import 'package:buybharatiya/ui/screens/test.dart';
import 'package:buybharatiya/ui/widgets/Search_new.dart';
import 'package:buybharatiya/ui/widgets/Slide_Image.dart';
import 'package:buybharatiya/ui/widgets/categorycontainer.dart';
import 'package:buybharatiya/ui/widgets/productcontainer.dart';
import 'package:buybharatiya/ui/widgets/search.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:search_widget/search_widget.dart';
import 'package:sqflite/sqflite.dart';
import '../../global.dart';
import '../database.dart';
import 'AssemInIndia.dart';
import 'GlobalProducts.dart';
import 'drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'favourite.dart';
import 'mainUi.dart';

BuildContext mContext;
final orientation = MediaQuery.of(mContext).orientation;

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  products _selectedItem;
  int pageIndex= 0;
  final favourite _fav= new favourite();
  final Global _global= Global(title: "Others");
  final assembleInIndia _assembleInIndia= assembleInIndia(title: "Assembled in India");
  final mainUi _homeScreen= mainUi();

  Widget _showPage= mainUi();

  Widget _goToPage(int page) {
    print("==="+page.toString());

    switch(page){
      case 0:
        return _homeScreen;
      case 1:
        return _assembleInIndia;
      case 2:
        return _global;
      case 3:
        return _fav;

    }

  }

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
  void initState() {
    super.initState();
    updateListView();
  }

  bool _show = true;

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return new FutureBuilder(
        future: getdata(),
        initialData: "Loading text..",
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return SafeArea(
            child: Scaffold(
              //appBar: buildBar(context),
              backgroundColor: Color(0xfff9f9f9),
              bottomNavigationBar:
              CurvedNavigationBar(
                index: pageIndex,
                height: 60,
                backgroundColor: Colors.white,
                color: /*Color(0xff4776bd)*/Colors.orangeAccent,
                items: <Widget>[
                  Image.asset('assets/categoriesicon/indian.png', fit: BoxFit.contain, height: 40,),
                  Image.asset('assets/categoriesicon/assembledinindia.png', fit: BoxFit.fill, height: 40,),
                  Image.asset('assets/categoriesicon/global.png', fit: BoxFit.contain, height: 40,),
                Image.asset('assets/categoriesicon/saved.png', fit: BoxFit.contain, height: 40,),
                ],
                onTap: (int tappedIndex) {
                  setState(() {
                    _showPage = _goToPage(tappedIndex);
                  });
                },
              ),

              appBar: AppBar(
                centerTitle: true,

                title: new Row
                  (
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                  [
                    Container(//padding: const EdgeInsets.all(10.0),
                        child: new Row(
                          children: <Widget>[
                            Image.asset('assets/img/buybhartiya icon.png',
                              fit: BoxFit.contain, height: 50,),

                             Text('Buy Bharatiya',
                                style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18,
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

                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => search1()),
                      );
                    },
                  ),

                ],
              ),
              drawer: navigationDrawer(),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: _showPage/*Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CompilcatedImageDemo(),
                    *//*ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/img/bbappcover1copy.jpg',
                        width: 500.0,
                        height: 240.0,
                        fit: BoxFit.fill,
                      ),
                    ),*//*
                    SizedBox(
                      height: 15,
                    ),

                    SearchWidget<products>(
                      dataList: productsList,
                      hideSearchBoxWhenItemSelected: false,
                      listContainerHeight: MediaQuery.of(context).size.height / 4,
                      queryBuilder: (query, list) {
                        return list
                            .where((item) => item.Product
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                            .toList();
                      },
                      popupListItemBuilder: (item) {
                        return PopupListItemWidget(item);
                      },
                      selectedItemBuilder: (selectedItem, deleteSelectedItem) {
                        return SelectedItemWidget(selectedItem, deleteSelectedItem);
                      },
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
                    *//*new GestureDetector(
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search",

                        ),
                      ),
                      onTap: () {
                        setState(() {
                          if (this.actionIcon.icon == Icons.search) {
                            this.actionIcon = Icon(
                              Icons.close,
                              color: Colors.orange,
                            );
                            this.appBarTitle = TextField(
                              controller: _searchQuery,
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                              decoration: InputDecoration(
                                  hintText: "Search here..",
                                  hintStyle: TextStyle(color: Colors.white)),
                            );
                            _handleSearchStart();
                          } else {
                            _handleSearchEnd();
                          }
                        });
                      },
                    ),*//*
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 81,
                      child: CategoryContainer(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Products",
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

                    GridView.builder(
                      itemCount: productsList.length,
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

                        return ProductContainer(id: index);
                      },
                    ),
                  ],
                ),*/
              ),
            ),
          );
        });
  }

  Future <String> getdata() async {
    print("called");
    //db = FirebaseDatabase.instance.reference().child("zoom_users");
    var db = await FirebaseDatabase.instance.reference();
    await db.once().then((DataSnapshot snapshot) {
      var result = snapshot.value as Iterable;
      productsList.clear();
      for (var item in result) {
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
          item['Subsubcategory'],
        );
        productsList.add(d);
        //print("===" + item['Product Link'].toString());
      }
      //print("count" + productsList.length.toString());
    });
  }

}




