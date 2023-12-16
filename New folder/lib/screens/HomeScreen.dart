// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../common_widget/TopPromoSlider.dart';
import '../common_widget/PopularMenu.dart';
import './AdminDashboard.dart';
import './AddProdect.dart';
import './ShoppingCartScreen.dart';
import './WishListScreen.dart';
import './ViewProdect.dart';
import '../components/AppSignIn.dart';

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

class HomeScreen extends StatefulWidget {
  @override
  _BrandHomePageState createState() => _BrandHomePageState();
}

class _BrandHomePageState extends State<HomeScreen> {
  List<dynamic> products = [];
  TextEditingController searchController = TextEditingController();
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
      drawer: MYDraw(),
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              showCursor: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFF666666),
                  size: 17,
                ),
                fillColor: Color(0xFFF2F3F5),
                hintStyle: TextStyle(
                    color: Color(0xFF666666),
                    fontFamily: 'Roboto-Light.ttf',
                    fontSize: 14),
                hintText: "What would you like to buy?",
              ),
            ),
          ),
          // images slider
          TopPromoSlider(),
          PopularMenu(),
          Expanded(
            child: GridView.builder(
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
          ),
        ],
      ),
    );
  }
}

class MYDraw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                ),
                SizedBox(height: 8),
                Text(
                  'Admin Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminDashboard(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Product'),
            onTap: () {
              try {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProductScreen(),
                  ),
                );
              } catch (e) {
                print("Navigation error: $e");
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('View Products'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewProduct(),
                ),
              );
            },
          ),
          // edit Prodct
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit Product'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewProduct(),
                ),
              );
            },
          ),
          // delete product
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete Product'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewProduct(),
                ),
              );
            },
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppSignIn(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
