import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:starbucksecret/configuration.dart';
import 'package:starbucksecret/dao/menu_dao.dart';
import 'package:starbucksecret/models/Menu.dart';
import 'package:starbucksecret/views/components/menu_title.dart';
import 'package:starbucksecret/views/components/ingredients_view.dart';
import 'package:starbucksecret/views/components/description_view.dart';

class DetailMenu extends StatefulWidget {
  final String id;
  DetailMenu({Key key, this.id}) : super(key: key);
  @override
  _DetailMenuState createState() => _DetailMenuState();
}

class _DetailMenuState extends State<DetailMenu>
    with SingleTickerProviderStateMixin {
  MenuDao _query = new MenuDao();
  ScrollController _scrollController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      // Added
      length: 2, // Added
      initialIndex: 0,
      child: StreamBuilder(
        stream: _query.getMenus(widget.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var document = snapshot.data;
          return NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerViewIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 16.0 / 9.0,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: document['imgurl'],
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          MenuTitle(
                              Menu.fromQueryDocumentSnapshot(document), 25.0),
                        ],
                      ),
                    ),
                    expandedHeight: 340.0,
                    pinned: true,
                    floating: true,
                    elevation: 2.0,
                    forceElevated: innerViewIsScrolled,
                    bottom: TabBar(
                      unselectedLabelColor: grayColor,
                      labelColor: colorPrimaryDark,
                      indicatorWeight: 2,
                      indicatorColor: colorPrimaryDark,
                      tabs: <Widget>[
                        Tab(text: "Description"),
                        Tab(text: "Recipe"),
                      ],
                      controller: _tabController,
                    ),
                  )
                ];
              },
              body: TabBarView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  DescriptionView(document['description']),
                  IngredientsView(document['recipe']),
                ],
                controller: _tabController,
              ));
        },
      ),
    ));
  }
}
