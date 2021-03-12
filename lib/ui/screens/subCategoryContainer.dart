import 'package:buybharatiya/ui/screens/product.dart';
import 'package:buybharatiya/ui/widgets/productcontainer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


import '../../global.dart';
import 'brand.dart';

class SubCategoryContainer extends StatefulWidget {
  final String title;
  const SubCategoryContainer({Key key, this.title}) : super(key: key);


  @override
  _CategoryContainerState createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<SubCategoryContainer> {

  Future <String> getdata() async {
    print("called"+widget.title);
    //db = FirebaseDatabase.instance.reference().child("zoom_users");
    var db = await FirebaseDatabase.instance.reference();
    await db.once().then((DataSnapshot snapshot){
      var result = snapshot.value as Iterable;
      SubCat1.clear();
      for(var item in result) {
        if (item['Category'] == widget.title) {
          print("title1"+widget.title);

          Subcat d = new Subcat(
            item['SubCategory'],
          );
          SubCat1.add(d);
        }
        else if(item['SubCategory'] == widget.title){
          print("true subsubcategory");
          Subcat d = new Subcat(
            item['Subsubcategory'],
          );
          SubCat1.add(d);
      }
      }
      print("count==sub="+ SubCat1.length.toString());
      uniqifyList();
    });
  }
List<String>Subcat2=[];
  void uniqifyList() {
    print("called1");
    for (int i = 0; i < SubCat1.length; i++) {
      print("called2");
      String o = SubCat1[i].SubCategory;
      //Subcat2.add(o);

      if(Subcat2.contains(o)){
        print("dont add");
      }else{
        print("added="+ o);
        Subcat2.add(o);
      }
    }
    print("count2-"+ Subcat2.length.toString());
  }
  @override
  void initState() {
    super.initState();
    //getdata();

  }

  int _active = 0;
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: getdata(),
    initialData: "Loading text..",
    builder: (BuildContext context, AsyncSnapshot<String> text) {
      return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: Subcat2.length,
      itemBuilder: (ctx, i) {
        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(_createRoute(Subcat2[i]));
          },
          child:Container(
            padding: EdgeInsets.all(5.0),
            child:  Column(
                children:<Widget> [
            Container(
            constraints: BoxConstraints(minWidth: 100),
            height: 60,
            width: 120,
            //margin: EdgeInsets.only(right: i == cats.length - 1 ? 0 : 2.0),
            decoration: BoxDecoration(
              color: Colors.white/*_active == i ? Color(0xFFFFF2D8): Color(0xFFFFF2D8)*/,
              borderRadius: BorderRadius.circular(10.0),
              shape: BoxShape.rectangle,
              //border: Border.all(width: 1,color: Colors.white,style: BorderStyle.solid),
              //border: Border.all(width: 1,color: Colors.white,style: BorderStyle.solid),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],


            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*new ImageIcon( new AssetImage(cats[i].icon),*/
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child:Image.asset("assets/subCategory/"+Subcat2[i]+".png", fit: BoxFit.contain, height: 25,),

                    ),
                  ),

                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text("${Subcat2[i]}",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                )

                /*size: 30,
                    ),*/
              ],
            ),
          ),
        ])));
      },
    );
  });
  }
}

Route _createRoute(title) {
  print("called route sub"+title);
  return PageRouteBuilder(
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
