// @dart=2.9
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String downloadURL;
  SolutionScreenLowPredict({this.value1, this.image,this.downloadURL});

  @override
  _SolutionScreenLowPredictState createState() =>
      _SolutionScreenLowPredictState(value1, image,downloadURL);
}

class _SolutionScreenLowPredictState extends State<SolutionScreenLowPredict> {
  File image;
  String test_text;
  String value1;
  String downloadURL;
  _SolutionScreenLowPredictState(this.value1, this.image,this.downloadURL);


  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String userEmail, userImage, testU1, testU2, testU3;
  String message;
  Size size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    if (user != null) {
      print('checkpoint1');
      print(user.email);
      setState(() {
        userEmail = user.email;
      });
    } else {
      print('check2');
    }
  }
/*
  void MessagesStram() async {

    await for (var snapshots in   _firestore.collection('messages').snapshots()) {
      for (var m in snapshots.docs) {
        print(m.data());
      }
    }
  }


*/




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
                  height: 200.0,
                  child: Image.file(image),
                ),
                Center(
                    child: Text("Oops Sorry We cant give accurate answer now ",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Center(
                    child: Text(
                        "image of the diseased plant has been uploaded.Our Specialists will contact you soon.Please wait.")),
                SizedBox(
                  width: size.width*0.1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration:InputDecoration(border: OutlineInputBorder()) ,
                    onChanged: (value) {
                      message = value;
                    },
                  ),
                ),
               /* Text(downloadURL),
                Text(userEmail),*/
                ElevatedButton(
                  onPressed: () {
                    _firestore.collection('uploads').add({
                      'downloadURL': downloadURL,
                      'sender': userEmail,
                      'message':message,
                      'lat':'dummy',
                      'long':'dummy',
                    });
                  },
                  child: Text(
                    '->',
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
