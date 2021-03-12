import 'package:buybharatiya/ui/screens/product.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:queries/collections.dart';


import '../../global.dart';


class Privacy extends StatefulWidget {
  @override
  _categoryListState createState() => _categoryListState();
}

class _categoryListState extends State<Privacy> {

  @override
  Widget build(BuildContext context) {
    final title = 'Privacy Policy';

    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(
            title: Text(title),
            backgroundColor: Colors.black,

          ),
          body: new SingleChildScrollView(
            //constraints: new BoxConstraints(),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    Policy,
                    style:TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          )      ),
    );
  }
}

