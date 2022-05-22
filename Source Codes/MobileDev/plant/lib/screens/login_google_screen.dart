import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant/constants.dart';
import 'package:plant/screens/registration_screen.dart';
import 'home_screen2.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class LoginWithGoogle extends StatefulWidget {
  static const String id = 'l_Google';

  @override
  _LoginWithGoogleState createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  String userEmail = '';
  late String email, password;
  bool spinLordShow = false;
  bool flag_1=false;
  late String whoLogged;


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: size.height * 0.45,
            decoration: BoxDecoration(
              // color: kBlack,
              //  borderRadius: BorderRadius.circular(20.0)
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              )
              ,
              image: DecorationImage(
                  image: AssetImage("images/plant-diseases2.jpg"),
                  fit: BoxFit.cover),
            ),

          ),


          Container(
            width: size.width*0.75,
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  obscureText: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            height: size.height * 0.05,
            decoration: BoxDecoration(
              // color: kBlack,
              //  borderRadius: BorderRadius.circular(20.0)
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              )
              ,
            ),

          ),

          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Home5.id);
              },
              child:  Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                    width: size.width*0.5,
                    child: Center(child: Text('Login'))),
              ),
            ),),
          Center(
              child: OutlinedButton.icon(
                icon: Icon(
                  FontAwesomeIcons.google,
                  color: Colors.red.shade500,
                ),
                label: Padding(
                  padding: const EdgeInsets.all(4.0),

                  child: Container(
                    width: size.width*0.4,
                    child: Text(
                      'Continue with Google',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
                onPressed: () async {
                  await signInWithGoogle();
                  setState(() {});
                  Navigator.pushNamed(context, Home5.id);
                },
                style: OutlinedButton.styleFrom(
                  primary: kGreenE,
                  side: BorderSide(color: Colors.black54, width: 1),
                ),
              )),
          Container(
            child: Row(
              children: [
                SizedBox(width:size.width*0.25),
                Text(
                  "New to Plante ? ",
                  style: TextStyle(color: Colors.green),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                    print(' now you are in sign up');
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    userEmail = googleUser!.email;

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();

  }
}
