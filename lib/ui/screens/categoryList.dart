import 'package:buybharatiya/ui/screens/brand.dart';
import 'package:buybharatiya/ui/screens/product.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../global.dart';


class categoryList extends StatefulWidget {


  @override
  _categoryListState createState() => _categoryListState();
}

class _categoryListState extends State<categoryList> {

  Future <String> getdata() async {
    //db = FirebaseDatabase.instance.reference().child("zoom_users");
    var db = await FirebaseDatabase.instance.reference();
    await db.once().then((DataSnapshot snapshot){
      var result = snapshot.value as Iterable;
      Category1.clear();
      for(var item in result) {
        category d = new category(
          item['Category'],
        );
        Category1.add(d);
      }
      print("count==sub="+ Category1.length.toString());
      uniqifyList();
    });
  }
  List<String>Category2=[];
  void uniqifyList() {
    for (int i = 0; i < Category1.length; i++) {
      String o = Category1[i].Category;
      //Subcat2.add(o);

      if(Category2.contains(o)){
      }else{
        Category2.add(o);
      }
    }
    print("count2-"+ Category2.length.toString());
  }
  @override
  Widget build(BuildContext context) {
    final title = 'Categories';
    return FutureBuilder(future: getdata(),
    initialData: "Loading text..",
    builder: (BuildContext context, AsyncSnapshot<String> text) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.black,

        ),
        body: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: Category2.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            //final item = cats[index];

            return GestureDetector(
                onTap: (){
                  Navigator.of(context).push(_createRoute(Category2[index]));
                },
              child: Container(
                height: 50,
                child: Card(
                    child: Center(
                      child: ListTile(
                        contentPadding: new EdgeInsets.only(bottom: 15, left: 15),
                        leading: new Image(
                          image: new AssetImage("assets/categoriesicon/"+Category2[index]+".png"),

                          color: null,
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center,
                        ),
                        title: Text(Category2[index]),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    )

                ),
              )
            );
          },
        ),
      ),
    );
    }
    );}


}

Route _createRoute(title) {
  print("called route"+title);
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => product1(title: title),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 2.0);
      var end = Offset.zero;
      var curve = Curves.easeOutCirc;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}