import 'dart:math';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:starbucksecret/configuration.dart';
import 'package:starbucksecret/dao/menu_dao.dart';
import 'package:starbucksecret/helpers/global_helper.dart';
import 'package:starbucksecret/views/components/carousel.dart';

import 'components/grid_home.dart';
import 'components/top_home.dart';

class Home2Page extends StatefulWidget {
  Home2Page({Key key}) : super(key: key);
  @override
  _Home2PageState createState() => _Home2PageState();
}

class _Home2PageState extends State<Home2Page> {
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
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(color: Colors.green),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [TopHome(), Carousel(), GridDashboard()],
              ))
            ]),
          ),
        ]));
  }
}

// CustomPainter class to for the header curved-container
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = colorPrimaryDark;
    Path path = Path()
      ..relativeLineTo(0, 200)
      ..quadraticBezierTo(size.width / 2, 300.0, size.width, 200)
      ..relativeLineTo(0, -200)
      ..close();
    var rect = Offset.zero & size;
    // final paint = Paint()
    //   ..shader = ui.Gradient.linear(rect.topLeft, rect.bottomRight,
    //       [Color(0xff8f9275), Color(0xff4a5f55)], [0.1, 0.35]);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
