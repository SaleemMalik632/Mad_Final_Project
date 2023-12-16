// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_final_fields
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './DataBaseFunctions.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController CatagoeryController = TextEditingController();

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
          'Image':
              'https://images.pexels.com/photos/788946/pexels-photo-788946.jpeg?auto=compress&cs=tinysrgb&w=600',
          'status': true,
          'Catagory': SelectedItem.trim(),
        });
        _Adding_Data_Using_Sheard_Prefrenes();
        _Adding_Data_Using_Sqlite();
        _nameController.clear();
        _priceController.clear();
        _descriptionController.clear();
        _image = null;
        showAboutDialog(
          context: context,
          applicationName: 'Product Added',
          applicationVersion: '1.0.0',
          applicationIcon: Icon(Icons.add),
          children: [
            Text('Product Added Successfully'),
          ],
        );
      } catch (e) {
        print('Error adding product: $e');
      }
    }
  }

  Future<void> _Adding_Data_Using_Sqlite() async {
    // Create a Model instance with the data you want to save
    Model newProduct = Model(
      ProdectName: _nameController.text,
      Price: _priceController.text,
      Description: _descriptionController.text,
      Image:
          'https://media.istockphoto.com/id/1350560575/photo/pair-of-blue-running-sneakers-on-white-background-isolated.jpg?s=612x612&w=0&k=20&c=A3w_a9q3Gz-tWkQL6K00xu7UHdN5LLZefzPDp-wNkSU=',
    );
// Create a DbManager instance
    DbManager dbManager = DbManager();
    int? result = await dbManager.insertData(newProduct);
    if (result != null && result > 0) {
      _nameController.clear();
      _priceController.clear();
      _descriptionController.clear();
      _image = null;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product added successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add product'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _Adding_Data_Using_Sheard_Prefrenes() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        if (UploadUrl.isNotEmpty) {
          print('Uploading file: ${UploadUrl}');
        }
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('ProductName', _nameController.text);
        await prefs.setString('Price', _priceController.text);
        await prefs.setString('Description', _descriptionController.text);
        await prefs.setString('Image',
            'https://media.istockphoto.com/id/1350560575/photo/pair-of-blue-running-sneakers-on-white-background-isolated.jpg?s=612x612&w=0&k=20&c=A3w_a9q3Gz-tWkQL6K00xu7UHdN5LLZefzPDp-wNkSU=');
        _nameController.clear();
        _priceController.clear();
        _descriptionController.clear();
        _image = null;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
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
              SizedBox(
                height: 10,
              ),
              DropdownMenuExample(),
              SizedBox(
                height: 10,
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
              SizedBox(height: 20),
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

const List<String> list = <String>[
  ' Select Catagory',
  ' Clothing',
  ' Shoes',
  ' Mobbile',
  ' Beauty',
];
var SelectedItem = '';

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});
  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          SelectedItem = dropdownValue!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
      width: 350,
    );
  }
}
