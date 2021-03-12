import 'package:buybharatiya/ui/screens/test.dart';
import 'package:buybharatiya/ui/widgets/Slide_Image.dart';
import 'package:buybharatiya/ui/widgets/categorycontainer.dart';
import 'package:buybharatiya/ui/widgets/productcontainer.dart';
import 'package:buybharatiya/ui/widgets/search.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:search_widget/search_widget.dart';
import '../../global.dart';
import 'TopPicks.dart';
import "dart:math";
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';



BuildContext mContext;
final orientation = MediaQuery.of(mContext).orientation;
final _random = new Random();
int element1;

class mainUi extends StatefulWidget {


  @override
  _HomeScreenState1 createState() => _HomeScreenState1();
}

class _HomeScreenState1 extends State<mainUi> {
  ScrollController controller;
  List<products> data = [];
  int currentLength = 0;

  final int increment = 8;
  bool isLoading = false;


  products _selectedItem;
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    //_loadMore();

    super.initState();


  }
  Future <String> getdata() async {
    print("called");
    //db = FirebaseDatabase.instance.reference().child("zoom_users");
    /*  var db = await FirebaseDatabase.instance.reference();
    await db.once().then((DataSnapshot snapshot) {
      var result = snapshot.value as Iterable;*/
    indianProductsList.clear();
    for(int i=0; i<productsList.length; i++){
      if(productsList[i].Nationality == "Indian"){
        products d = new products(
          productsList[i].Brand,
          productsList[i].Category,
          productsList[i].ApproxCost.toString(),
          productsList[i].Description,
          productsList[i].Features,
          productsList[i].ImageLink,
          productsList[i].ProductLink,
          productsList[i].Nationality,
          productsList[i].Product,
          productsList[i].Quantity,
          productsList[i].SubCategory,
          productsList[i].Subsubcategory,

        );
        indianProductsList.add(d);

      }
    }
    /*for (var item in result) {
        if (item['Nationality'] == "Indian") {
        //print("=="+item["Brand"].toString());
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
        );
        productsList.add(d);
      }
      }*/

    print(" productsList count1=" + indianProductsList.length.toString());


    toppicks.clear();
    for(int i=0; i<productsList.length; i++){
      if(productsList[i].Category == "Top Picks"){
        products d = new products(
          productsList[i].Brand,
          productsList[i].Category,
          productsList[i].ApproxCost.toString(),
          productsList[i].Description,
          productsList[i].Features,
          productsList[i].ImageLink,
          productsList[i].ProductLink,
          productsList[i].Nationality,
          productsList[i].Product,
          productsList[i].Quantity,
          productsList[i].SubCategory,
          productsList[i].Subsubcategory,

        );
        toppicks.add(d);
      }
    }


    /*for (int i in productsList) {
        if (productsList[i].Category == "Top Picks") {
          print("toppicks");
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
          );
          toppicks.add(d);
        }
      }*/
    print("counttoppicks"+toppicks.length.toString());

    print("_loadMore called");
    setState(() {
      isLoading = true;
    });

    // Add in an artificial delay
    await new Future.delayed(const Duration(seconds: 5));
    for (var j = currentLength; j <= currentLength + increment; j++) {

      print( " print indian product list on load " + j.toString()+ " "+ indianProductsList[j].Product);
      products d = new products(
        indianProductsList[j].Brand,
        indianProductsList[j].Category,
        indianProductsList[j].ApproxCost.toString(),
        indianProductsList[j].Description,
        indianProductsList[j].Features,
        indianProductsList[j].ImageLink,
        indianProductsList[j].ProductLink,
        indianProductsList[j].Nationality,
        indianProductsList[j].Product,
        indianProductsList[j].Quantity,
        indianProductsList[j].SubCategory,
        indianProductsList[j].Subsubcategory,
      );
      data.add(d);
      print("length of data: "+ data.length.toString());
    }
    setState(() {
      isLoading = false;
      currentLength = data.length;
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;

    return new FutureBuilder(
        future: getdata(),
        initialData: "Loading text..",
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return Container(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 100,
                        child: CategoryContainer(title: "Indian"),
                      ),
                      CompilcatedImageDemo(),

                      SizedBox(
                        height: 15,
                      ),

                      Text(
                        " Top Picks",
                        style: Theme
                            .of(context)
                            .textTheme
                            .title
                            .apply(
                          fontWeightDelta: 2,
                        ),
                      ),

                  Container(
                      height: 200.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: toppicks.length,
                        itemBuilder: (BuildContext context, int id) =>
                        new GestureDetector(
                          onTap: () {
                          Navigator.of(context).push(
                          _createRoute1(id, toppicks));

                        },
                          child: new Card(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              width: /*MediaQuery.of(context).size.width/3*/150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  /*Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:Text(toppicks[id].ApproxCost, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),

                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:LikeButton(
                                          onTap: onLikeButtonTapped(toppicks[id]),
                                          likeBuilder: (bool isLiked) {
                                            return Icon(
                                              Icons.bookmark,
                                              color: isLiked ? Colors.orangeAccent : Colors.lightBlue,
                                              size: 25,
                                            );
                                          },
                                        ),

                                      ),
                                    ],),*/
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Hero(
                                        tag: 'tagImage$id',
                                        child: Image.network(
                                          "${toppicks[id].ImageLink}",
                                          fit: BoxFit.cover,
                                          // width: double.infinity,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(15.0),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFBFEAF0),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(9.0),
                                      ),
                                    ),
                                    child: Text(
                                        "${toppicks[id].Product}",
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),),
                        ),
                  ),
                      SizedBox(
                        height: 15,
                      ),
                      forAdv(),


                      SizedBox(
                        height: 15,
                      ),

                      Text(
                        " Indian Products",
                        style: Theme
                            .of(context)
                            .textTheme
                            .title
                            .apply(
                          fontWeightDelta: 2,
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),

                      LazyLoadScrollView(
                        isLoading: isLoading,
                        onEndOfPage: () => getdata(),
                        child: GridView.builder(
                          itemCount: data.length,
                          controller: controller,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: .7
                          ),
                          itemBuilder: (BuildContext context, int index) {

                            return ProductContainer(id: index, list: data,);
                          },
                        ),
                      ),
                   /*GridView.builder(
                        itemCount: indianProductsList.length,
                        controller: controller,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: .7
                        ),
                        itemBuilder: (BuildContext context, int index) {

                          return ProductContainer(id: index, list: indianProductsList,);
                        },
                      ),*/
                  /*),*/
                    ],
                  ),

                ),

          );
        });
  }


  }




Route _createRoute1(id, list) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => DetailsScreen1(id: id, list: list,),
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




