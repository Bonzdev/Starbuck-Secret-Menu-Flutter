import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:starbucksecret/configuration.dart';
import 'package:starbucksecret/dao/menuDao.dart';
import 'package:starbucksecret/models/Menu.dart';
import 'package:starbucksecret/views/components/menu_title.dart';

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
  final _menusRef = FirebaseDatabase.instance.reference().child('menus');
  String _title = "";
  String _description = "";
  String _no = "";
  Image theImage;

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
    // var data = _query.getMenu(widget.id);

    setState(() {
      // theImage = Image.network(
      //   data.imgUrl,
      //   fit: BoxFit.cover,
      // );
      // precacheImage(theImage.image, context);
      // _title = data.name;
      // _description = data.description;
    });
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
                            child: Image.network(
                              document['imgurl'],
                              fit: BoxFit.cover,
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

class IngredientsView extends StatelessWidget {
  final List<dynamic> ingredients;

  IngredientsView(this.ingredients);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = new List<Widget>();
    ingredients.forEach((item) {
      children.add(
        Row(
          children: <Widget>[
            new Icon(Icons.done),
            new SizedBox(width: 5.0),
            Expanded(child: Text(item)),
          ],
        ),
      );
      // Add spacing between the lines:
      children.add(
        new SizedBox(
          height: 5.0,
        ),
      );
    });
    return SafeArea(
        top: false,
        bottom: false,
        child: ListView(
          padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 75.0),
          children: children,
        ));
  }
}

class DescriptionView extends StatelessWidget {
  final String description;

  DescriptionView(this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 75.0),
      child: Text(description),
    );
  }
}
