// @dart=2.9
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as io;
import 'package:path/path.dart';


class SolutionScreen extends StatefulWidget {
  static const String id = 'SolutionScreen';

  String value1;
  File image;
  SolutionScreen({this.value1,this.image});

  @override
  _SolutionScreenState createState() => _SolutionScreenState(value1,image);
}

class _SolutionScreenState extends State<SolutionScreen> {
   File image;
   String test_text;
   String value1;
  _SolutionScreenState(this.value1,this.image);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test"),),


      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),

    //child: Image.file(image),
            child:Column(
              children: [
                Text("Good Prediction"),
                Text(value1),
                Container(
                  height: 250.0,
                  child: Image.file(image),
                ),
              ],
            ),

          ),
        ],
      ),
    );
  }
}
