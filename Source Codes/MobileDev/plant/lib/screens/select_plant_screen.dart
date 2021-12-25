import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant/screens/mysplashscreen.dart';

import '../reusable.dart';


class SelectPlant extends StatefulWidget {
  static const String id = 'selectPlant';

  @override
  _SelectPlantState createState() => _SelectPlantState();
}

class _SelectPlantState extends State<SelectPlant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select The Plant'),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CupertinoSearchTextField(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          ReusableCard_2(colour: Colors.amber,onPress: (){Navigator.pushNamed(context,MySplashScreen.id);},cardChild: Text('Tomato'),),
        ],
      ),
    );
  }
}
