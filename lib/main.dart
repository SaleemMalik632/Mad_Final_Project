import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_setup/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import './screens/HomeScreen.dart';
import '../components/AppSignIn.dart';
import './screens/AdminDashboard.dart';
import './screens/AddProdect.dart';
import './screens/AdminDashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme:
          ThemeData(primarySwatch: Colors.amber), //primarySwatch: Colors.amber
      debugShowCheckedModeBanner: false,
      home: AppSignIn(),
    );
  } // MaterialApp
}   // MyApp


