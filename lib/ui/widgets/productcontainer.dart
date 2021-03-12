import 'package:buybharatiya/ui/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../../global.dart';
import '../database.dart';
import 'Slide_Image.dart';

class ProductContainer extends StatefulWidget {
  final int id;
  final List<products> list;
  const ProductContainer({Key key, this.id, this.list}) : super(key: key);

  @override
  _ProductContainerState createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  DatabaseHelper helper = DatabaseHelper();
  Fav note;
  Future<bool> onLikeButtonTapped(bool isLiked) async{

    print("itm---: "+widget.list[widget.id].Product);

    products d = new products(
      widget.list[widget.id].Brand,
      widget.list[widget.id].Category,
      widget.list[widget.id].ApproxCost,
      widget.list[widget.id].Description,
      widget.list[widget.id].Features,
      widget.list[widget.id].ImageLink,
      widget.list[widget.id].ProductLink,
      widget.list[widget.id].Nationality,
      widget.list[widget.id].Product,
      widget.list[widget.id].Quantity,
      widget.list[widget.id].SubCategory,
      widget.list[widget.id].Subsubcategory,

    );
    Note f = new Note(

      widget.list[widget.id].Product,
      widget.list[widget.id].ProductLink,
      widget.list[widget.id].ImageLink,
      true.toString()

    );


    if(!isLiked) {
        favList.add(d);
        await helper.insertNote(f);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('favList', favList.toString());
      print("fav list: "+prefs.getString('favList') ?? []);
    }else{
      favList.remove(d);
      await helper.deleteNote(f.id);

    }
    updateListView();
    return !isLiked;
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () /*=> Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailsScreen1(id: id)),
      )*/{
        Navigator.of(context).push(
            _createRoute(widget.id, widget.list));

      },
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:Text(widget.list[widget.id].ApproxCost, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),

              ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:LikeButton(
                    onTap: onLikeButtonTapped,
                    likeBuilder: (bool isLiked) {
                      return Icon(isLiked ? Icons.bookmark : Icons.bookmark_border,
                        color: isLiked ? Colors.orangeAccent : Colors.black,
                        size: 40,
                      );
                    },
                  ),

                ),
            ],),

            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: '${widget.id}',
                  child: Image.network(
                    "${widget.list[widget.id].ImageLink}",
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
                "${widget.list[widget.id].Product}",
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)/*Theme.of(context)
                    .textTheme
                    .subtitle
                    .copyWith(color: Colors.black)*/,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Route _createRoute(id, list) {
  print("called route"+ list.toString());
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => DetailsScreen1(id: id, list: list,),
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
