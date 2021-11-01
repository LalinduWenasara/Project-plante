import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          Center(child: Text('tada')),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CupertinoSearchTextField(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          ReusableCard_2(colour: Colors.amber,onPress: (){},cardChild: Text('testPlant'),),
        ],
      ),
    );
  }
}
