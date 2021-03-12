
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import '../../constant.dart';
import '../../getAllData.dart';
import 'home.dart';
import 'orders.dart';

class Splash extends StatefulWidget {
  @override
  _Splash createState() => new _Splash();
}

class _Splash extends State<Splash>  with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;
  bool _testValue= false;



  startTime() async {
    var _duration = new Duration(seconds: 6);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    //Navigator.of(context).pushReplacementNamed(HOME_SCREEN);
    /*Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );*/
    Navigator.of(context).pop();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
        ModalRoute.withName('/'));

  }

  @override
  void initState() {
    super.initState();
    GetAllData();
    startTime();

  }

  @override
  Widget build(BuildContext context) {

    if(!_testValue){
      print("testvalue"+ _testValue.toString());
      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Padding(padding: EdgeInsets.only(bottom: 80.0),
                    child:new Image.asset('assets/img/namaste.png',fit: BoxFit.scaleDown,
                      height: 200,))


              ],),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset(
                  'assets/img/Buy Bharatiya-01.png',
                  width: /*animation.value * */250,
                  height:/* animation.value * */250,
                ),
              ],
            ),
          ],
        ),
      );
    }else{
      print("else testvalue"+ _testValue.toString());

      return HomeScreen();
    }

  }
  }
/*  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new HomeScreen(),

        image: Image.asset("assets/img/Buy Bharatiya.jpg"),
        //backgroundColor: Colors.white,
        //styleTextUnderTheLoader: new TextStyle(),
        photoSize: 150.0,
        //onClick: ()=>print("Flutter Egypt"),
        loaderColor: Colors.white

    );
  }*/
