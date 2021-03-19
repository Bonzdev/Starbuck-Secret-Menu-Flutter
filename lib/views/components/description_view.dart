import 'package:flutter/material.dart';

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
