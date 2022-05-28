// @dart=2.9
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../constants.dart';
import 'feedback_screen.dart';




class SolutionScreenLowPredict extends StatefulWidget {
  static const String id = 'SolutionScreenLow';

  String value1;
  File image;
  String downloadURL;
  SolutionScreenLowPredict({this.value1, this.image, this.downloadURL});

  @override
  _SolutionScreenLowPredictState createState() =>
      _SolutionScreenLowPredictState(value1, image, downloadURL);
}

class _SolutionScreenLowPredictState extends State<SolutionScreenLowPredict> {
  File image;
  String test_text;
  String value1;
  String downloadURL;
  _SolutionScreenLowPredictState(this.value1, this.image, this.downloadURL);

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String userEmail, userImage, testU1, testU2, testU3;
  String message;
  Size size;
  Position position;
  var now = new DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    getCurrentLocation();
    print(now);
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


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
        backgroundColor: kAppBarColor,
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
                  height: size.height * 0.5,
                  child: Image.file(image),
                ),
                Center(
                    child: Text("Oops Sorry We cant give accurate answer now ",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Center(
                    child: Text(
                        "Please tell us what are the symptoms as you can see.we will contact you soon")),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    onChanged: (value) {
                      message = value;
                    },
                  ),
                ),
                /* Text(downloadURL),
                Text(userEmail),*/
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.lightGreen[700]),
                  onPressed: () {
                    _firestore.collection('uploads').add({
                      'downloadURL': downloadURL,
                      'sender': userEmail,
                      'message': message,
                      'lat': position.latitude,
                      'long': position.longitude,
                      'time': now,

                    });
                    Navigator.pushNamed(context, FeedbackScreen.id);
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

  Future<void> getCurrentLocation() async {
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    print(position);
  }
}
