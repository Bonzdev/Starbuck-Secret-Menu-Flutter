import 'package:flutter/material.dart';

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
