import 'package:buybharatiya/ui/screens/product.dart';
import 'package:buybharatiya/ui/widgets/productcontainer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


import '../../getAllData.dart';
import '../../global.dart';

class CategoryContainer extends StatefulWidget {
  final String title;
  const CategoryContainer({Key key, this.title}) : super(key: key);

  @override
  _CategoryContainerState createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {

  Future <String> getdata() async {
    print("called"+widget.title);
    //db = FirebaseDatabase.instance.reference().child("zoom_users");
    var db = await FirebaseDatabase.instance.reference();
    await db.once().then((DataSnapshot snapshot){
      var result = snapshot.value as Iterable;
      Category1.clear();
      for(var item in result) {
        if (item['Nationality'] == widget.title) {
          category d = new category(
            item['Category'],
          );
          Category1.add(d);
        }
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
  void initState() {
    super.initState();
    print("category final in page:" + Category2.length.toString());
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
      itemCount: Category2.length,
      itemBuilder: (ctx, i) {
        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(_createRoute(Category2[i], widget.title));
          },
            //0xFFFFF2D8
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
                            child:Image.asset("assets/categoriesicon/"+Category2[i]+".png", fit: BoxFit.contain, height: 25,),

                          ),
                        ),

                      ),
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text("${Category2[i]}",
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
              ],
            ),
          )
        );
      },
    );
  }
  );
  }
}

Route _createRoute(title, nationality) {
  print("called route"+title+ nationality);
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => product(title: title, nationality: nationality),
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
