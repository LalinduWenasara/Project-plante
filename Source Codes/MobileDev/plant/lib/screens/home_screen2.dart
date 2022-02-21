// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant/constants.dart';
import 'package:plant/screens/login_google_screen.dart';
import 'package:plant/screens/select_plant_screen.dart';

import '../reusable.dart';

class Home5 extends StatefulWidget {
  static const String id = 'home5';

  @override
  _Home5State createState() => _Home5State();
}

class _Home5State extends State<Home5> {
  final _auth = FirebaseAuth.instance;
  String userEmail, userImage, testU1, testU2, testU3;
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
      body: Column(
        children: [
          Container(
            height: size.height * 0.1,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          Container(
            height: size.height * 0.3,
            child: Center(
                child: Row(
                  children: [
                    Column(
              children: [
                    Row(
                      children: [
                        SizedBox(
                          width: size.width*0.2,
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(userImage),
                        ),
                        SizedBox(
                          width: size.width*0.4,
                        ),
                        ElevatedButton(
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
                        Text(userEmail),
                        Text(testU1),
                      ],
                    ),

              ],
            ),
                  ],
                )),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
          ),
          Container(
            height: size.height * 0.4,
            width: size.width,
            child: Column(
              children: [
                Center(child: Text('Services',style: TextStyle(
                    fontSize: 22,
                    color: Colors.black45,
                    fontFamily:'RobotoMono'
                ),)
                ),
                Row(
                  children: [
                    ReusableCard_2(
                      colour: Colors.green,
                      cardChild: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            height: size.height * 0.1,
                            width: size.width *0.2,
                            child: Text('Select Plant')),
                      ),
                      onPress: () {
                        Navigator.pushNamed(context, SelectPlant.id);
                      },
                    ),
                    ReusableCard_2(
                      colour: Colors.green,
                      cardChild: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            height: size.height * 0.1,
                            width: size.width *0.2,
                            child: Text('Profile')),
                      ),
                      onPress: () {
                        Navigator.pushNamed(context, SelectPlant.id);
                      },
                    ),
                    ReusableCard_2(
                      colour: Colors.green,
                      cardChild: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            height: size.height * 0.1,
                            width: size.width *0.2,
                            child: Text('Messages')),
                      ),
                      onPress: () {
                        Navigator.pushNamed(context, SelectPlant.id);
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    ReusableCard_2(
                      colour: Colors.green,
                      cardChild: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            height: size.height * 0.1,
                            width: size.width *0.2,
                            child: Text('Dummy')),
                      ),
                      onPress: () {
                        Navigator.pushNamed(context, SelectPlant.id);
                      },
                    ),
                    ReusableCard_2(
                      colour: Colors.green,
                      cardChild: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            height: size.height * 0.1,
                            width: size.width *0.2,
                            child: Text('Dummy')),
                      ),
                      onPress: () {
                        Navigator.pushNamed(context, SelectPlant.id);
                      },
                    ),
                    ReusableCard_2(
                      colour: Colors.green,
                      cardChild: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            height: size.height * 0.1,
                            width: size.width *0.2,
                            child: Text('Dummy')),
                      ),
                      onPress: () {
                        Navigator.pushNamed(context, SelectPlant.id);
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
            height: size.height * 0.2,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    Navigator.pushNamed(context, LoginWithGoogle.id);
  }
}
