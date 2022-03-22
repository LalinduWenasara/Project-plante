// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Treatment extends StatefulWidget {
  static const String id = 'TreatmentScreen';

  String value1;
  String treatment;
  Treatment({this.value1, this.treatment});
  @override
  _TreatmentState createState() => _TreatmentState(value1, treatment);
}

class _TreatmentState extends State<Treatment> {
  String value1;
  String thetreatment;

  _TreatmentState(this.value1, this.thetreatment);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

/*
  final _firestore = FirebaseFirestore.instance;
  void getMessages() async {
    final messages1 = await _firestore.collection('treatment').get();
    for (var m in messages1.docs) {
      print(m.data());
    }
  }
*/

  @override
  Widget build(BuildContext context) {
    if (thetreatment != null)
      return Scaffold(
        appBar: AppBar(
          title: Text(value1),
        ),
        body: Text(thetreatment),
      );
    else
      return Scaffold(
        appBar: AppBar(
          title: Text(value1),
        ),
        body: Text('OOps Connection Error'),
      );
  }
}
