import 'package:dailyfish_app/memo_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  _initFirebaseMessaging(BuildContext context){
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print(event.notification!.title);
      print(event.notification!.body);
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("알림"),
            content: Text(event.notification!.body!),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {

    });
  }


  _getToken() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    print("messaging.getToken() , ${await messaging.getToken()}");
  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Firebase Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text('Error'),
            );
          }

          if(snapshot.connectionState == ConnectionState.done){
            _initFirebaseMessaging(context);
            _getToken();
            return MemoPage();
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}