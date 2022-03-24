import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Color(0xFF0C9869),
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Color(0xFF0C9869), width: 2.0),
  ),
);

const kInputsTextDecoration = InputDecoration(
  hintText: 'Enter your value.',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF0C9869), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF0C9869), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);



// Colors that we use in our app
const kPrimaryColor = Color(0xFF0C9869);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);
const double kDefaultPadding = 20.0;
// Colors that we use in home
const kHomeAppbarColor = Color(0xFF0C9869);
const kAppBarColor = Colors.black87;




// colours for google login
const kAquaHaze = Color(0xFFEAF3F3);
const kHarlequin = Color(0xFF26F80E);
const kBoulder = Color(0xFF747474);
const kAqua = Color(0xFF2EFCFC);
const kHeavyMetal = Color(0xFF212321);
const kBlack = Color(0xFF040404);
const kGreenE = Color(0xFFC7CDB6);




