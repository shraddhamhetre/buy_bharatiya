import 'dart:io';

import 'package:buybharatiya/ui/screens/fav_Screen.dart';
import 'package:buybharatiya/ui/screens/test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:like_button/like_button.dart';
import 'package:search_widget/search_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global.dart';


class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Widget',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<LeaderBoard> list = <LeaderBoard>[
    LeaderBoard("Flutter", 54),
    LeaderBoard("React", 22.5),
    LeaderBoard("Ionic", 24.7),
    LeaderBoard("Xamarin", 22.1),
  ];

  LeaderBoard _selectedItem;

  bool _show = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Widget"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            //if (_show)
              SearchWidget<LeaderBoard>(
                dataList: list,
                hideSearchBoxWhenItemSelected: false,
                listContainerHeight: MediaQuery.of(context).size.height / 4,
                queryBuilder: (query, list) {
                  return list
                      .where((item) => item.username
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                      .toList();
                },
                /*popupListItemBuilder: (item) {
                  return PopupListItemWidget(item);
                },*/
               /* selectedItemBuilder: (selectedItem, deleteSelectedItem) {
                  return SelectedItemWidget(selectedItem, deleteSelectedItem);
                },*/
                // widget customization
                noItemsFoundWidget: NoItemsFound(),
                textFieldBuilder: (controller, focusNode) {
                  return MyTextField(controller, focusNode);
                },
                onItemSelected: (item) {
                  setState(() {
                    _selectedItem = item;
                  });
                },
              ),
            const SizedBox(
              height: 32,
            ),
            Text(
              "${_selectedItem != null ? _selectedItem.username : ""
                  "No item selected"}",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _show = !_show;
          });
        },
        child: Icon(Icons.swap_horizontal_circle),
      ),
    );
  }
}

class LeaderBoard {
  LeaderBoard(this.username, this.score);

  final String username;
  final double score;
}

class SelectedItemWidget extends StatelessWidget {
  const SelectedItemWidget(this.selectedItem, this.deleteSelectedItem);

  final products selectedItem;
  final VoidCallback deleteSelectedItem;

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      body: */ return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 4,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 8,
                    bottom: 8,
                  ),

                  child: GestureDetector(
                    child: Text(
                      selectedItem.Product,
                      style: const TextStyle(fontSize: 14),
                    ), onTap: () {Navigator.of(context).push(
                      _createRoute(selectedItem));
                  },
                  )
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: 'selectedItem',
                  child: Image.network(
                    "${selectedItem.ImageLink}",
                    fit: BoxFit.cover,
                    // width: double.infinity,
                  ),
                ),
              ),
            ),
            IconButton(
            icon: Icon(Icons.delete_outline, size: 22),
            color: Colors.grey[700],
            onPressed: deleteSelectedItem,
          ),
          ],
        ),
      );

/*    return   Expanded(
        child: SizedBox(
        height: 200.0,
        child:*//*Scaffold(
        backgroundColor: Colors.white,
        *//**//*floatingActionButton: MyFloatingActionButton(id: widget.id),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,*//**//*

        body:*//* Column(
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
                                Icons.favorite,
                              ),
                              onPressed: () =>
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => fav_Screen()),
                                  )),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Hero(
                          tag: '$selectedItem',
                          child: Image.network(
                            "${selectedItem.ImageLink}",
                            width: MediaQuery.of(context).size.width * .7,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),*/
              //const SizedBox(height: 30),

/*              Expanded(
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
                                  "${selectedItem.Product}",
                                  style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold),

                                )  ,
                              ),
                              *//*IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {

                            },
                          ),*//*

                              LikeButton(
                                //size: 2,
                                circleColor:
                                CircleColor(start: *//*Color(0xff00ddff)*//*Colors.grey, end: Colors.red*//*Color(0xff0099cc)*//*),
                                bubblesColor: BubblesColor(
                                  dotPrimaryColor: Colors.pink*//*Color(0xff33b5e5)*//*,
                                  dotSecondaryColor: Colors.red*//*Color(0xff0099cc)*//*,
                                ),
                                //onTap: onLikeButtonTapped,
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    Icons.favorite,
                                    color: isLiked ? Colors.red : Colors.grey,
                                    size: 25,
                                  );
                                },
                              ),
                            ],
                          ),
                          Text(
                            "Quantity: ${selectedItem.Quantity}",
                            style:TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Description: ",
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                            "${selectedItem.Description}",
                          ),

                          Text(
                            "Features & Details: ",
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                            "${selectedItem.Features}",
                          ),
                        ],
                      ),
                    )
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.orangeAccent)
                ),
                  //onPressed: () =>_launchURL(productsList[widget.id].ProductLink),
                  child: const Text('Buy Now', style: TextStyle(fontSize: 20)),
                  color: Colors.orangeAccent,
                  textColor: Colors.white,
                  elevation: 5,
                ),
              )
            ])
        ));*/


  }
}

class MyTextField extends StatelessWidget {
  const MyTextField(this.controller, this.focusNode);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x4437474F),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: "Search here...",
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
          ),
        ),
      ),
    );
  }
}

class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.folder_open,
          size: 24,
          color: Colors.grey[900].withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          "No Items Found",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900].withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.item);

  final products item;

  @override
  Widget build(BuildContext context) {

    /*return Scaffold(
      body:ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: 3,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          //final item = brandlist[index];

          return GestureDetector(
              *//*onTap: (){
                Navigator.of(context).push(_createRoute(brandlist[index]));
              },*//*
              child:  ListTile(
                //leading: new ImageIcon( new AssetImage(brandList[index])),
                title: Text(item.Product),
                trailing: Icon(Icons.keyboard_arrow_right),

              ));
        },
      ),*/
      return Container(
        padding: const EdgeInsets.all(12),
        child: Text(
          item.Product,
          style: const TextStyle(fontSize: 16),
        ),
    );
  }
}

Route _createRoute(id) {
  print("called route");
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => SearchProduct(id: id),
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
class SearchProduct extends StatefulWidget {
  final products id;

  const SearchProduct( {Key key, this.id}) : super(key: key);

  @override
  _DetailsScreen1State createState() => _DetailsScreen1State();
}

class _DetailsScreen1State extends State<SearchProduct> {

  Future<bool> onLikeButtonTapped(bool isLiked) async{
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;


    print("on like" + widget.id.Product);
    products d = new products(
      widget.id.Brand,
      widget.id.Category,
      widget.id.ApproxCost,
      widget.id.Description,
      widget.id.Features,
      widget.id.ImageLink,
      widget.id.ProductLink,
      widget.id.Nationality,
      widget.id.Product,
      widget.id.Quantity,
      widget.id.SubCategory,
      widget.id.Subsubcategory
    );
    if(!isLiked) {
      favList.add(d);
      final prefs = await SharedPreferences.getInstance();
      //final myStringList = prefs.getStringList('my_string_list_key') ?? [];

      prefs.setString('favList', favList.toString());

      print("fav list: "+prefs.getString('favList') ?? []);
    }else{
      favList.remove(d);
    }

    return !isLiked;
  }
  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        /*floatingActionButton: MyFloatingActionButton(id: widget.id),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,*/

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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => fav_Screen()),
                                  )
                          ),
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
                            "${widget.id.ImageLink}",
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
                                  "${widget.id.Product}",
                                  style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold),

                                )  ,
                              ),
                              /*IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {

                            },
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
                            "Quantity: ${widget.id.Quantity}",
                            style:TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Description: ",
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                            "${widget.id.Description}",
                          ),

                          Text(
                            "Features & Details: ",
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                            "${widget.id.Features}",
                          ),
                        ],
                      ),
                    )
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.orangeAccent)
                ),
                  onPressed: () =>_launchURL(widget.id.ProductLink),
                  child: const Text('Buy Now', style: TextStyle(fontSize: 20)),
                  color: Colors.orangeAccent,
                  textColor: Colors.white,
                  elevation: 5,
                ),
              )
            ]),
      ),
    );
  }
}

class MyFloatingActionButton extends StatelessWidget {

  final int id;

  const MyFloatingActionButton({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        backgroundColor: Colors.orangeAccent,

        onPressed: () =>_launchURL(productsList[id].ProductLink),
        label: new Text('Buy Now', style:TextStyle(fontSize: 20,/*fontWeight: FontWeight.bold*/)));
  }
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}