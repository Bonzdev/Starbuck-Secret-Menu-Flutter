import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starbucksecret/configuration.dart';
import 'package:starbucksecret/dao/category_dao.dart';
import 'package:starbucksecret/models/Category.dart';

class GridDashboard extends StatelessWidget {
  CategoryDao _query = new CategoryDao();
  Items item1 = new Items(
      title: "Calendar",
      subtitle: "March, Wednesday",
      event: "3 Events",
      img:
          "https://res.cloudinary.com/bonzdev/image/upload/v1651123181/category/tea_updated_o8cvnw.png");

  Items item2 = new Items(
    title: "Groceries",
    subtitle: "Bocali, Apple",
    event: "4 Items",
    img:
        "https://res.cloudinary.com/bonzdev/image/upload/v1651123181/category/tea_updated_o8cvnw.png",
  );
  Items item3 = new Items(
    title: "Locations",
    subtitle: "Lucy Mao going to Office",
    event: "",
    img:
        "https://res.cloudinary.com/bonzdev/image/upload/v1651123181/category/tea_updated_o8cvnw.png",
  );
  Items item4 = new Items(
    title: "Activity",
    subtitle: "Rose favirited your Post",
    event: "",
    img:
        "https://res.cloudinary.com/bonzdev/image/upload/v1651123181/category/tea_updated_o8cvnw.png",
  );
  Items item5 = new Items(
    title: "To do",
    subtitle: "Homework, Design",
    event: "4 Items",
    img:
        "https://res.cloudinary.com/bonzdev/image/upload/v1651123181/category/tea_updated_o8cvnw.png",
  );
  Items item6 = new Items(
    title: "Settings",
    subtitle: "",
    event: "2 Items",
    img:
        "https://res.cloudinary.com/bonzdev/image/upload/v1651123181/category/tea_updated_o8cvnw.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    return StreamBuilder(
      stream: _query.getAllCategory(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GridView.count(
            childAspectRatio: 1.0,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 10, right: 10),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Category data = Category.fromQueryDocumentSnapshot(document);
              return InkWell(
                  onTap: () {
                Navigator.pushNamed(context, '/detail-category', arguments: data.name);
              },
              child:Container(
                decoration: BoxDecoration(
                  color: colorPrimaryDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network(data.img, width: 100),
                    Text(
                      data.name,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      data.total+ " Menus",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: kuningColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ));
            }).toList(),
          ),
        );
      },
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
