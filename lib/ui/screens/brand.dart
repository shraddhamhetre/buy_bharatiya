import 'package:buybharatiya/ui/screens/product.dart';
import 'package:buybharatiya/ui/screens/subCategoryContainer.dart';
import 'package:buybharatiya/ui/widgets/productcontainer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:queries/collections.dart';


import '../../global.dart';


class BrandList extends StatefulWidget {
  @override
  _categoryListState createState() => _categoryListState();
}

class _categoryListState extends State<BrandList> {

/*  List<String> brandlist = [
    'Aashirvaad',
    'Alembic Pharmaceuticals Ltd',
    'Alkem Laboratories',
    'Amco Batteries',
    'Amrapali Jewels',
    'Amrutanjan Healthcare',
    'Amul',
    'Apollo Tyres',
    'Arise India',
    'Asian Paints',
    'Babool',
    'Bajaj',
    'Bajaj Almond',
    'Biotique',
    'Blue Star',
    'Carbon',
    'Celkon',
    'Chandrika',
    'Charmis',
    'Chik',
    'Cinthol',
    'Crompton Greaves',
    'Dabur',
    'Dermafique',
    'Emami',
    'Engage',
    'Esenza Di Wills',
    'Exide',
    'Exo',
    'Fastrack',
    'Fena',
    'Fiama Di Wills',
    'Forest Essentials',
    'Gini and Jony',
    'Globus',
    'Godrej',
    'Gokul Sandal',
    'Havels',
    'Henko',
    'Himalaya',
    'iBall',
    'Ifb',
    'Inalsa',
    'Jaipan',
    'John Players',
    'Juicy Chemistry',
    'Karthika',
    'Khadims',
    'Khaitan',
    'Lakhani',
    'Lancer',
    'Lava',
    'Liberty',
    'Luminous',
    'Maharaja',
    'Mama Earth',
    'Margo',
    'Maxima',
    'Medimix',
    'Meera',
    'Metro',
    'Micromax',
    'Mr.White',
    'Mysore Sandal',
    'Navratna',
    'Neemli Naturals',
    'Nimyle',
    'NIP',
    'Nirma',
    'Nyle',
    'Onida',
    'Orient Electric',
    'Orpat',
    'Parachute',
    'Paragon',
    'Park Avenue',
    'Patanjali',
    'Peter England',
    'Polar',
    'Ponvandu',
    'Prestige',
    'Pril',
    'Provogue',
    'Redtape',
    'Relaxo',
    'Rupani',
    'Sanifresh',
    'Santoor',
    'Savlon',
    'Shower to Shower',
    'Simmtronic',
    'Sonata',
    'Soultree',
    'Spice',
    'Spykar',
    'Surya Lightings',
    'Titan',
    'Ujala',
    'Usha',
    'Vicco',
    'Videocon',
    'Vip',
    'Vivel',
    'Voll Sante',
    'Voltas',
    'Wildcraft',
    'Wills Lifestyle',
    'Wipro',
    'Xolo',
  ];*/


  Future <String> getdata() async {
    print("called");
    //db = FirebaseDatabase.instance.reference().child("zoom_users");
    var db = await FirebaseDatabase.instance.reference();
    await db.once().then((DataSnapshot snapshot) {
      var result = snapshot.value as Iterable;
      brandList.clear();
      for (var item in result) {
        //print("=="+item["Brand"].toString());
        brands d = new brands(
          item['Brand']
        );
        brandList.add(d);
      }
      print("count" + brandList.length.toString());
      uniqifyList();

    });
  }
  List<String> brandList2=[];
  void uniqifyList() {
    for (int i = 0; i < brandList.length; i++) {
      String o = brandList[i].Brand;
      //Subcat2.add(o);

      if(brandList2.contains(o)){
      }else{
        brandList2.add(o);
      }
    }
    print("count2-"+ brandList2.length.toString());
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Brands';
    return FutureBuilder(
        future: getdata(),
    initialData: "Loading text..",
    builder: (BuildContext context, AsyncSnapshot<String> text) {

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.black,

        ),
        body: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: brandList2.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            //final item = brandlist[index];

            return GestureDetector(
                onTap: (){
                  Navigator.of(context).push(_createRoute(brandList2[index]));
                },
                child: Container(
                  height: 50,
                  child: Card(
                      child: Center(
                        child: ListTile(
                          contentPadding: new EdgeInsets.only(bottom: 15),
                          title: Text(brandList2[index].toString()),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      )

                  ),
                ) /*ListTile(
                  //leading: new ImageIcon( new AssetImage(brandList[index])),
                  title: Text(brandlist[index].toString()),
                  trailing: Icon(Icons.keyboard_arrow_right),

                )*/);
          },
        ),
      ),
    );});
  }
}

Route _createRoute(title) {
  print("called route"+title);
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => product1(title: title),
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


class product1 extends StatefulWidget {
  final String title;

  const product1({Key key, this.title}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return CadburyState();
  }
}

class CadburyState extends State<product1> {


  Future <String> getdata() async {
    print("category called"+widget.title);
    categoryProductList.clear();
    for(int i=0; i<productsList.length; i++){
      print("productsList[i].Subsubcategory:"+productsList[i].Subsubcategory);
      if ((productsList[i].Category == widget.title || productsList[i].Brand == widget.title || productsList[i].SubCategory == widget.title || productsList[i].Subsubcategory == widget.title)) {
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
    print("brandProductList:"+ categoryProductList.length.toString());
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

                        GridView.builder(
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
                        )

                      ])
              ));
        });
  }
}