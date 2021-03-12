import 'package:buybharatiya/ui/widgets/categorycontainer.dart';
import 'package:buybharatiya/ui/widgets/productcontainer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../global.dart';
import 'Global_Container.dart';
import 'home.dart';


class Global extends StatefulWidget {
  final String title;
  const Global({Key key, this.title}) : super(key: key);



  @override
  State<StatefulWidget> createState() {
    return CadburyState();
  }

  static of(BuildContext context) {}
}

class CadburyState extends State<Global> {
  List<products> data3 = [];
  int currentLength = 0;

  final int increment = 8;
  bool isLoading = false;


  Future <String> getdata() async {
    print("called"+widget.title);
    setState(() {
      isLoading = true;
    });

    await new Future.delayed(const Duration(seconds: 5));
    //db = FirebaseDatabase.instance.reference().child("zoom_users");
    var db = await FirebaseDatabase.instance.reference();
    await db.once().then((DataSnapshot snapshot){
      var result = snapshot.value as Iterable;
      GlobalProductList.clear();

      for(int i=0; i<productsList.length; i++){
        if (productsList[i].Nationality == widget.title) {
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
          GlobalProductList.add(d);
        }
      }
      print("count"+ productsList.length.toString());
    });

    for (var j = currentLength; j <= currentLength + increment; j++) {
      print( " print indian product list on load " + j.toString()+ " "+ GlobalProductList[j].Product);
      products d = new products(
        GlobalProductList[j].Brand,
        GlobalProductList[j].Category,
        GlobalProductList[j].ApproxCost.toString(),
        GlobalProductList[j].Description,
        GlobalProductList[j].Features,
        GlobalProductList[j].ImageLink,
        GlobalProductList[j].ProductLink,
        GlobalProductList[j].Nationality,
        GlobalProductList[j].Product,
        GlobalProductList[j].Quantity,
        GlobalProductList[j].SubCategory,
        GlobalProductList[j].Subsubcategory,
      );
      data3.add(d);
      print("length of data: "+ data3.length.toString());
    }

    setState(() {
      isLoading = false;
      currentLength = data3.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: getdata(),
        initialData: "Loading text..",
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text("Global Products",
                          style: Theme
                              .of(context)
                              .textTheme
                              .title
                              .apply(
                            fontWeightDelta: 2,
                          ),
                        ),

                        Container(
                          height: 100,
                          child: CategoryContainer(title: "Others",),
                        ),
                        LazyLoadScrollView(
                            isLoading: isLoading,
                            onEndOfPage: () => getdata(),
                            child:GridView.builder(
                              itemCount: data3.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                                  crossAxisCount: 1,
                                  crossAxisSpacing: 1,
                                  mainAxisSpacing: 1,
                                  childAspectRatio: .7
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Global_Container(id: index, list: GlobalProductList,);
                              },
                            )
                        ),


                        /*GridView.builder(
                          itemCount: GlobalProductList.length,
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
                            return ProductContainer(id: index, list: GlobalProductList,);
                          },
                        )*/

                      ])
              );
        });
  }
}
