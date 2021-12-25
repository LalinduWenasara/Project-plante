import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant/screens/mysplashscreen.dart';

import '../reusable.dart';



class PlantScreen extends StatefulWidget {
  static const String id = 'plantscreen';

  @override
  _PlantScreenState createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  late String plantname;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(plantname),),
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







