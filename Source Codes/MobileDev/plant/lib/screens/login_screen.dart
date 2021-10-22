// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:plant/constants.dart';
import 'package:plant/reusable.dart';
import 'package:plant/screens/chat_screen.dart';
import 'package:plant/screens/registration_screen.dart';
import 'package:plant/screens/welcome_screen.dart';

import 'home_screen.dart';




class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';



  @override
  _LoginScreenState createState() => _LoginScreenState();
}




class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email, password;
  bool spinLordShow = false;
  bool flag_1=false;
  String whoLogged;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckLoggedInOrNot();
  }



  void CheckLoggedInOrNot() async {
    final user = await _auth.currentUser;
    if(user != null){
      setState(() {
        flag_1=true;
        whoLogged = user.email;

      });
      }
    else{
      flag_1=false;
    }


  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget child;
    if(flag_1==false) {
      child= Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: spinLordShow,
          child:

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Text(
                    "LOGIN",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                Hero(
                  tag: 'plant_logo',
                  child: Container(
                    height: size.height * 0.26,
                    child: SvgPicture.asset('images/password.svg'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                      //Do something with the user input.
                    },
                    decoration:
                    kInputsTextDecoration.copyWith(hintText: 'Enter Email')),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                      //Do something with the user input.
                    },
                    decoration: kInputsTextDecoration.copyWith(
                        hintText: 'Enter Password')),
                SizedBox(
                  height: 24.0,
                ),
                KroundedButton(
                  title: 'Log In',
                  colour: Color(0x6ADBB9FF),
                  onPressed: () async {
                    print(email);
                    print(password);
                    setState(() {
                      spinLordShow = true;
                    });
                    try {
                      final user = _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.pushNamed(context, HomeScreen.id);
                      }
                      if (user == null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        spinLordShow = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        "Dont you have an Account yet ? ",
                        style: TextStyle(color: Colors.green),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegistrationScreen.id);
                          print(' now you are in sign up');
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    else{
      child= Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: spinLordShow,
          child:

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Text(
                    'You have already logged in',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                Center(
                  child: Text(
                    whoLogged,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.id);
                  },
                  child:  Text('continue'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pushNamed(context, WelcomeScreen.id);
                  },
                  child:  Text('log out'),
                ),

              ],
            ),
          ),
        ),
      );

    }
    return new Container(child: child);

  }

}
