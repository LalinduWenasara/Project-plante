import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'pickimages.dart';

class MySplashScreen extends StatefulWidget {
  static const String id = 'splashscreen1';

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: Home(),
      title: Text(
        'loading...',
        style: TextStyle(
            color: Color(0x00FFFF),
            fontSize: 25.0,
            fontWeight: FontWeight.bold),
      ),
      image: Image.asset('images/logors-150.png'),
      backgroundColor: Colors.white,
      photoSize: 80.0,
      loaderColor: Colors.green,
    );
  }
}
