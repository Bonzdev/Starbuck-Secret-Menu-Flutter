import 'dart:math';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:starbucksecret/configuration.dart';
import 'package:starbucksecret/dao/menu_dao.dart';
import 'package:starbucksecret/helpers/global_helper.dart';

import 'components/carousel.dart';
import 'components/grid_home.dart';
import 'components/top_home.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = new TextEditingController();
  MenuDao _query = new MenuDao();
  List<String> listID = [];
  String search = '';

  @override
  void initState() {
    super.initState();
    _query.ambilData().then((value) => {
          value.forEach((element) {
            listID.add(element['id']);
          })
        });
  }

  onSearchTextChanged(String text) async {
    setState(() {
      search = text.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FabCircularMenu(
            ringColor: colorPrimaryDark,
            fabOpenIcon: Icon(Icons.menu, color: Colors.white),
            fabCloseIcon: Icon(Icons.close, color: Colors.white),
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.help_outline, color: Colors.white),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                            title: Text('Share your recipe'),
                            content: RichText(
                              text: new TextSpan(
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  new TextSpan(
                                      text:
                                          'If you have a secret recipe you’d like to share, send it to '),
                                  new TextSpan(
                                      text: 'hi@medanincode.com',
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: colorPrimaryDark)),
                                  new TextSpan(
                                      text:
                                          '. Attach a photo if you have one.'),
                                ],
                              ),
                            )));
                  }),
              IconButton(
                  icon: Icon(Icons.casino, color: Colors.white),
                  onPressed: () {
                    // random menu
                    var random = new Random();
                    var randomID = listID[random.nextInt(listID.length)];
                    Navigator.pushNamed(context, '/menu-detail',
                        arguments: randomID);
                  }),
              IconButton(
                  icon: Icon(
                    Icons.local_cafe_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    launchURL("https://www.buymeacoffee.com/secretsrecipe");
                  }),
            ]),
        appBar: null,
        body: CustomScrollView(physics: PageScrollPhysics(), slivers: <Widget>[
          SliverAppBar(
            floating: false,
            pinned: true,
            expandedHeight: 150,
            // collapsedHeight: 150,
            title: Text('Good Morning'),
            actions: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/originals/da/51/c2/da51c26fe3398b0f8314fee17a98e0e7.jpg'),
              ),
              SizedBox(width: 10.0),
            ],
            flexibleSpace: FlexibleSpaceBar(background: TopHome()),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Carousel(), GridDashboard()],
              );
            }, childCount: 1),
          )
        ]));
  }
}
