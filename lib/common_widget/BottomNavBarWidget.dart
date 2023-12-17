// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}
class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      navigateToScreens(index);
    });
  }
  void navigateToScreens(int index) {
    // Adjust the navigation logic based on your app structure 
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/wish_list');
        break;
      case 2:
        Navigator.pushNamed(context, '/cart');
        break;
      case 3:
        Navigator.pushNamed(context, '/dashboard');
        break;
      default:
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.heart),
          label: 'Wish List',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.shoppingBag),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.dashcube),
          label: 'Dashboard',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0xFFAA292E),
      onTap: _onItemTapped,
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Home Screen')),
      ),
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          return MaterialPageRoute(builder: (context) => HomeScreen());
        } else if (settings.name == '/wish_list') {
          return MaterialPageRoute(builder: (context) => WishListScreen());
        } else if (settings.name == '/cart') {
          return MaterialPageRoute(builder: (context) => CartScreen());
        } else if (settings.name == '/dashboard') {
          return MaterialPageRoute(builder: (context) => DashboardScreen());
        }
        return null;
      },
    ),
  );
}


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(child: Text('Home Screen')),
    );
  }
}
class WishListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wish List')),
      body: Center(child: Text('Wish List Screen')),
    );
  }
}
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Center(child: Text('Cart Screen')),
    );
  }
}
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(child: Text('Dashboard Screen')),
    );
  }
}
