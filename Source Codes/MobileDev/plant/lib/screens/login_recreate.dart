import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant/constants.dart';
import 'home_screen2.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();


class LoginRecreate extends StatefulWidget {
  static const String id = 'login_recreate';

  @override
  _LoginRecreateState createState() => _LoginRecreateState();
}

class _LoginRecreateState extends State<LoginRecreate> {
  @override
  String userEmail = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: size.height * 0.4,
            decoration: BoxDecoration(
              // color: kBlack,
              //  borderRadius: BorderRadius.circular(20.0)
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              )
              ,
              image: DecorationImage(
                  image: AssetImage("images/severin-candrian.jpg"),
                  fit: BoxFit.cover),
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
