import 'package:firebase_database/firebase_database.dart';

import 'global.dart';

GetAllData(){
  allProductList();
}

Future<void> allProductList() async {
  var db = FirebaseDatabase.instance.reference();
  await db.once().then((DataSnapshot snapshot){
    var result = snapshot.value as Iterable;
    productsList.clear();
    for(var item in result) {
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
    }
  });
  //allcategoryList();

}

Future<void> allcategoryList () async {
var db = FirebaseDatabase.instance.reference();
await db.once().then((DataSnapshot snapshot){
  var result = snapshot.value as Iterable;
  Category1.clear();
    for(var item in result) {
    category d = new category(
    item['Category'],
    );
    Category1.add(d);
    }
  print("Category : "+ Category1.length.toString());
  uniqifyList();
});
}

List<String>Category2=[];
void uniqifyList() {
  for (int i = 0; i < Category1.length; i++) {
    String o = Category1[i].Category;
    //Subcat2.add(o);

    if(Category2.contains(o)){
    }else{
      Category2.add(o);
    }
  }
  print("Category2 : "+ Category2.length.toString());
}