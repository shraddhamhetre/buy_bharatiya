import 'dart:async';

import 'package:buybharatiya/ui/database.dart';
import 'package:buybharatiya/ui/screens/home.dart';
import 'package:buybharatiya/ui/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'global.dart';



void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  bool _testValue= false;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;
  Future <String>  updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        this.noteList = noteList;
        this.count = noteList.length;
        favList2.clear();
        print("noteList1: " +noteList.length.toString());
        for (int j = 0; j < noteList.length; j++) {
          Note d = new Note(
            noteList[j].Product,
            noteList[j].ProductLink,
            noteList[j].ImageLink,
              true.toString()

          );
          favList2.add(d);
        }
        print("favlist2: " +favList2.length.toString());

      });
    });
  }

  @override
  void initState() {
    super.initState();
    checkSplash();
    //updateListView();
    DatabaseHelper();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );
  }

  checkSplash() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BuildContext context;
    const String IsSplashScreenOpened = 'IsSplashScreenOpened';
    _testValue= (prefs.getBool(IsSplashScreenOpened)?? false);
    if(!(_testValue)) {
      print("called Splashscreen");
      _testValue = await prefs.setBool('IsSplashScreenOpened', true);

      //return Splash();
    }else{
      print("called HomeScreen");
      return HomeScreen();
    }
    print("TestVal: "+ _testValue.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'OpenSans',
      ),
      /*home: HomeScreen(),
      routes: {
        'orderscreen' : (ctx) => OrdersScreen()
      },*/
      home: Splash(),
      routes:  <String, WidgetBuilder>{
        'HOME_SCREEN' : (ctx) => HomeScreen(),
        '/splashScreen': (BuildContext context) => new Splash(),


      },
    );
  }
}



