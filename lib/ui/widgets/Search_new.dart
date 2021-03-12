import 'dart:math';

import 'package:buybharatiya/ui/widgets/search.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:search_widget/search_widget.dart';

import '../../global.dart';


class Post {
  final String product;
  final String dec;

  Post(this.product, this.dec);
}

class search1 extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<search1> {
  final SearchBarController<Post> _searchBarController = SearchBarController();
  bool isReplay = false;
  List<Post> posts = [];

  products _selectedItem;


  Future<List<Post>> _getALlPosts(String text) async {
    var db = await FirebaseDatabase.instance.reference();
    await db.once().then((DataSnapshot snapshot) {
      var result = snapshot.value as Iterable;
      posts.clear();
      for (var item in result) {
        if (item['Nationality'] == "Indian") {
          //print("=="+item["Brand"].toString());
          Post d = new Post(
            item['Category'],
            item['Product'],

          );
          posts.add(d);
          print("===" + item['FeaturesDetails'].toString());
        }
      }

      print("count" + productsList.length.toString());
    });


    await Future.delayed(Duration(seconds: text.length == 4 ? 10 : 1));
    //if (isReplay) return [productsList.];
    if (text.length == 5) throw Error();
    if (text.length == 6) return [];

    /*var random = new Random();
    for (int i = 0; i < 10; i++) {
      posts.add(Post("$text $i", "body random number : ${random.nextInt(100)}"));
    }*/
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchWidget<products>(
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
        ),/*SearchBar<Post>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 10),
          onSearch: _getALlPosts,
          searchBarController: _searchBarController,
          placeHolder: Text("placeholder"),
          //cancellationWidget: Text("Cancel"),
          emptyWidget: Text("empty"),
          indexedScaledTileBuilder: (int index) => ScaledTile.count(1, index.isEven ? 2 : 1),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          onItemFound: (Post post, int index) {

            return Container(
              color: Colors.lightBlue,
              child: ListTile(
                title: Text(post.product),
                isThreeLine: true,
                subtitle: Text(post.dec),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail()));
                },
              ),
            );
          },
        ),*/
      ),
    );
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}