import 'package:buybharatiya/ui/widgets/categorycontainer.dart';
import 'package:buybharatiya/ui/widgets/productcontainer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../global.dart';
import 'home.dart';


class assembleInIndia extends StatefulWidget {
  final String title;
  const assembleInIndia({Key key, this.title}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return CadburyState();
  }

  static of(BuildContext context) {}
}

class CadburyState extends State<assembleInIndia> {
  ScrollController controller;
  List<products> data2 = [];
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
/*    var db = await FirebaseDatabase.instance.reference();
    await db.once().then((DataSnapshot snapshot){
      var result = snapshot.value as Iterable;
      productsList.clear();
      for(var item in result) {
        print("title"+widget.title);
        if (item['Nationality'] == widget.title) {
          products d = new products(
            item['Brand'],
            item['Category'],
            item['ApproxCost'].toString(),
            item['Description'],
            item['Features&Details'],
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
    AIIndiaProductList.clear();
    for(int i=0; i<productsList.length; i++){
      if(productsList[i].Nationality == widget.title){
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
        AIIndiaProductList.add(d);

      }
    }
      print("Assembled in india"+ AIIndiaProductList.length.toString());

    for (var j = currentLength; j <= currentLength + increment; j++) {

      print( " print indian product list on load " + j.toString()+ " "+ AIIndiaProductList[j].Product);
      products d = new products(
        AIIndiaProductList[j].Brand,
        AIIndiaProductList[j].Category,
        AIIndiaProductList[j].ApproxCost.toString(),
        AIIndiaProductList[j].Description,
        AIIndiaProductList[j].Features,
        AIIndiaProductList[j].ImageLink,
        AIIndiaProductList[j].ProductLink,
        AIIndiaProductList[j].Nationality,
        AIIndiaProductList[j].Product,
        AIIndiaProductList[j].Quantity,
        AIIndiaProductList[j].SubCategory,
        AIIndiaProductList[j].Subsubcategory,
      );
      data2.add(d);
      print("length of data: "+ data2.length.toString());
    }

    setState(() {
      isLoading = false;
      currentLength = data2.length;
    });
    //});
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

                    Text(widget.title,
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
                      child: CategoryContainer(title: "Assembled in India",),
                    ),
                    LazyLoadScrollView(
                        isLoading: isLoading,
                        onEndOfPage: () => getdata(),
                        child:GridView.builder(
                          itemCount: data2.length,
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
                            return ProductContainer(id: index, list: data2,);
                          },
                        )
                    ),
                    /*GridView.builder(
                      itemCount: AIIndiaProductList.length,
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
                        return ProductContainer(id: index, list: AIIndiaProductList,);
                      },
                    )*/

                  ])
          );
        });
  }
}
