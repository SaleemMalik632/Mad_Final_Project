// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_setup/chat_screen.dart';
import 'package:firebase_setup/constants.dart';

class ProductDetailPage extends StatefulWidget {
  final dynamic product;
  const ProductDetailPage({Key? key, required this.product}) : super(key: key);
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product['title']),
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.network(widget.product['thumbnail']),
          ),
          Text(
            widget.product['title'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(widget.product['description']),
          Text(
            '\$${widget.product['price']}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  CollectionReference product =
                      FirebaseFirestore.instance.collection('product');
                  product.add({
                    'ProdectName': widget.product['title'],
                    'Description': widget.product['description'],
                    'Price': widget.product['price'],
                    'Image': widget.product['thumbnail'],
                  });
                  showAboutDialog(
                    context: context,
                    applicationName: 'Product Added',
                    applicationVersion: '1.0.0',
                    applicationIcon: Icon(Icons.add),
                    children: [
                      Text('Product Added Successfully'),
                    ],
                  );
                },
                child: Text('Add'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Delete product logic here
                },
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BrandHomePage1 extends StatefulWidget {
  @override
  _BrandHomePageState createState() => _BrandHomePageState();
}

class _BrandHomePageState extends State<BrandHomePage1> {
  List<dynamic> products = [];
  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    final data = json.decode(response.body);
    setState(() {
      products = data['products'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brand Home Page'),
      ),
      body: GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                  product: products[index],
                ),
              ),
            );
          },
          child: Card(
            child: Column(
              children: [
                Expanded(
                  child: Image.network(products[index]['thumbnail']),
                ),
                Text(
                  products[index]['title'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(products[index]['description']),
                Text(
                  '\$${products[index]['price']}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
