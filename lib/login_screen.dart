// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_setup/chat_screen.dart';
import 'package:firebase_setup/constants.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}



class LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String email = '';
  String password = '';
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String errorText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Center(
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black54,
                  ),
                  child: Text(
                    ("Login Form"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Email '),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 18.0,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                child: const Text('Log in'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      showSpinner = true;
                    });
                    // Login to existing account
                    try {
                      await _auth
                          .signInWithEmailAndPassword(
                              email: email, password: password)
                          .then((value) {
                        setState(() {
                          showSpinner = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LandingDashboard(),
                          ),
                        );
                      });
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                        errorText = e.toString();
                      });
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                              "Please check your email and password",
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      );
                    }
                  }
                },
              ),
              if (errorText.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorText,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
