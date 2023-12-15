// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import '../screens/HomeScreen.dart';

class VoucherProvide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EmptyVoucherProvide();
  }
}

class EmptyVoucherProvide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        title: Text('Voucher'),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Image.network(
                    "https://w7.pngwing.com/pngs/754/920/png-transparent-broken-link-404-link-rot-page-not-found-broken-link-icon-404-icon-page-not-found-icon-weak-link-weakest-link-link.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: Container(
                  color: Color(0xFFFFFFFF),
                ),
              ),
              Text(
                "You haven't have any voucher yet",
                style: TextStyle(
                  color: Color(0xFF67778E),
                  fontFamily: 'Roboto-Light.ttf',
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
                child: Container(
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
