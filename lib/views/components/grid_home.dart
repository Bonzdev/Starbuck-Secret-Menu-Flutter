import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Calendar",
      subtitle: "March, Wednesday",
      event: "3 Events",
      img: "https://res.cloudinary.com/bonzdev/image/upload/v1651123181/category/tea_updated_o8cvnw.png");

  Items item2 = new Items(
    title: "Groceries",
    subtitle: "Bocali, Apple",
    event: "4 Items",
    img: "https://res.cloudinary.com/bonzdev/image/upload/v1651123181/category/tea_updated_o8cvnw.png",
  );
  Items item3 = new Items(
    title: "Locations",
    subtitle: "Lucy Mao going to Office",
    event: "",
    img: "https://res.cloudinary.com/bonzdev/image/upload/v1651123181/category/tea_updated_o8cvnw.png",
  );
  Items item4 = new Items(
    title: "Activity",
    subtitle: "Rose favirited your Post",
    event: "",
    img: "https://res.cloudinary.com/bonzdev/image/upload/v1651123181/category/tea_updated_o8cvnw.png",
  );
  Items item5 = new Items(
    title: "To do",
    subtitle: "Homework, Design",
    event: "4 Items",
    img: "https://res.cloudinary.com/bonzdev/image/upload/v1651123181/category/tea_updated_o8cvnw.png",
  );
  Items item6 = new Items(
    title: "Settings",
    subtitle: "",
    event: "2 Items",
    img: "https://res.cloudinary.com/bonzdev/image/upload/v1651123181/category/tea_updated_o8cvnw.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: myList.map((data) {
          return Container(
            decoration: BoxDecoration(
              color: Color(color),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(data.img, width: 100),
                Text(
                  data.title,

                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  data.subtitle,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Colors.white38,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items({this.title, this.subtitle, this.event, this.img});
}