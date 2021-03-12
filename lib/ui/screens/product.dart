import 'package:buybharatiya/ui/screens/subCategoryContainer.dart';
import 'package:buybharatiya/ui/widgets/categorycontainer.dart';
import 'package:buybharatiya/ui/widgets/productcontainer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../global.dart';
import 'home.dart';


class product extends StatefulWidget {
  final String title;
  final String nationality;

  const product({Key key, this.title, this.nationality}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return CadburyState();
  }
}

class CadburyState extends State<product> {
  List<products> data1 = [];
  int currentLength = 0;

  final int increment = 8;
  bool isLoading = false;

  Future _loadMore() async {
    print("_loadMore called");

  }



    Future <String> getdata() async {

    setState(() {
      isLoading = true;
    });

    await new Future.delayed(const Duration(seconds: 5));


    print("category called"+widget.title+" "+widget.nationality);
    categoryProductList.clear();
    for(int i=0; i<productsList.length; i++){
        if ((productsList[i].Category == widget.title || productsList[i].Brand == widget.title || productsList[i].SubCategory == widget.title || productsList[i].Subsubcategory == widget.title) && (productsList[i].Nationality == widget.nationality)) {
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
          categoryProductList.add(d);
        }
      }
      print("categoryProductList:"+ categoryProductList.length.toString());

    for (var j = currentLength; j <= currentLength + increment; j++) {

      print( " print indian product list on load " + j.toString()+ " "+ categoryProductList[j].Product);
      products d = new products(
        categoryProductList[j].Brand,
        categoryProductList[j].Category,
        categoryProductList[j].ApproxCost.toString(),
        categoryProductList[j].Description,
        categoryProductList[j].Features,
        categoryProductList[j].ImageLink,
        categoryProductList[j].ProductLink,
        categoryProductList[j].Nationality,
        categoryProductList[j].Product,
        categoryProductList[j].Quantity,
        categoryProductList[j].SubCategory,
        categoryProductList[j].Subsubcategory,
      );
      data1.add(d);
      print("length of data: "+ data1.length.toString());
    }

    setState(() {
      isLoading = false;
      currentLength = data1.length;
    });
    /*});*/
  }

  @override
  Widget build(BuildContext context) {

    return new FutureBuilder(
        future: getdata(),
        initialData: "Loading text..",
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return new Scaffold(

              appBar: AppBar(
                centerTitle: true,

                title: new Row
                  (
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                  [
                    Container(padding: const EdgeInsets.all(30.0),
                        child: new Row(
                          children: <Widget>[
                            Image.asset('assets/img/buybhartiya icon.png',
                              fit: BoxFit.contain, height: 50,),

                            Center(
                              child: Text('Buy Bharatiya',
                                style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
                iconTheme: IconThemeData(color: Colors.black54),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              //backgroundColor: MyColor.colorRed,
              body: SingleChildScrollView(
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

                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 100,
                          child: SubCategoryContainer(title: widget.title),
                        ),
                        LazyLoadScrollView(
                          isLoading: isLoading,
                          onEndOfPage: () => _loadMore(),
                          child:GridView.builder(
                            itemCount: data1.length,
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
                              return ProductContainer(id: index, list: data1,);
                            },
                          )
                        ),
                        /*GridView.builder(
                          itemCount: categoryProductList.length,
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
                            return ProductContainer(id: index, list: categoryProductList,);
                          },
                        )*/

                      ])
              ));
        });
  }
}