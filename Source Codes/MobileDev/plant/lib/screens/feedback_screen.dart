// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constants.dart';
import 'home_screen.dart';
import 'home_screen2.dart';


class FeedbackScreen extends StatefulWidget {
  static const String id = 'feedback';

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String userEmail, userImage, testU1, testU2, testU3;
  Size size;
  var feedback;

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
        userImage = user.photoURL;
        testU1 = user.displayName;
        testU2 = user.uid;
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
        title: Text('feedback'),
               backgroundColor: kAppBarColor,
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.2,

          ),
          Center(
            child: RatingBar.builder(
              updateOnDrag: true,
              initialRating: 3,
              itemCount: 5,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Icon(
                      Icons.sentiment_very_dissatisfied,
                      color: Colors.red,
                    );
                  case 1:
                    return Icon(
                      Icons.sentiment_dissatisfied,
                      color: Colors.redAccent,
                    );
                  case 2:
                    return Icon(
                      Icons.sentiment_neutral,
                      color: Colors.amber,
                    );
                  case 3:
                    return Icon(
                      Icons.sentiment_satisfied,
                      color: Colors.lightGreen,
                    );
                  case 4:
                    return Icon(
                      Icons.sentiment_very_satisfied,
                      color: Colors.green,
                    );
                }
              },
              onRatingUpdate: (rating) {
                print(rating);
                feedback=rating;
              },
            ),
          ),
          SizedBox(
            width: size.width*0.1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration:InputDecoration(border: OutlineInputBorder()) ,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _firestore.collection('feedback').add({
                'sender': userEmail,
                'feedback':feedback,
              });
              Navigator.pushNamed(context, Home5.id);
            },
            child: Text(
              'send',
            ),
          ),
        ],
      ),
    );
  }
}
