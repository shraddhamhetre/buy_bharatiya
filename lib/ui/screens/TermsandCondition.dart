import 'package:buybharatiya/ui/screens/product.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:queries/collections.dart';


import '../../global.dart';


class Terms1 extends StatefulWidget {
  @override
  _categoryListState createState() => _categoryListState();
}

class _categoryListState extends State<Terms1> {

  @override
  Widget build(BuildContext context) {
    final title = 'Terms & Conditions';

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
              Terms,
              style: TextStyle(fontSize: 10),

            ),
          ),
        ],
      ),
    )      ),
    );
  }
}
