import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'login_google_screen.dart';

class WelcomePlante extends StatefulWidget {
  static const String id = 'WelcomePlante_screen';

  @override
  _WelcomePlanteState createState() => _WelcomePlanteState();
}

class _WelcomePlanteState extends State<WelcomePlante> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kAquaHaze,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: size.height * 0.22,

          ),
          Container(
            height: size.height * 0.12,
            child: Container(
              child: Image(image: AssetImage('images/logors-150.png')),
            ),
          ),
          Container(
            height: size.height * 0.1,
            width: size.width * 0.4,
            child: Center(
                child: Text(
              'Project Plante',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black45,
                fontFamily:'RobotoMono'
              ),
            )),

          ),
          Container(
            height: size.height * 0.42,
          ),
          Container(
            child: Row(
              children: [
                Container(
                  width: size.width * 0.6,

                ),
                Container(
                  width: size.width * 0.4,

                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Center(
                      child: TextButton(





                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(kHarlequin),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          shape:MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              )),

                        ),
                        onPressed: () {



                            Navigator.pop(context);
                            Navigator.pushNamed(context, LoginWithGoogle.id);

                            //Go to login screen.

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text('Get Started'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            height: size.height * 0.1,

          ),
          Container(
            height: size.height * 0.04,
          )
        ],
      ),
    );
  }
}
