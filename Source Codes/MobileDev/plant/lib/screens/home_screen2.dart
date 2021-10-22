// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant/constants.dart';
import 'package:plant/reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant/screens/chat_screen.dart';
import 'package:plant/components/bottomnavbar.dart';
import 'login_screen.dart';

class Home5 extends StatefulWidget {
  static const String id = 'home5';

  @override
  _Home5State createState() => _Home5State();
}

class _Home5State extends State<Home5> {
  final _auth = FirebaseAuth.instance;
  String useremail;
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
//var loggedInUSer;
      //loggedInUser==user;
      print(user.email);
      setState(() {
        useremail = user.email;
      });
    } else {
      print('check2');
    }
  }



  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
 body: Container(
   height: 234,



 ),
    );
  }

}


