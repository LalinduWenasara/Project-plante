// @dart=2.9
import 'package:flutter/material.dart';
import 'package:plant/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant/screens/feedback_screen.dart';
import 'package:plant/screens/profile_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'home_screen.dart';
import 'home_screen2.dart';


class SetProfileScreen extends StatefulWidget {
  static const String id = 'setprofile_screen';

  @override
  _SetProfileScreenState createState() => _SetProfileScreenState();
}


class _SetProfileScreenState extends State<SetProfileScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  var loggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  String userEmail, userImage, testU1, testU2, testU3;
  String displayName, Address, NIC, email, imageUrl, mobileNu, profileSet;

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
        child: Column(
          children: [
            SizedBox(
              height: size.height*0.05,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: size.height*0.2,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context)
                                .scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              userImage,
                            ))),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: size.height*0.1,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context)
                                .scaffoldBackgroundColor,
                          ),
                          color: Colors.green,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: TextField(
                onChanged: (value) {
                  displayName = value;
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Display Name",
                    floatingLabelBehavior:
                    FloatingLabelBehavior.always,
                    hintText: "",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: TextField(
                onChanged: (value) {
                  Address = value;
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Address",
                    floatingLabelBehavior:
                    FloatingLabelBehavior.always,
                    hintText: "",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: TextField(
                onChanged: (value) {
                  NIC = value;
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "NIC",
                    floatingLabelBehavior:
                    FloatingLabelBehavior.always,
                    hintText: "",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: TextField(
                onChanged: (value) {
                  mobileNu = value;
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Mobile",
                    floatingLabelBehavior:
                    FloatingLabelBehavior.always,
                    hintText: "",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if(displayName == null || Address == null || NIC == null || mobileNu == null){
                      print("Ssss");
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                        title: const Text('Fill All the Details'),
                     //   content: const Text('Fill All the Details'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ));
                    }
                    else {
                      _firestore.collection('userprofile').add({
                        'displayName': displayName,
                        'Address': Address,
                        'NIC': NIC,
                        'email': userEmail,
                        'mobileNu': mobileNu,
                      });
                      Navigator.pushNamed(context, Home5.id);
                    }


                  },
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.white),
                  ),
                ),


              ],
            )
          ],
        ),),
      ),
    );
  }
}