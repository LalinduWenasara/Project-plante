// @dart=2.9
import 'package:flutter/material.dart';
import 'package:plant/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  var loggedInUser;
  String useremail2 = ' ';
  String messagetext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
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
/*
  void getMessages() async {
    final messages1 = await _firestore.collection('messages').get();
    for (var m in messages1.docs) {
      print(m.data());
    }
  }
*/

  void MessagesStram() async {

    await for (var snapshots in   _firestore.collection('messages').snapshots()) {
      for (var m in snapshots.docs) {
        print(m.data());
      }
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[

          Row(
            children: [
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    MessagesStram();
                    /*  _auth.signOut();
                      Navigator.pop(context);

*/
                  }),
              IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {

                      _auth.signOut();
                      Navigator.pop(context);


                  }),
            ],
          ),
        ],
        title: Center(child: Text(useremail2)),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[



              /*    StreamBuilder <QuerySnapshot>(
                      stream: _firestore.collection('message').snapshots(),
                      builder:(context,snapshot){
                        if(snapshot.hasData){
                          final messages=snapshot.data.docs;
                          List<Text> messageWidgets=[];
                          messages.forEach((doc) {
                            print(doc["text"]);
                            final messageText = doc["text"];
                            final messageWidget= Text('$messageText from $messageText ');
                            messageWidgets.add(messageWidget);
                          });
                            return Column(
                            children: messageWidgets,
                          );
                        }
                      }, ),


*/
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messagetext = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('****************');
                      print(messagetext);
                      print(messagetext);
                      _firestore.collection('messages').add({
                        'text': messagetext,
                        'sender': useremail2,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),













          ],
        ),
      ),
    );
  }
}
