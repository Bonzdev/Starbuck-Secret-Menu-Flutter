import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:starbucksecret/models/Menu.dart';
import 'package:starbucksecret/views/components/textView.dart';
import 'package:starbucksecret/configuration.dart';
import 'package:flutter/foundation.dart';
import 'package:starbucksecret/dao/menuDao.dart';
import 'dart:math';
import 'package:starbucksecret/helpers/global_helper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = new TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DatabaseReference _menuRef;
  final _menusRef = FirebaseDatabase.instance.reference().child('menus');
  List<Menu> _menus = [];
  List<Map<dynamic, dynamic>> lists = [];

  MenuDao _query = new MenuDao();
  List<Menu> _menu = [];

  //firestore

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase.instance;
    _menus = _query.getAllMenu();

    // _menuRef = database.reference().child('menus');

    // _menuRef.onChildAdded.listen(_onEntryAdded);
    // _menuRef.onChildChanged.listen(_onEntryChanged);
  }

  //

  onSearchTextChanged(String text) async {
    setState(() {
      _menus = _query
          .getAllMenu()
          .where((element) =>
              element.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
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
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text:
                                        'If you have a secret recipe you’d like to share, send it to '),
                                new TextSpan(
                                    text: 'codingcopy@gmail.com',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colorPrimaryDark)),
                                new TextSpan(
                                    text: '. Attach a photo if you have one.'),
                              ],
                            ),
                          )));
                }),
            IconButton(
                icon: Icon(Icons.casino, color: Colors.white),
                onPressed: () {
                  var random = new Random();
                  Navigator.pushNamed(context, '/menu-detail',
                      arguments: random.nextInt(2));
                }),
            IconButton(
                icon: Icon(
                  Icons.local_cafe_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  // _launchURL(0);
                  launchURL("https://www.buymeacoffee.com/secretsrecipe");
                  //
                  // FirebaseFirestore.instance
                  //     .collection("menus")
                  //     .add({'timestamp': Timestamp.fromDate(DateTime.now())});
                }),
          ]),
      appBar: AppBar(
          title: Text(
        "Starbucks Secret Menu",
        style: TextStyle(color: Colors.white),
      )),
      body: Container(
          padding: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OutlineTextView(
                controller: _controller,
                hintText: "Search Secret Menu",
                borderColor: colorPrimaryDark,
                customFunction: (val) {
                  onSearchTextChanged(val);
                },
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("menus")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView(
                        children:
                            snapshot.data.docs.map((DocumentSnapshot document) {
                      return Center(
                        child: ChoiceCard(
                            menu: Menu.fromQueryDocumentSnapshot(document),
                            idx: document.id),
                      );
                    }).toList());
                  },
                ),
              )
            ],
          )),
    );
  }
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard(
      {Key key, this.onTap, @required this.menu, @required this.idx})
      : super(key: key);
  final VoidCallback onTap;
  final Menu menu;
  final String idx;
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2.0,
        color: Colors.white,
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/menu-detail', arguments: idx);
            },
            child: Row(
              children: <Widget>[
                new Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.topLeft,
                    child: Image.network(
                      menu.imgUrl,
                      height: 50,
                    )),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menu.name,
                        textAlign: TextAlign.left,
                        maxLines: 5,
                      ),
                      Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: new BoxDecoration(
                            color: colorPrimaryDark,
                            borderRadius: BorderRadius.circular(10)),
                        constraints:
                            BoxConstraints(minWidth: 14, minHeight: 14),
                        child: Text(
                          menu.type,
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      )
                    ],
                  ),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            )));
  }
}
