
import 'package:buybharatiya/ui/screens/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final List<String> imgList = ['assets/categoriesicon/bb2ndcover.jpg', 'assets/categoriesicon/bb4.jpg','assets/categoriesicon/bb6.jpg'];

final List<String> imgListAdv = ['assets/categoriesicon/bb3.jpg', 'assets/categoriesicon/bb7.jpg'];

class CompilcatedImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    /*return Scaffold(
      appBar: AppBar(title: Text('Complicated image slider demo')),
      body: */return Container(

          child: Column(children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                viewportFraction: 1,
                enlargeCenterPage: false,
                disableCenter: true,

              ),
              items:  imageSliders
            ),
          ],)
      );
    //);
  }
}
final List<Widget> imageSliders = imgList.map((item) => Container(
  child: Container(

    margin: EdgeInsets.all(0.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        child: Stack(
          children: <Widget>[
            Image.asset(item, fit: BoxFit.fitWidth, width: 2000.0),
          ],
        )
    ),
  ),
)).toList();

class forAdv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    /*return Scaffold(
      appBar: AppBar(title: Text('Complicated image slider demo')),
      body: */return Container(

        child: Column(children: <Widget>[
          GestureDetector(
            onTap: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => product(title: "Grocery")));
            },
            child:CarouselSlider(

              options: CarouselOptions(
                autoPlay: true,
                //aspectRatio: 2.0,
                viewportFraction: 1,
                enlargeCenterPage: false,
                disableCenter: true,
              ),
              items:  imageSliders1

          ),


          )

        ],)
    );
    //);
  }
}
final List<Widget> imageSliders1 = imgListAdv.map((item1) => Container(
  child: Container(

    margin: EdgeInsets.all(0.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: Image.asset(item1, fit: BoxFit.fitWidth, width: 2000.0),
            )
          ],
        )
    ),
  ),
)).toList();

Route _createRoute(title) {
  print("called route"+title);
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => product(title: title),
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