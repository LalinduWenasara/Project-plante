
// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'ProfileScreen';


  String displayName,Address,NIC,imageUrl,mobileNu;
  ProfileScreen({this.displayName,this.NIC,this.mobileNu,this.Address});
  @override

  _ProfileScreenState createState() => _ProfileScreenState(displayName,Address,NIC,mobileNu);
}

class _ProfileScreenState extends State<ProfileScreen> {
  String displayName;
  String Address;
  String mobileNu;
  String NIC;

  _ProfileScreenState(this.displayName,this.Address,this.mobileNu,this.NIC);

  final _auth = FirebaseAuth.instance;
  //String userEmail, userImage, testU1, testU2, testU3;
  Size size;
  String userEmail, testU1=".",userImg2, testU2, testU3,displayname2;
  //setting a default
  String  userImage="https://firebasestorage.googleapis.com/v0/b/iot2-950b2.appspot.com/o/mobapp%2F194938.png?alt=media&token=7e6346d3-b58e-411e-85e7-5df9305a3ec2";


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
        userImg2= user.photoURL;
        if(userImg2 != null){
          userImage=userImg2;}
        displayname2 = user.displayName;
        if(displayname2 != null){
          testU1=displayname2;}
        testU2 = user.uid;
      });
    } else {
      print('check2');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (displayName != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(displayName),
          backgroundColor:kAppBarColor,
        ),
        body:  Container(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
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
                          height: 40,
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
                child: Text(displayName,style:TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
              ),



              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: Text(Address,style:TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: Text(NIC,style:TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: Text(mobileNu,style:TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
              ),
              /*Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: Text(NIC,style:TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
              ),*/

            ],
          ),
        ));

    } else
      return Scaffold(
        appBar: AppBar(
          title: Text(displayName),
          backgroundColor: kAppBarColor,
        ),
        body: Text('OOps Connection Error'),
      );
  }
}







