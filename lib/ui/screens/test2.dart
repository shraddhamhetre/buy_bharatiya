import 'package:buybharatiya/ui/screens/fav_Screen.dart';
import 'package:buybharatiya/ui/widgets/search.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:like_button/like_button.dart';
import '../../global.dart';
import '../database.dart';
import 'favourite.dart';

class DetailsScreenTopPicks extends StatefulWidget {
  final int id;

  const DetailsScreenTopPicks({Key key, this.id}) : super(key: key);

  @override
  _DetailsScreen1State createState() => _DetailsScreen1State();
}

class _DetailsScreen1State extends State<DetailsScreenTopPicks> {
  DatabaseHelper helper = DatabaseHelper();


  Future<bool> onLikeButtonTapped(bool isLiked) async{
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

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
    Note f = new Note(

      productsList[widget.id].Product,
      productsList[widget.id].ProductLink,
      productsList[widget.id].ImageLink,
      true.toString()

    );
    if(!isLiked) {
      favList.add(d);
      await helper.insertNote(f);

      final prefs = await SharedPreferences.getInstance();
      //final myStringList = prefs.getStringList('my_string_list_key') ?? [];

      prefs.setString('favList', favList.toString());

      print("fav list: "+prefs.getString('favList') ?? []);
    }else{
      favList.remove(d);
      await helper.deleteNote(f.id);

    }


    return !isLiked;
  }

  Future <String> getdata() async {
    print("productsList-"+productsList[widget.id].SubCategory);
    //db = FirebaseDatabase.instance.reference().child("zoom_users");
/*    var db = await FirebaseDatabase.instance.reference();
    await db.once().then((DataSnapshot snapshot) {
      var result = snapshot.value as Iterable;
      Sub1.clear();
      for(int i=0; i<productsList.length; i++){
        if(productsList[i].SubCategory == productsList[widget.id].SubCategory){
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
          Sub1.add(d);
        }
      }
      print("Sub1=" + Sub1.length.toString());
    });*/
  }
  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    return new FutureBuilder(
        future: getdata(),
        initialData: "Loading text..",
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              //child:  SingleChildScrollView(

              child:Column(
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
                                        MaterialPageRoute(builder: (context) => favourite()),
                                      )),
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
                                "${Sub1[widget.id].ImageLink}",
                                width: MediaQuery.of(context).size.width * .7,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

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
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child:Text(
                                      "${Sub1[widget.id].Product}",
                                      style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold),

                                    )  ,
                                  ),
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
                                "Quantity: ${Sub1[widget.id].Quantity}",
                                style:TextStyle(fontSize: 18),
                              ),
                              Text(
                                "Approximate price: ${Sub1[widget.id].ApproxCost}",
                                style:TextStyle(fontSize: 18),
                              ),
                              Text(
                                "Description: ",
                                style:TextStyle(fontSize: 18),
                              ),
                              Text(
                                "${Sub1[widget.id].Description}",
                                style:TextStyle(fontSize: 18),

                              ),
                              Text(
                                "Features & Details: ",
                                style:TextStyle(fontSize: 18),

                              ),
                              Text(
                                "${Sub1[widget.id].Features}",
                                style:TextStyle(fontSize: 18),

                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "More products like this:",
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
                                  itemCount: Sub1.length,
                                  itemBuilder: (BuildContext context, int id) =>
                                  new GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          _createRoute1(id));

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
                                                    "${Sub1[id].ImageLink}",
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
                                                  "${Sub1[id].Product}",
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
                            ],
                          ),
                        )
                    ),
                  ),
                  //),

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
            ),
          );
        });
    //);
  }
}

class MyFloatingActionButton extends StatelessWidget {

  final int id;

  const MyFloatingActionButton({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        backgroundColor: Colors.orangeAccent,

        onPressed: () =>_launchURL(Sub1[id].ProductLink),
        label: new Text('Buy Now', style:TextStyle(fontSize: 20,/*fontWeight: FontWeight.bold*/)));
  }
}

Route _createRoute1(id) {
  print("called route");
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => DetailsScreenTopPicks(id: id),
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

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

