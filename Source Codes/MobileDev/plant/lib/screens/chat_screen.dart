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
    await for (var snapshots in _firestore.collection('messages').snapshots()) {
      for (var m in snapshots.docs) {
        print(m.data());
      }
    }
  }

  var now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
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

      ),
      body: Column(
        children: [
          Container(
            child: StreamBuilder(
                stream: _firestore
                    .collection('messages')
                    .orderBy('time')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container(
                    height: size.height * 0.8,
                    child: ListView(
                      shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),

                      children: snapshot.data.docs.map((document) {
                        if (document['sender'] == "lwenasara63@gmail.com") {
                          return Column(
                            children: [
                              Container(
                                height: size.height * 0.01,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: (Text(
                                      document['text'],
                                      style: TextStyle(color: Colors.black38),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              Container(
                                height: size.height * 0.01,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                padding: EdgeInsets.only(
                                    left: 14, right: 14, top: 10, bottom: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: (Text(
                                    document['text'],
                                    style: TextStyle(color: Colors.black38),
                                  )),
                                ),
                              ),
                            ],
                          );
                        }
                      }).toList(),
                    ),

                  );
                }),
          ),
          SafeArea(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            'time': now,
                          });
                        },
                        child: Text(
                          'Send',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
