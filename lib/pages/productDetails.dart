import 'package:flutter/material.dart';
//import 'package:library_app/main.dart';
import 'home.dart';

class ProductDetails extends StatefulWidget {
  final String productDetailName;
  final String productDetailPicture;
  final int productDetailOldPrice;
  final int productDetailPrice;

  ProductDetails(
      {this.productDetailName,
      this.productDetailPicture,
      this.productDetailOldPrice,
      this.productDetailPrice});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.green,
        title: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Center(child: Text('Fashapp'))),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.productDetailPicture),
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    widget.productDetailName,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "\$${widget.productDetailOldPrice}",
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "\$${widget.productDetailPrice}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

//          ============ First Buttons==================

          Row(
            children: <Widget>[
//              ==============Size button
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Size'),
                            content: Text('Choose the size'),
                            actions: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text('close'),
                              ),
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('Size'),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),
                ),
              ),
//              ==============Color button
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Color'),
                            content: Text('Choose the color'),
                            actions: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text('close'),
                              ),
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('Color'),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),
                ),
              ),
//              ==============Qty button
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Quantity'),
                            content: Text('Choose the quantity'),
                            actions: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text('close'),
                              ),
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('Qty'),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

//          ============ Second Buttons=================

          Row(
            children: <Widget>[
//              ==============Buy button
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.red,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: Text("Buy Now"),
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.red,
                  ),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {}),
            ],
          ),
          Divider(),

          ListTile(
            title: Text('Product Details'),
            subtitle:
                Text('Lorem Ipsum is simply dummy text of the printing and '
                    'typesetting industry. Lorem Ipsum has been the industry\'s'
                    'standard dummy text ever since the 1500s, when an unknown'
                    'printer took a galley of type and scrambled it to make'
                    'a type specimen book. It has survived not only five'
                    'centuries, but also the leap into electronic typesetting,'
                    'remaining essentially unchanged. It was popularised in'
                    'the 1960s with the release of Letraset sheets containing'
                    'Lorem Ipsum passages, and more recently with desktop'
                    'publishing software like Aldus PageMaker including'
                    'versions of Lorem Ipsum.It is a long established fact '
                    'that a reader will be distracted by the readable content '
                    'of a page when looking at its layout. The point of using '
                    'Lorem Ipsum is that it has a more-or-less normal '
                    'distribution of letters, as opposed to using '
                    '\'Content here, content here\', making it look like '
                    'readable English. Many desktop publishing packages '
                    'and web page editors now use Lorem Ipsum as their '
                    'default model text,The standard chunk of Lorem Ipsum '
                    'used since the 1500s is reproduced below for those '
                    'interested. Sections 1.10.32 and 1.10.33 from "de '
                    'Finibus Bonorum et Malorum" by Cicero are also '
                    'reproduced in their exact original form, accompanied '
                    'by English versions from the 1914 translation '
                    'by H. Rackham.'),
          ),

          Divider(),

          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  'Product name',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(widget.productDetailName),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  'Product Brand',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('Product X'),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  'Product Condition',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('NEW'),
              )
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Similar products'),
          ),
//          SIMILAR PRODUCT
          Container(
            height: 340.0,
            child: SimilarProducts(),
          ),
        ],
      ),
    );
  }
}

class SimilarProducts extends StatefulWidget {
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
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
          return SimilarSingleProduct(
            prodName: productList[index]['name'],
            prodPicture: productList[index]['picture'],
            prodOldPrice: productList[index]['oldPrice'],
            prodPrice: productList[index]['price'],
          );
        });
  }
}

class SimilarSingleProduct extends StatelessWidget {
  final String prodName;
  final String prodPicture;
  final int prodOldPrice;
  final int prodPrice;

  SimilarSingleProduct(
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
