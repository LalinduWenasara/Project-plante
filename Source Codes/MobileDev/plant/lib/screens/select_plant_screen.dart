import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant/screens/mysplashscreen.dart';

import '../constants.dart';
import '../reusable.dart';


class SelectPlant extends StatefulWidget {
  static const String id = 'selectPlant';

  @override
  _SelectPlantState createState() => _SelectPlantState();
}

class _SelectPlantState extends State<SelectPlant> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Select The Plant'),
        backgroundColor:kAppBarColor),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CupertinoSearchTextField(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          ReusableCard_2(colour: Colors.lightGreen[700],onPress: (){Navigator.pushNamed(context,MySplashScreen.id);},cardChild: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: size.height * 0.1,
              width: size.width *0.5,
              child: Row(
                children: [
                  Container(
                      width: size.width *0.2,
                      child: Text('tomato')),
                  Container(
                      height: size.height * 0.1,
                      child: Image.asset('images/tomatoeicon.png')),
                ],
              ),
            ),
          ),),
          ReusableCard_2(colour: Colors.lightGreen[700],onPress: (){Navigator.pushNamed(context,MySplashScreen.id);},cardChild: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: size.height * 0.1,
              width: size.width *0.5,
              child: Row(
                children: [
                  Container(
                      width: size.width *0.2,
                      child: Text('grape')),
                  Container(
                      height: size.height * 0.1,

                      child: Image.asset('images/grape.png')),
                ],
              ),
            ),
          ),),//
        ],
      ),
    );
  }
}
/*
*  Container(
                                      height: size.height * 0.06,
                                      child: Image.asset('images/feedback.png')),
                                  Text('Feedback'),
*
* */