// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:plant/constants.dart';
import 'package:plant/reusable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plant/screens/login_google_screen.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email, password;
  final _auth = FirebaseAuth.instance;
  bool spinLordShow = false;

  String email1, password1;
  var re;

  Future signUp({String email1, String password1}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email1,
        password: password1,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinLordShow,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'plant_logo',
                child: Container(
                  height: 160.0,
                  child: SvgPicture.asset('images/flower.svg'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black54),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                    labelText: 'Enter Password',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black54),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
                obscureText: true,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black54),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
                obscureText: true,
              ),
              SizedBox(
                height: 8.0,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      spinLordShow = true;
                    });
                    print(email);
                    print(password);
/*
                  signUp(email1: email, password1: password).then((result) {
                    if (result == null) {
                      print('sucess');
                    } else {
                      print('chaka blast');
                    }
                  });*/

                    try {
                      final user = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      Navigator.pushNamed(context, ChatScreen.id);
                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        spinLordShow = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                        width: size.width * 0.5,
                        child: Center(child: Text('Register'))),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "Already have an Account ? ",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginWithGoogle.id);
                        print('now you are in login');
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.black54,
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
}
