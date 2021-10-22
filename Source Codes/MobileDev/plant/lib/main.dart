// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plant/screens/chat_screen.dart';
import 'package:plant/screens/home_screen2.dart';
import 'package:plant/screens/login_screen.dart';
import 'package:plant/screens/registration_screen.dart';
import 'package:plant/screens/welcome_screen.dart';
import 'package:plant/screens/home_screen.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        HomeScreen.id: (context) => HomeScreen(),

        Home5.id: (context) => Home5(),
      },
    );
  }
}

