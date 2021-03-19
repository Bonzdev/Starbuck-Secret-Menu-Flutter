import 'package:flutter/material.dart';
import 'package:starbucksecret/models/Menu.dart';
import 'package:starbucksecret/configuration.dart';

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
