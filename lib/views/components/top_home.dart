import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 10, top: 25),
      padding: EdgeInsets.only(top: 40, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Container(
                  //     child: Text(
                  //   "Good Morning",
                  //   style: GoogleFonts.openSans(
                  //     textStyle: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 24,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // )),
                  SizedBox(height: 9.0),
                  Container(
                      child: Text(
                    "A good day starts with a good coffee.How do you want to start your day?",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
                child: Image.network(
                    'https://res.cloudinary.com/bonzdev/image/upload/v1651057114/eastwood-starbucks_fyamqz.png',
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.contain)),
          ),
        ],
      ),
    );
  }
}
