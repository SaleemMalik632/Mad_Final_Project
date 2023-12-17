// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/Vocher.dart';
import '../screens/Shoes.dart';
import '../screens/Clothing.dart';
import '../screens/Mobbile.dart';
import '../screens/Beauty.dart';

class PopularMenu extends StatelessWidget {
  double width = 55.0, height = 55.0;
  double customFontSize = 13;
  String defaultFontFamily = 'Roboto-Light.ttf';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Beauty(),
                      ),
                    );
                  },
                  shape: CircleBorder(),
                  child: Icon(
                    FontAwesomeIcons.female,
                    color: Color(0xFFAB436B),
                  ),
                ),
              ),
              Text(
                "Women Fashion",
                style: TextStyle(
                    color: Color(0xFF969696),
                    fontFamily: 'Roboto-Light.ttf',
                    fontSize: customFontSize),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Mobile(),
                      ),
                    );
                  },
                  shape: CircleBorder(),
                  child: Icon(
                    FontAwesomeIcons.mobile,
                    color: Color(0xFFC1A17C),
                  ),
                ),
              ),
              Text(
                "Mobiles",
                style: TextStyle(
                    color: Color(0xFF969696),
                    fontFamily: defaultFontFamily,
                    fontSize: customFontSize),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClothingProduct(),
                      ),
                    );
                  },
                  shape: CircleBorder(),
                  child: Icon(
                    FontAwesomeIcons.tshirt,
                    color: Color(0xFF5EB699),
                  ),
                ),
              ),
              Text(
                "Clothing",
                style: TextStyle(
                    color: Color(0xFF969696),
                    fontFamily: defaultFontFamily,
                    fontSize: customFontSize),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShoesProducts(),
                      ),
                    );
                  },
                  shape: CircleBorder(),
                  child: Icon(
                    FontAwesomeIcons.shoppingBag,
                    color: Color(0xFF4D9DA7),
                  ),
                ),
              ),
              Text(
                "Shoe & Bag",
                style: TextStyle(
                    color: Color(0xFF969696),
                    fontFamily: defaultFontFamily,
                    fontSize: customFontSize),
              ),
            ],
          )
        ],
      ),
    );
  }
}
