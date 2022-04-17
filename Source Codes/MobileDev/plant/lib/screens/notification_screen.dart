// @dart=2.9
import 'package:flutter/material.dart';
import 'package:plant/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;




class NotificationScreen extends StatefulWidget {
  static const String id = 'notification_screen';

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  var loggedInUser;
  String useremail2 = ' ';
  String messagetext;



  void geturlfromup(String id3) async {
    final messages1 = await _firestore.collection('uploads').doc(id3).get();
    {
     // print(messages1.data()['downloadURL']);
       messages1.data()['downloadURL'];
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    //print(geturlfromup("Khc1T6CRMmN0pCe1b6N1"));
    //print(Mgeturlfromuplord("Khc1T6CRMmN0pCe1b6N1"));

  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    if (user != null) {
      print('checkpoint1');
      setState(() {
        useremail2 = user.email;
      });
//var loggedInUSer;
      //loggedInUser==user;
      print(user.email);
    } else {
      print('check2');
    }
  }





  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('notifications'),backgroundColor: kAppBarColor,),
      body: StreamBuilder(
          stream: _firestore.collection('replies').orderBy('time').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data.docs.map((document)  {
                Timestamp timestamp = document['time'];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      height: size.height*0.2,
                      color: kHarlequin,
                      child: Row(
                        children: [
                          Container(
                              //height: size.height * 0.1,

                              // images/comment.png
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Container(
                                 padding: const EdgeInsets.all(6.0),
                                //  height: size.height * 0.5,
                                  width:size.width*0.4,
                                  child:
                                 Image.network(document['imagecon']))),

                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    document['message'],
                                  overflow: TextOverflow.ellipsis,


                                  ),
                              ),
                              Align(
                                  alignment: Alignment.bottomLeft,

                                  child: Text(timeago.format(DateTime.tryParse(timestamp.toDate().toString())).toString())),
                            ],
                          ),

                        ],
                      )),
                );

              }).toList(),
            );
          }
      ),
    );
  }
}



