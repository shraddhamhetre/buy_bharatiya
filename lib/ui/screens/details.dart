import 'package:buybharatiya/ui/widgets/productcontainer.dart';
import 'package:flutter/material.dart';
import '../../global.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  final int id;

  const DetailsScreen({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        /*floatingActionButton: FloatingActionButton(onPressed: () =>_launchURL(productsList[id].url),
        child: Text("SHOP"),
        backgroundColor: Colors.green,
        ),*/
        body: Column(
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
                              Icons.shopping_basket,
                            ),
                            onPressed: () =>
                                Navigator.pushNamed(context, 'orderscreen')),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Hero(
                        tag: '$id',
                        child: Image.network(
                          "${productsList[id].ImageLink}",
                          width: MediaQuery.of(context).size.width * .7,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //const SizedBox(height: 30),
            new SizedBox(
            width: 400.0,
            height: 40.0,
            child:  RaisedButton(
              onPressed: () =>_launchURL(productsList[id].ProductLink),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.greenAccent)
              ),
              textColor: Colors.black,
              color: Colors.lightGreen,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                  decoration: const BoxDecoration(
                    /* gradient: LinearGradient(
                colors: Colors.green
                ),*/
                  ),
                  child: const Text('Buy Now', style: TextStyle(fontSize: 15))
              ),

            ),),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
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
                        Text(
                          "${productsList[id].Product}",
                          style: Theme.of(context).textTheme.display1,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Text(
                      "Quantity: ",
                      style: Theme.of(context).textTheme.title,
                    ),

                    Text(
                      "Description: ",
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(
                      "${productsList[id].Description}",
                    ),
                    Text(
                      "You may also like: ",
                      style: TextStyle(fontStyle: FontStyle.normal,fontSize: 20,color: Colors.red),
                    ),
                    GridView.builder(


                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: .7
                      ),
                      itemCount: productsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductContainer(id: index);
                      },
                    )
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(),
                        Text(
                          "${productsList[id].price}",
                          style: Theme.of(context).textTheme.title,
                        ),
                      ],
                    ),*/
                  ],
                ),
                )


              ),
            )


          ],
        ),
      ),
    );
  }
}


/*Container(
width: double.infinity,
child: RaisedButton(
child: Text(
"Shop",
style: Theme.of(context).textTheme.button.apply(
color: Colors.white,
),
),
onPressed:*//* _launchURL(productsList[id].url)*//*null,
color: Colors.green,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(5.0),
),
),
)*/
_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
