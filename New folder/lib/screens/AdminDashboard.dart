// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../common_widget/PopularMenu.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SalesData> salesData = [
      SalesData(month: 'Jan', amount: 100),
      SalesData(month: 'Feb', amount: 800),
      SalesData(month: 'Mar', amount: 300),
      SalesData(month: 'May', amount: 500),
      SalesData(month: 'June', amount: 1000),
      SalesData(month: 'July', amount: 1200),
      // Add more data as needed
    ];
    List<charts.Series<SalesData, String>> seriesList = [
      charts.Series(
        id: 'Sales',
        data: salesData,
        domainFn: (SalesData sales, _) => sales.month,
        measureFn: (SalesData sales, _) => sales.amount,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        labelAccessorFn: (SalesData sales, _) =>
            '${sales.month}: ${sales.amount}',
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Your existing StatisticCard widgets
                StatisticCard(
                  title: 'Product',
                  value: '100',
                  color: Colors.green,
                  icon: Icons.shopping_cart,
                ),
                StatisticCard(
                  title: 'Users',
                  value: '20',
                  color: Colors.orange,
                  icon: Icons.person,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Your existing Orders widget
                Orders(
                  title: 'Orders',
                  value: '10',
                  color: Colors.green,
                  icon: Icons.local_mall,
                ),
              ],
            ),
          ),
          PopularMenu(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Your existing Orders widget
                Orders(
                  title: 'Category',
                  value: '5',
                  color: Color.fromARGB(221, 90, 130, 4),
                  icon: Icons.local_mall,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 350,
            child: charts.BarChart(
              seriesList,
              animate: true,
              vertical: true,
            ),
          ),
        ],
      ),
    );
  }
}

class SalesData {
  final String month;
  final int amount;

  SalesData({required this.month, required this.amount});
}

class Orders extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const Orders(
      {required this.title,
      required this.value,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      height: 100,
      width: 350,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: 7),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              Text(
                value,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const StatisticCard(
      {required this.title,
      required this.value,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: 7),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              Text(
                value,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
          SizedBox(width: 7),
        ],
      ),
    );
  }
}
