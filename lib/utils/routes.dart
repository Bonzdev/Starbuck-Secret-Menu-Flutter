import 'package:flutter/material.dart';
import 'package:starbucksecret/views/detail_category.dart';
import 'package:starbucksecret/views/home.dart';
import 'package:starbucksecret/views/detail_menu.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => HomePage());
    case '/menu-detail':
      return MaterialPageRoute(
          builder: (_) => DetailMenu(
                id: settings.arguments,
              ));
    case '/detail-category':
      return MaterialPageRoute(
          builder: (_) => DetailCategory(
            category: settings.arguments,
          ));
    //if want using page transition
    // return PageRouteBuilder(
    //     pageBuilder: (_, __, ___) => DetailMenu(
    //           id: settings.arguments,
    //         ),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       // return FadeTransition(opacity: animation, child: child);
    //       return ScaleTransition(
    //         scale: Tween<double>(
    //           begin: 0.0,
    //           end: 1.0,
    //         ).animate(
    //           CurvedAnimation(
    //             parent: animation,
    //             curve: Curves.fastOutSlowIn,
    //           ),
    //         ),
    //         child: child,
    //       );
    //     });
    default:
      return MaterialPageRoute(builder: (_) => HomePage());
  }
}
