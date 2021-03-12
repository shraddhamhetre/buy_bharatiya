import 'package:buybharatiya/ui/screens/product.dart';
import 'package:buybharatiya/ui/widgets/productcontainer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


import '../../global.dart';

class TopPicks extends StatefulWidget {
  const TopPicks({
    Key key,
  }) : super(key: key);

  @override
  _CategoryContainerState createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<TopPicks> {

  Future <String> getdata() async {
    //print("called"+widget.title);
    //db = FirebaseDatabase.instance.reference().child("zoom_users");
    var db = await FirebaseDatabase.instance.reference();
    await db.once().then((DataSnapshot snapshot){
      var result = snapshot.value as Iterable;
      productsList.clear();

      for(var item in result) {

        print("=="+item["Category"].toString());
        if (item['Category'] == "Top Picks" ) {
          products d = new products(
            item['Brand'],
            item['Category'],
            item['ApproxCost'].toString(),
            item['Description'],
            item['FeaturesDetails'],
            item['ImageLink'],
            item['ProductLink'],
            item['Nationality'],
            item['Product'],
            item['Quantity'],
            item['SubCategory'],
            item['SubsubCategory'],

          );
          productsList.add(d);
        }
      }
      print("Top picks"+ productsList.length.toString());
    });
  }
  @override
  void initState() {
    super.initState();
    //getdata();

  }

  int _active = 0;
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 100.0,

      child: new ListView.builder(itemBuilder: (context, index){
        return new Card(child: new Container(width: 80.0,
          child: new Text('Hello'),alignment: Alignment.center,));
      }, scrollDirection: Axis.horizontal,),
    );
  }
}

