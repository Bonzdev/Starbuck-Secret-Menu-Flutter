import 'package:flutter/material.dart';
class TopHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            child: FadeInImage.assetNetwork(
              alignment: Alignment.topCenter,
              placeholder: "https://picsum.photos/100",
              image: "https://picsum.photos/100",
              fit: BoxFit.none,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(child: Text("Grade:")),
                    Container(child: Text("Sashimi")),
                  ],
                ),
                SizedBox(height: 5.0),

                Row(
                  children: <Widget>[
                    Container(child: Text("Spec:")),
                    Container(child: Text("Skinless Boneless, Full Loins")),
                  ],
                ),
                SizedBox(height: 5.0),

                Row(
                  children: <Widget>[
                    Container(child: Text("Size:")),
                    Container(child: Text("2-4 kG")),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Spacer(flex: 4,)
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
