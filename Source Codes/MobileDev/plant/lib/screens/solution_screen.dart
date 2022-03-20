// @dart=2.9
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant/screens/treatments_screen.dart';
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
  String thetreatment;



   @override
   void initState() {
     // TODO: implement initState
     super.initState();
     getMessages();

   }











   final _firestore = FirebaseFirestore.instance;
   void getMessages() async {
     final messages1 = await _firestore.collection('treatment').where('disease',isEqualTo: value1).get();
     for (var m in messages1.docs) {
       // print(m.data());
       var xx = m.data()['treatment'];
       thetreatment=xx.toString();

     }
   }



















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
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Treatment(
                        value1: value1,
                          treatment:thetreatment,

                      ),
                    ));
                  },
                  child: Text(
                    'Send',
                  ),
                ),
              ],
            ),

          ),
        ],
      ),
    );
  }
}
