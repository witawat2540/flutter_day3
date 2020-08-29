import 'package:flutter/material.dart';
import 'package:myapp_day2/main.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: MyHomePage(),
      title: Text(
        'My App Control C',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
      ),
      image: Image.asset('image/logo.png'),
      backgroundColor: Colors.pinkAccent,
      styleTextUnderTheLoader: TextStyle(color: Colors.white),
      photoSize: 100.0,
      loaderColor: Colors.white,
    );
  }
}
