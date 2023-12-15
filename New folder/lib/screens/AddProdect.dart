// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, non_constant_identifier_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String defaultFontFamily = 'Roboto-Light.ttf';
  double defaultFontSize = 14;
  double defaultIconSize = 17;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  File? _image = null;
  String ImageUrl = '';
  String UploadUrl = '';

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print(_image!.path);
        ImageUrl = pickedFile.path; // Remove this line
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> UploadImage(File localFile, String imageName) async {
    try {
      print('Uploading file: ${localFile.path}');
      final FirebaseStorageReference =
          FirebaseStorage.instance.ref().child('product/$imageName.jpg');
      print('Storage reference: ${FirebaseStorageReference.fullPath}');
      await FirebaseStorageReference.putFile(localFile);
      final url = await FirebaseStorageReference.getDownloadURL();
      setState(() {
        UploadUrl = url;
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> pickerandupload() async {
    await _pickImage();
    if (_image != null) {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      await UploadImage(_image!, imageName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image first'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _addProduct() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        if (UploadUrl.isNotEmpty) {
          print('Uploading file: ${UploadUrl}');
        }
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        await firestore.collection('product').add({
          'ProductName': _nameController.text,
          'Price': _priceController.text,
          'Description': _descriptionController.text,
          'Image': UploadUrl,
        });
        _nameController.clear();
        _priceController.clear();
        _descriptionController.clear();
        _image = null;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // ignore: prefer_interpolation_to_compose_strings
            content: Text('Product added successfully'),
            duration: Duration(seconds: 10),
          ),
        );
      } catch (e) {
        print('Error adding product: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
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
                controller: _priceController,
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
                controller: _descriptionController,
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
              ElevatedButton(
                onPressed: () {
                  pickerandupload();
                },
                child: Text('Pick Image and upload'),
              ),
              SizedBox(height: 20),
              Container(
                width: 100, // or any size you want
                height: 100, // or any size you want
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: _image != null
                    ? Image.file(_image!, fit: BoxFit.cover)
                    : Icon(Icons.image, size: 50, color: Colors.grey),
              ),
              ElevatedButton(
                onPressed: _addProduct,
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
