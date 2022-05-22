import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:plant/constants.dart';
import 'package:plant/screens/registration_screen.dart';
import 'package:plant/screens/welcome_plante_screen.dart';
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
        whoLogged=user.email!;
      });
    }
    else{
      flag_1=false;
    }


  }














  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if(flag_1==false) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinLordShow,
        child: Column(
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
                            color: Colors.black54),
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
                            color: Colors.black54),
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
                  setState(() {
                    spinLordShow = true;
                  });
                  try {
                    final user = _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, Home5.id);
                    }
                    if (user == null) {
                      Navigator.pushNamed(context, WelcomePlante.id);
                    }
                    setState(() {
                      spinLordShow = false;
                    });
                  } catch (e) {
                    print(e);
                  }
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
                    setState(() {
                      spinLordShow = true;
                    });
                    await signInWithGoogle();
                    setState(() {
                      spinLordShow = false;
                    });
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
                    style: TextStyle(color:Colors.black54),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                      print(' now you are in sign up');
                    },
                    child: Text(
                      "Register",
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
    );}
    else{
      return
      Scaffold(
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
                    Navigator.pushNamed(context, Home5.id);
                  },
                  child:  Container(
                      width: size.width*0.5,
                      child: Center(child: Text('continue'))),
                ),
                ElevatedButton(
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pushNamed(context, WelcomePlante.id);
                  },
                  child:  Container(
                      width: size.width*0.5,
                      child: Center(child: Text('log out'))),
                ),

              ],
            ),
          ),
        ),
      );
    }
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
