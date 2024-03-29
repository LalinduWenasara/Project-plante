// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant/constants.dart';
import 'package:plant/screens/login_google_screen.dart';
import 'package:plant/screens/profile_screen.dart';
import 'package:plant/screens/select_plant_screen.dart';
import 'package:plant/screens/notification_screen.dart';
import 'package:plant/screens/setprofile_screen.dart';
import 'package:plant/screens/soluton_screen_low_predict.dart';

import '../reusable.dart';
import 'chat_screen.dart';
import 'feedback_screen.dart';

class Home5 extends StatefulWidget {
  static const String id = 'home5';

  @override
  _Home5State createState() => _Home5State();
}

class _Home5State extends State<Home5> {
  final _auth = FirebaseAuth.instance;
  String userEmail, testU1="Welcome",userImg2, testU2, testU3,displayname2;
  //setting  a default image url if user image url is not available
  String  userImage="https://firebasestorage.googleapis.com/v0/b/iot2-950b2.appspot.com/o/mobapp%2F194938.png?alt=media&token=7e6346d3-b58e-411e-85e7-5df9305a3ec2";
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
  void loadProfile()async{
    String displayName,Address,NIC,email,mobileNu;
    final _firestore = FirebaseFirestore.instance;
    final messages1 = await _firestore
        .collection('userprofile')
        .where('email', isEqualTo: userEmail)
        .get();
    for (var m in messages1.docs) {
      // print(m.data());
      var xx = m.data()['displayName'];
      displayName = xx.toString();
      Address=m.data()['Address'].toString();
      NIC=m.data()['NIC'].toString();
      mobileNu=m.data()['mobileNu'].toString();
      email=m.data()['email'].toString();

    }


    if (displayName != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ProfileScreen(
              Address: Address,
              displayName: displayName,
              NIC: NIC,
              mobileNu: mobileNu,


            ),
      ));
    }
    else{
      Navigator.pushNamed(context,SetProfileScreen.id);
    }

    }



  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: size.height * 0.1,
              decoration: BoxDecoration(
                //color: Colors.teal,
                borderRadius: BorderRadius.circular(20.0),

              ),
            ),
            Container(
              height: size.height * 0.2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.1,
                            ),

                            CircleAvatar(
                              backgroundImage: NetworkImage(userImage),
                              radius: size.width * 0.1,
                            ),

                            SizedBox(
                              width: size.width * 0.4,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: Colors.lightGreen[700]),
                                onPressed: () async {
                                  await signOutGoogle();
                                  setState(() {
                                    userEmail = '';
                                  });
                                },
                                child: Text('Logout')),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              userEmail,
                              style: TextStyle(
                                  fontFamily: 'Cairo', fontWeight: FontWeight.w800),
                            ),
                            Text(
                              testU1,
                              style: TextStyle(
                                  fontFamily: 'Cairo', fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
              ),
              decoration: BoxDecoration(
               color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20.0),
               /* borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),*/
              ),
            ),
            SizedBox(
              width: size.width * 0.05,
            ),

            Container(
              height: size.height * 0.4,
              width: size.width,
              child: Column(
                children: [
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  Center(
                      child: Text(
                    'Services',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black45,
                        fontFamily: 'RobotoMono'),
                  )),
                  Row(
                    children: [
                      ReusableCard_2(
                        cardChild: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              height: size.height * 0.1,
                              width: size.width * 0.2,
                              child: Column(
                                children: [
                                  Container(
                                      height: size.height * 0.06,
                                      child:
                                          Image.asset('images/flower-pot.png')),
                                  Text('Plant'),
                                ],
                              )),
                        ),
                        onPress: () {
                          Navigator.pushNamed(context, SelectPlant.id);
                        },
                      ),
                      ReusableCard_2(
                        cardChild: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              height: size.height * 0.1,
                              width: size.width * 0.2,
                              child: Column(
                                children: [
                                  Container(
                                      height: size.height * 0.06,
                                      child: Image.asset('images/profile.png')),
                                  Text('Profile'),
                                ],
                              )),
                        ),
                        onPress: () {
                          loadProfile();

                        },
                      ),
                      ReusableCard_2(
                        cardChild: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              height: size.height * 0.1,
                              width: size.width * 0.2,
                              // images/comment.png
                              child: Column(
                                children: [
                                  Container(
                                      height: size.height * 0.06,
                                      child: Image.asset('images/comment.png')),
                                  Text('Message'),
                                ],
                              )),
                        ),
                        onPress: () {
                          Navigator.pushNamed(context, ChatScreen.id);
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ReusableCard_2(
                        cardChild: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              height: size.height * 0.1,
                              width: size.width * 0.1,
                              child: Text('')),
                        ),
                        onPress: () {},
                      ),
                      ReusableCard_2(
                        cardChild: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              height: size.height * 0.1,
                              width: size.width * 0.2,
                              // images/comment.png
                              child: Column(
                                children: [
                                  Container(
                                      height: size.height * 0.06,
                                      child: Image.asset('images/feeedback1.png')),
                                  Text('Feedback'),
                                ],
                              )),
                        ),
                        onPress: () {
                          Navigator.pushNamed(context, FeedbackScreen.id);
                        },
                      ),
                      ReusableCard_2(
                        cardChild: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              height: size.height * 0.1,
                              width: size.width * 0.2,
                              // images/comment.png
                              child: Column(
                                children: [
                                  Container(
                                      height: size.height * 0.06,
                                      child: Image.asset('images/notification1.png')),
                                  Text('Notification'),
                                ],
                              )),
                        ),
                        onPress: () {
                          Navigator.pushNamed(context, NotificationScreen.id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            Container(
              height: size.height * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
   // _auth.signOut();
   Navigator.pushNamed(context, LoginWithGoogle.id);

  }
}
