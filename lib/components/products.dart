import 'package:flutter/material.dart';
import 'package:booking_app/pages/productDetails.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var productList = [
    {
      "name": "Blazer",
      "picture": "images/products/blazer2.jpeg",
      "oldPrice": 120,
      "price": 85,
    },
    {
      "name": "Red Dress",
      "picture": "images/products/dress2.jpeg",
      "oldPrice": 100,
      "price": 50,
    },
    {
      "name": "Hills",
      "picture": "images/products/hills2.jpeg",
      "oldPrice": 110,
      "price": 95,
    },
    {
      "name": "Pants",
      "picture": "images/products/pants1.jpg",
      "oldPrice": 150,
      "price": 120,
    },
    {
      "name": "Shoe",
      "picture": "images/products/shoe1.jpg",
      "oldPrice": 200,
      "price": 130,
    },
    {
      "name": "Skeater",
      "picture": "images/products/skt2.jpeg",
      "oldPrice": 150,
      "price": 100,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: productList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return SingleProduct(
            prodName: productList[index]['name'],
            prodPicture: productList[index]['picture'],
            prodOldPrice: productList[index]['oldPrice'],
            prodPrice: productList[index]['price'],
          );
        });
  }
}

class SingleProduct extends StatelessWidget {
  final String prodName;
  final String prodPicture;
  final int prodOldPrice;
  final int prodPrice;

  SingleProduct(
      {this.prodName, this.prodPicture, this.prodOldPrice, this.prodPrice});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Hero(
      tag: prodName,
      child: Material(
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetails(
                productDetailName: prodName,
                productDetailPicture: prodPicture,
                productDetailOldPrice: prodOldPrice,
                productDetailPrice: prodPrice,
              ),
            ),
          ),
          child: GridTile(
            footer: Container(
              color: Colors.white70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      prodName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ),
                  Text(
                    '\$$prodPrice',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            child: Image.asset(
              prodPicture,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ));
  }
}

//ListTile(
//leading: Text(
//prodName,
//style: TextStyle(fontWeight: FontWeight.bold),
//),
//title: Text(
//'\$$prodPrice',
//style: TextStyle(
//color: Colors.red, fontWeight: FontWeight.w800),
//),
//subtitle: Text(
//'\$$prodOldPrice',
//style: TextStyle(
//color: Colors.black54,
//fontWeight: FontWeight.w800,
//decoration: TextDecoration.lineThrough),
//),
//),
