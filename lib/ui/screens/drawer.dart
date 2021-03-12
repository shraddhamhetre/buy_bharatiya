

import 'package:buybharatiya/ui/screens/fav_Screen.dart';
import 'package:buybharatiya/ui/screens/privacyPolicy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'TermsandCondition.dart';
import 'brand.dart';
import 'categoryList.dart';
import 'favourite.dart';
import 'home.dart';

class navigationDrawer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Drawer(
        //child: Flexible(
          child: Container(
            padding: EdgeInsets.all(5),
            height: 40,
            width: double.infinity,
          child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
            height: 80.0,
            child: DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/img/menucover (1).jpg'),
                    fit: BoxFit.fill,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(0.0)
            ),
          ),
          InkWell(
            child:Container(
              height: 50,

              child: Card(

                child: Center(
                  child: ListTile(
                     contentPadding: new EdgeInsets.only(bottom: 15),
                    onTap: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                  },
                    title: Text("Home"),
                    leading: Image.asset("assets/drawermenu/Home.png"),
                  ),
                )

              ),
          )
    ),
            InkWell(
                child:Container(
                  height: 50,

                  child: Card(

                      child: Center(
                        child: ListTile(
                          contentPadding: new EdgeInsets.only(bottom: 15),
                          onTap: (){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => categoryList()),
                        );
                        },
                          title: Text("Category"),
                          leading: Image.asset("assets/drawermenu/Categories.png"),
                        ),
                      )

                  ),
                )
            ),
            InkWell(
                child:Container(
                  height: 50,

                  child: Card(

                      child: Center(
                        child: ListTile(
                          contentPadding: new EdgeInsets.only(bottom: 15),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => fav_Screen()),
                            );
                          },
                          title: Text("Saved Products"),
                          leading: Image.asset("assets/categoriesicon/saved.png"),
                        ),
                      )

                  ),
                )
            ),
            InkWell(
                child:Container(
                  height: 50,
                  child: Card(
                      child: Center(
                        child: ListTile(
                          contentPadding: new EdgeInsets.only(bottom: 15),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BrandList()),
                            );
                          },
                          title: Text("List of Brands"),
                          leading: Image.asset("assets/drawermenu/List Of Brands.png"),
                        ),
                      )
                  ),
                )
            ),
            InkWell(
                child:Container(
                  height: 50,
                  child: Card(
                      child: Center(
                        child: ListTile(
                          contentPadding: new EdgeInsets.only(bottom: 15),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Terms1()),
                            );
                          },
                          title: Text("Terms and Conditions"),
                          leading: Image.asset("assets/drawermenu/Terms and Conditions.png"),
                        ),
                      )

                  ),
                )

            ),
            InkWell(
                child:Container(
                  height: 50,

                  child: Card(

                      child: Center(
                        child: ListTile(
                          contentPadding: new EdgeInsets.only(bottom: 15),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Privacy()),
                            );
                          },
                          title: Text("Privacy Policy"),
                          leading: Image.asset("assets/drawermenu/Privacy Policy.png"),
                        ),
                      )

                  ),
                )

            ),
            InkWell(
                child:Container(
                  height: 50,
                  child: Card(
                      child: Center(
                        child: ListTile(
                          contentPadding: new EdgeInsets.only(bottom: 15),
                          onTap: ()=> _launchURLbecomeseller(),
                          title: Text("Become A Seller"),
                          leading: Image.asset("assets/drawermenu/Become A Seller.png"),
                        ),
                      )
                  ),
                )
            ),
            InkWell(
                child:Container(
                  height: 50,
                  child: Card(
                      child: Center(
                        child: ListTile(
                          contentPadding: new EdgeInsets.only(bottom: 15),
                          onTap: ()=> _launchURLSupport(),
                          title: Text("Feedback"),
                          leading: Image.asset("assets/drawermenu/Feedback.png"),
                        ),
                      )
                  ),
                )
            ),
            InkWell(
                child:Container(
                  height: 50,
                  child: Card(
                      child: Center(
                        child: ListTile(
                          contentPadding: new EdgeInsets.only(bottom: 15),
                          onTap: ()=> _launchURLReview(),
                          title: Text("Review"),
                          leading: Image.asset("assets/drawermenu/Rate & Review.png"),
                        ),
                      )
                  ),
                )
            ),
            //_createFooterItem(icon: Icons.event, text: '', onTap: () => null),

            //_createFooterItem(icon: Icons.event, text: '', onTap: () => null),
            //_createFooterItem(icon: Icons.event, text: '', onTap: () => null),
            _createFooterItem(icon: Icons.event, text: 'By Dream Planners', onTap: () => null, )

          ],
          ),
          )

      /*
          Flexible(
                child: Card(
                  margin: EdgeInsets.all(5),

                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        createDrawerBodyItem(
                            icon: Icons.list,
                            text: 'List of Brands',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BrandList()),
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                ),
          ),
          Flexible(
                child: Card(
                  margin: EdgeInsets.all(5),

                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        createDrawerBodyItem(
                            icon: Icons.assignment_turned_in,
                            text: 'Terms and Conditions',
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Terms1()),
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                ),
          ),
          Flexible(
                child: Card(
                  margin: EdgeInsets.all(5),

                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        createDrawerBodyItem(
                            icon: Icons.android,
                            text: 'Privacy Policy',
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Privacy()),
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                ),
          ),
          Flexible(
                child: Card(
                  margin: EdgeInsets.all(5),

                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        createDrawerBodyItem(
                            icon: Icons.supervisor_account,
                            text: 'Support',
                            onTap: (){
                              _launchURLSupport();
                            }
                        ),
                      ],
                    ),
                  ),
                ),
          ),
          Flexible(
                child: Card(
                  margin: EdgeInsets.all(5),

                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        createDrawerBodyItem(
                            icon: Icons.person,
                            text: 'Become A Seller',
                            onTap: () {
                              _launchURLbecomeseller();
                            }
                        )
                      ],
                    ),
                  ),
                ),
          ),
          //Divider()
        ],
      ),*/);
  }
}

Widget createDrawerBodyItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}

Widget _createFooterItem({IconData icon, String text, GestureTapCallback onTap}){

  return ListTile(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
    Center(
    child: Container(
        //margin: EdgeInsets.only(top: 120, left: 80),
    child: Column(
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            color: Colors.orangeAccent,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          // textAlign: TextAlign.center,
        ),
      ],
    ),
  ),
  )],
    ),
    onTap: onTap,
  );
}
String Support ="https://forms.gle/yY3AT1HtXrG3UWPLA";
String becomeseller ="https://forms.gle/WRm2XC4diVT8mBUE8";
String review ="https://play.google.com/store/apps/details?id=com.dreamteam.buybharatiya";


_launchURLSupport() async {
  if (await canLaunch(Support)) {
    await launch(Support);
  } else {
    throw 'Could not launch $Support';
  }
}
_launchURLReview() async {
  if (await canLaunch(review)) {
    await launch(review);
  } else {
    throw 'Could not launch $review';
  }
}
Future<dynamic> _launchURLbecomeseller() async {
  if (await canLaunch(becomeseller)) {
    await launch(becomeseller);
  } else {
    throw 'Could not launch $becomeseller';
  }
}