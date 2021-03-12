import 'package:buybharatiya/ui/screens/test.dart';
import 'package:buybharatiya/ui/widgets/productcontainer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../global.dart';
import '../database.dart';
import 'home.dart';


class favourite extends StatefulWidget {
  final String title;
  const favourite({Key key, this.title}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return CadburyState();
  }
}

class CadburyState extends State<favourite> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  Future <String>  updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        this.noteList = noteList;
        this.count = noteList.length;
        favList2.clear();
        print("noteList1: " +noteList.length.toString());
        for (int j = 0; j < noteList.length; j++) {

            print("note added");
            Note d = new Note(
                noteList[j].Product,
                noteList[j].ProductLink,
                noteList[j].ImageLink,
                true.toString()
            );
            favList2.add(d);
        }
        print("favlist2: " +favList2.length.toString());

      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: updateListView(),
        initialData: "Loading text..",

        builder: (BuildContext context, AsyncSnapshot<String> text) {
          //return new Scaffold(
          /*bottomNavigationBar:
              CurvedNavigationBar(
                height: 60,

                backgroundColor: Colors.white,
                color: Colors.orangeAccent,
                items: <Widget>[
                  Image.asset('assets/categoriesicon/madeinIndia.png', fit: BoxFit.contain, height: 50,),
                  Image.asset('assets/categoriesicon/Assembleinindia.png', fit: BoxFit.fill, height: 50,),
                  Image.asset('assets/categoriesicon/global.png', fit: BoxFit.contain, height: 50,),
                  Icon(Icons.favorite, size: 25),
                ],
                onTap: (index) {
                  print("index"+ index.toString());
                  Navigator.of(context).push(
                      goToPage(index)
                  );
                },
              ),*/
          /*appBar: AppBar(
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
              ),*/
          //backgroundColor: MyColor.colorRed,

          return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text("Saved products",
                      style: Theme
                          .of(context)
                          .textTheme
                          .title
                          .apply(
                        fontWeightDelta: 2,
                      ),
                    ),
                    //getTasListView(),
                    favList2.isNotEmpty ? ListView.builder(
                      itemCount: favList2.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int id1) {

                        return GestureDetector(
                          /*onTap: (){
                            Navigator.of(context).push(
                                _createRoute(id1));
                          },*/
                          child: Card(
                            color: Colors.white,

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 5,
                                        top: 8,
                                        bottom: 8,
                                      ),

                                      child:
                                      Padding(
                                        padding: EdgeInsets.only(top: 18),
                                        child: Text(
                                          favList2[id1].Product,
                                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                        ),
                                      ),

                                    )
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Hero(
                                      tag: '${id1}',
                                      child: Image.network(
                                        "${favList2[id1].ImageLink}",
                                        fit: BoxFit.cover,
                                        height: 80,
                                        // width: double.infinity,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.delete_outline, size: 22,color: Colors.black54,),
                                      color: Colors.black54,
                                      onPressed: () {
                                        setState(() {
                                          favList2.removeAt(id1);
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.launch, size: 22, color: Colors.black54),
                                      color: Colors.black54,
                                      onPressed:()=> _launchURL(favList2[id1].ProductLink),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ) : Container(
                        height: MediaQuery. of(context). size. height / 1.5,


                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center, // Align however you like (i.e .centerRight, centerLeft)
                              child: Text("You have no saved products yet.", style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.center, // Align however you like (i.e .centerRight, centerLeft)
                                child: Text("All the products you have saved will show up here.", style: TextStyle(fontSize: 10),),
                              ),
                            )
                          ],
                        )
                    ),
                  ])
            // )
          );
        });
  }
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


Route _createRoute(id) {
  print("called route");
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => DetailsScreen2(id: id),
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

class DetailsScreen2 extends StatefulWidget {
  final int id;

  const DetailsScreen2({Key key, this.id}) : super(key: key);

  @override
  _DetailsScreen1State createState() => _DetailsScreen1State();
}

class _DetailsScreen1State extends State<DetailsScreen2> {


  Future<bool> onLikeButtonTapped(bool isLiked) async{
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;
    if(!isLiked) {
      print("on like" + widget.id.toString() + isLiked.toString());
      products d = new products(
        productsList[widget.id].Brand,
        productsList[widget.id].Category,
        productsList[widget.id].ApproxCost,
        productsList[widget.id].Description,
        productsList[widget.id].Features,
        productsList[widget.id].ImageLink,
        productsList[widget.id].ProductLink,
        productsList[widget.id].Nationality,
        productsList[widget.id].Product,
        productsList[widget.id].Quantity,
        productsList[widget.id].SubCategory,
        productsList[widget.id].Subsubcategory,

      );
      favList.add(d);
    }

    return !isLiked;
  }
  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    /*return new FutureBuilder(future: updateListView(),
    initialData: "Loading text..",
    builder: (BuildContext context, AsyncSnapshot<String> text) {*/
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: MyFloatingActionButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          /*floatingActionButton: FloatingActionButton.extended(
            onPressed: () => {},
            label: new Text('Buy Now')),*/

          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.chevron_left,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),

                            IconButton(
                              icon: Icon(
                                Icons.bookmark,
                              ),
                              onPressed: () =>
                                  MaterialPageRoute(builder: (context) => favourite()),
                            )
                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Hero(
                            tag: '${widget.id}',
                            child: Image.network(
                              "${favList[widget.id].ImageLink}",
                              width: MediaQuery.of(context).size.width * .7,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //const SizedBox(height: 30),

                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xfff9f9f9),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      padding: const EdgeInsets.all(15.0),
                      child: new SingleChildScrollView(
                        //constraints: new BoxConstraints(),
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child:Text(
                                    "${favList[widget.id].Product}",
                                    style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold),

                                  )  ,
                                ),
                                /*IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {},
                          ),*/

                                LikeButton(
                                  onTap: onLikeButtonTapped,
                                  likeBuilder: (bool isLiked) {
                                    return Icon(isLiked ? Icons.bookmark : Icons.bookmark_border,
                                      color: isLiked ? Colors.orangeAccent : Colors.black,
                                      size: 40,
                                    );
                                  },
                                ),
                              ],
                            ),
                            Text(
                              "Quantity: ${favList[widget.id].Quantity}",
                              style:TextStyle(fontSize: 18),
                            ),
                            Text(
                              "Description: ",
                              style: Theme.of(context).textTheme.title,
                            ),
                            Text(
                              "${favList[widget.id].Description}",
                            ),

                            Text(
                              "Features & Details: ",
                              style: Theme.of(context).textTheme.title,
                            ),
                            Text(
                              "${favList[widget.id].Features}",
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: RaisedButton(shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.orangeAccent)
                              ),
                                onPressed: () =>_launchURL(Sub1[widget.id].ProductLink),
                                child: const Text('Buy Now', style: TextStyle(fontSize: 20)),
                                color: Colors.orangeAccent,
                                textColor: Colors.white,
                                elevation: 5,
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
              ]),
        ),
      );

    /*}
    );*/


  }
}

class MyFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        backgroundColor: Colors.orangeAccent,

        onPressed: () => {},
        label: new Text('Buy Now', style:TextStyle(fontSize: 20,/*fontWeight: FontWeight.bold*/)));
  }
}

