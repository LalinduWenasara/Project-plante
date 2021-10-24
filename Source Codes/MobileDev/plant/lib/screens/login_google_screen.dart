import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';



final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class LoginWithGoogle extends StatefulWidget {
  static const String id = 'l_Google';

  @override
  _LoginWithGoogleState createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  String userEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login with google"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text('user email:'),
              Text(userEmail),

            ],
          ),
          ElevatedButton(
              onPressed: () async {
                await signInWithGoogle();
                setState(() {});

              },
              child: Text('Continue with Google')),
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
