import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TopPromoSlider extends StatelessWidget {
  final List<String> imageUrls = [
    "https://graphicsfamily.com/wp-content/uploads/edd/2022/11/Professional-Advertising-Poster-Design-for-Tea-Product-1536x864.jpg",
    "https://img.pikbest.com/origin/06/06/15/48cpIkbEsT7ym.jpg!w700wp",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: 200.0,
        width: double.infinity,
        child: CarouselSlider(
          items: imageUrls.map((imageUrl) {
            return Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            );
          }).toList(),
          options: CarouselOptions(
            height: 150.0,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            enlargeCenterPage: true,
            // Other options go here
          ),
        ),
      ),
    );
  }
}
