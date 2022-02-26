// @dart=2.9
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as io;
import 'package:path/path.dart';

class SolutionScreenLowPredict extends StatefulWidget {
  static const String id = 'SolutionScreenLow';

  String value1;
  File image;
  SolutionScreenLowPredict({this.value1, this.image});

  @override
  _SolutionScreenLowPredictState createState() =>
      _SolutionScreenLowPredictState(value1, image);
}

class _SolutionScreenLowPredictState extends State<SolutionScreenLowPredict> {
  File image;
  String test_text;
  String value1;
  _SolutionScreenLowPredictState(this.value1, this.image);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),

            //child: Image.file(image),
            child: Column(
              children: [
                Text("Low Prediction"),
                // Text(value1),
                Container(
                  height: 250.0,
                  child: Image.file(image),
                ),
                Center(
                    child: Text("Oops Sorry We cant give accurate answer now ",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Center(
                    child: Text(
                        "image of the diseased plant has been uploaded.Our Specialists will contact you soon.Please wait.")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
