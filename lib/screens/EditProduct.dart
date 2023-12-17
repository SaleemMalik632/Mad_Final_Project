// edit_product_screen.dart
// ignore_for_file: prefer_const_constructors, prefer_final_fields
import 'package:firebase_setup/screens/ViewProdect.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProductScreen extends StatefulWidget {
  final DocumentSnapshot productSnapshot;

  const EditProductScreen({Key? key, required this.productSnapshot})
      : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController productNameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController imageController;
  String defaultFontFamily = 'Roboto-Light.ttf';
  double defaultFontSize = 14;
  double defaultIconSize = 17;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing data
    productNameController =
        TextEditingController(text: widget.productSnapshot['ProductName']);
    descriptionController =
        TextEditingController(text: widget.productSnapshot['Description']);
    priceController =
        TextEditingController(text: widget.productSnapshot['Price'].toString());
    // imageController =
    //     TextEditingController(text: widget.productSnapshot['Image']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: productNameController,
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
                    Icons.production_quantity_limits,
                    color: Color(0xFF666666),
                    size: defaultIconSize,
                  ),
                  fillColor: Color(0xFFF2F3F5),
                  hintStyle: TextStyle(
                    color: Color(0xFF666666),
                    fontFamily: defaultFontFamily,
                    fontSize: defaultFontSize,
                  ),
                  hintText: "Enter Product Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: priceController,
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
                    Icons.price_change_outlined,
                    color: Color(0xFF666666),
                    size: defaultIconSize,
                  ),
                  fillColor: Color(0xFFF2F3F5),
                  hintStyle: TextStyle(
                    color: Color(0xFF666666),
                    fontFamily: defaultFontFamily,
                    fontSize: defaultFontSize,
                  ),
                  hintText: "Enter Product Price",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product price';
                  }
                  // You can add more specific validation for price if needed
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descriptionController,
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
                    Icons.description,
                    color: Color(0xFF666666),
                    size: defaultIconSize,
                  ),
                  fillColor: Color(0xFFF2F3F5),
                  hintStyle: TextStyle(
                    color: Color(0xFF666666),
                    fontFamily: defaultFontFamily,
                    fontSize: defaultFontSize,
                  ),
                  hintText: "Enter Product Description",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Image.network(
                widget.productSnapshot['Image'],
                height: 200,
                width: 200,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  widget.productSnapshot.reference.update({
                    'ProductName': productNameController.text,
                    'Description': descriptionController.text,
                    'Price': double.parse(priceController.text),
                    // 'Image': imageController.text,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Product updated successfully')),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewProduct(),
                    ),
                  );
                },
                child: Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
