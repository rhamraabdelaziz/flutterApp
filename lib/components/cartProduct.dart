import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var productOnTheCart = [
    {
      "name": "Blazer",
      "picture": "images/products/blazer2.jpeg",
      "price": 85,
      "size": "M",
      "color": "Black",
      "quantity": 1,
    },
    {
      "name": "Hills",
      "picture": "images/products/hills2.jpeg",
      "price": 95,
      "size": "7",
      "color": "red",
      "quantity": 1,
    },
    {
      "name": "Skeater",
      "picture": "images/products/skt2.jpeg",
      "price": 100,
      "size": "S",
      "color": "Pink",
      "quantity": 1,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: productOnTheCart.length,
        itemBuilder: (context, index) {
          return SingleCartProduct(
            cartProdName: productOnTheCart[index]["name"],
            cartProdColor: productOnTheCart[index]["color"],
            cartProdQuantity: productOnTheCart[index]["quantity"],
            cartProdSize: productOnTheCart[index]["size"],
            cartProdPrice: productOnTheCart[index]["price"],
            cartProdPicture: productOnTheCart[index]["picture"],
          );
        });
  }
}

class SingleCartProduct extends StatelessWidget {
  final String cartProdName;
  final String cartProdPicture;
  final int cartProdPrice;
  final String cartProdSize;
  final String cartProdColor;
  final int cartProdQuantity;

  SingleCartProduct(
      {this.cartProdName,
      this.cartProdPicture,
      this.cartProdPrice,
      this.cartProdSize,
      this.cartProdColor,
      this.cartProdQuantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
//        ===============Leading section==============
        leading: Image.asset(
          cartProdPicture,
          width: 80.0,
          height: 60.0,
        ),
        title: Text(cartProdName),
        subtitle: Column(
          children: <Widget>[
//            ROW INSIDE THE COLUMN
            Row(
              children: <Widget>[
//          ==========    This section is for sizeof the product ==============
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Size"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    cartProdSize,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
//          =========   This section is for the color of the product ===========

                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                  child: Text("Color"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child:
                      Text(cartProdColor, style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                '\$$cartProdPrice',
                style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
          ],
        ),

        /* trailing: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_drop_up),
              onPressed: () {},
            ),
            Text('$cartProdQuantity'),
            IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: () {},
            ),
          ],
        ),*/
      ),
    );
  }
}
