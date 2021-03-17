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
  DatabaseReference _menuRef;
  final _menusRef = FirebaseDatabase.instance.reference().child('menus');
  List<Menu> _menus = [];
  List<Map<dynamic, dynamic>> lists = [];

  MenuDao _query = new MenuDao();
  List<Menu> _menu = [];

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase.instance;
    _menuRef = database.reference().child('menus');
    _menus = _query.getAllMenu();
    _menuRef.onChildAdded.listen(_onEntryAdded);
    _menuRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(Event event) {
    setState(() {
      _menu.add(Menu.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = _menu.singleWhere((entry) {
      return entry.id == event.snapshot.key;
    });
    setState(() {
      _menu[_menu.indexOf(old)] = Menu.fromSnapshot(event.snapshot);
    });
  }

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
              ListView(
                  shrinkWrap: true,
                  // padding: const EdgeInsets.all(5.0),
                  children: List.generate(_menu.length, (index) {
                    return Center(
                      child: ChoiceCard(menu: _menu[index], idx: index),
                    );
                  })),
              FutureBuilder(
                  future: _menusRef.once(),
                  builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      // _menu.clear();
                      // List<dynamic> data = snapshot.data.value;

                      // data.forEach((element) {
                      //   if (element != null) {
                      //     _menu.add(Menu.fromMap(element));
                      //   }
                      // });
                      return new ListView.builder(
                          shrinkWrap: true,
                          itemCount: _menu.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Center(
                              child: ChoiceCard(menu: _menu[index], idx: index),
                            );
                          });
                    }
                    return CircularProgressIndicator();
                  })
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
  final int idx;
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
