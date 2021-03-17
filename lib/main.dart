import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:starbucksecret/configuration.dart';
import 'package:starbucksecret/utils/routes.dart' as router;
import 'package:starbucksecret/views/home.dart';

void main() {
  // readData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Starbucks Secret Menu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: colorPrimaryDark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimatedSplashScreen(
        duration: 1000,
        backgroundColor: Colors.white,
        splash: Icons.home,
        nextScreen: HomePage(),
        splashTransition: SplashTransition.fadeTransition,
      ),
      initialRoute: '/',
      onGenerateRoute: router.generateRoute,
    );
  }
}
