import 'dart:io';

import 'package:yatu/bizScreens/home_screen.dart';
import 'package:yatu/constants/Firebasae_constant.dart';
import 'package:yatu/models/user.dart';
import 'package:yatu/chat/chat_screen.dart';
import 'package:yatu/chat/chatProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'chatProvider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ChatProvider chatProvider = ChatProvider();
  @override
  void initState() {
    // chatProvider.registerNotification();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // print(FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors:
                [
                  Colors.cyan,
                  Colors.cyan,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeScreen()));
            }),
        title: Text("Messages"),
        automaticallyImplyLeading: false,
        centerTitle: true,
       /* actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: Text("Signout"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ], */
      ),
       body: StreamBuilder(
           stream: FirebaseFirestore.instance
               .collection("Biz")
              .where('uid',
                  isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
               .snapshots(),
          builder: ((context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
             if (snapshot.connectionState == ConnectionState.waiting) {
               return const Center(
                 child: CircularProgressIndicator(),
               );
             }
             if (!snapshot.hasData) {
               return const Center(
                 child: CircularProgressIndicator(),
               );
             }
             return ListView.builder(
               itemCount: snapshot.data!.docs.length,
               itemBuilder: (context, index) {
                 UserModel user = UserModel.fromJson(snapshot.data!.docs[index]);

                 return InkWell(
                   autofocus: true,
                   onTap: () {
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => Chat_Screen(uid: user.uid),
                         ));
                   },
                   child: ListTile(
                     textColor: Colors.cyan,
                     title: Text(user.name),
                     subtitle: Text(user.email),
                   ),
                 );
               },
             );
           })),
    );
  }
}