import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_places/src/page/detail_page.dart';
import 'package:flutter_places/src/page/home_page.dart';
import 'package:flutter_places/src/page/location_place.dart';
import 'package:flutter_places/src/page/login.dart';
import 'package:flutter_places/src/page/register_page.dart';

void main() {
  runApp(
    MaterialApp(
      home: AnimatedSplash(
        imagePath: 'assets/image_01.png',
        home: MainApp(),
        duration: 2500,
        type: AnimatedSplashType.StaticDuration,
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Trip App",
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'register': (BuildContext context) => RegisterPage(),
        'detail': (BuildContext context) => Detailpage(),
        'location': (BuildContext context) => MapaPage(),
      },
    );
  }
}
