import 'package:flutter/material.dart';

import 'package:starbucksecret/models/Menu.dart';

class MenuTitle extends StatelessWidget {
  final Menu menu;
  final double padding;

  MenuTitle(this.menu, this.padding);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        // Default value for crossAxisAlignment is CrossAxisAlignment.center.
        // We want to align title and description of recipes left:
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            menu.name,
            style: Theme.of(context).textTheme.title,
          ),
          // Empty space:
          SizedBox(height: 10.0),
          Row(
            children: [
              Icon(Icons.label_important, size: 20.0),
              SizedBox(width: 5.0),
              Text(
                menu.type,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
