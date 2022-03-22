import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:plant/reusable.dart';
import 'package:plant/screens/login_screen.dart';
import 'package:plant/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );

    animation = ColorTween(begin: Colors.green[000], end: Colors.green[100])
        .animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});

      print(animation.value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'plant_logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 100,
                  ),
                ),
                SizedBox(
                  width: 150.0,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Agne',
                      color: Colors.black87,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('Plant'),
                        TypewriterAnimatedText('Design first, then plant'),
                        TypewriterAnimatedText(
                            'Do not patch bugs out, rewrite them'),
                        TypewriterAnimatedText(
                            'Do not test bugs out, design them out'),
                        TypewriterAnimatedText('Plant'),
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: KroundedButton(
                title: 'Log In',
                colour: Colors.teal,
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                  //Go to login screen.
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: KroundedButton(
                title: 'Register',
                colour: Colors.teal,
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                  //Go to login screen.
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
