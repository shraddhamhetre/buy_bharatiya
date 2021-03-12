/*
Column(
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
tag: '${widget.id}',
child: Image.network(
"${productsList[widget.id].ImageLink}",
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
"${productsList[widget.id].Product}",
style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold),

)  ,
),
LikeButton(
//size: 2,
circleColor:
CircleColor(start:
Color(0xff00ddff)
Colors.grey, end: Colors.red
Color(0xff0099cc)
),
bubblesColor: BubblesColor(
dotPrimaryColor: Colors.pink
Color(0xff33b5e5)
,
dotSecondaryColor: Colors.red
Color(0xff0099cc)
,
),
onTap: onLikeButtonTapped,
likeBuilder: (bool isLiked) {
return Icon(
Icons.add,
color: isLiked ? Colors.red : Colors.red,
size: 40,
);
},
),
],
),
Text(
"Quantity: ${productsList[widget.id].Quantity}",
style:TextStyle(fontSize: 18),
),
Text(
"Approximate price: ${productsList[widget.id].ApproxCost}",
style:TextStyle(fontSize: 18),
),
Text(
"Description: ",
style: Theme.of(context).textTheme.title,
),
Text(
"${productsList[widget.id].Description}",
),

Text(
"Features & Details: ",
style: Theme.of(context).textTheme.title,
),
Text(
"${productsList[widget.id].Features}",
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
onPressed: () =>_launchURL(productsList[widget.id].ProductLink),
child: const Text('Buy Now', style: TextStyle(fontSize: 20)),
color: Colors.orangeAccent,
textColor: Colors.white,
elevation: 5,
),
),
Container(
height: 200.0,
child: ListView.builder(
scrollDirection: Axis.horizontal,
itemCount: productsList.length,
itemBuilder: (BuildContext context, int id) =>
new GestureDetector(
onTap: () => null,
{
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
width:
MediaQuery.of(context).size.width/3
150,
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
"${productsList[id].ImageLink}",
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
"${productsList[id].Product}",
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

]),
*/
