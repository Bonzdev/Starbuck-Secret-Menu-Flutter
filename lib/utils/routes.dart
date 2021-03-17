import 'package:flutter/material.dart';
import 'package:starbucksecret/views/home.dart';
import 'package:starbucksecret/views/detailMenu.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => HomePage());
    case '/menu-detail':
      return PageRouteBuilder(
          pageBuilder: (_, __, ___) => DetailMenu(
                no: settings.arguments,
              ),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c));
    default:
      return MaterialPageRoute(builder: (_) => HomePage());
  }
}
