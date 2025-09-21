import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'screens/home/home_screen.dart';
import 'screens/orderDetails/order_details_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/search/search_screen.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({
    super.key,
  });

  @override
  _EntryPointState createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  // Bydefault first one is selected
  int _selectedIndex = 0;

  // List of nav items
  final List<Map<String, dynamic>> _navitems = [
    {"icon": Icons.home, "title": "الرئيسية"},
    {"icon": Icons.search, "title": "البحث"},
    {"icon": Icons.shopping_cart, "title": "الطلبات"},
    {"icon": Icons.person, "title": "الملف الشخصي"},
  ];

// Screens
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const OrderDetailsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    /// If you set your home screen as first screen make sure call [SizeConfig().init(context)]

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CupertinoTabBar(
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        currentIndex: _selectedIndex,
        activeColor: primaryColor,
        inactiveColor: bodyTextColor,
        items: List.generate(
          _navitems.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(
              _navitems[index]["icon"],
              size: 30,
              color: index == _selectedIndex ? primaryColor : bodyTextColor,
            ),
            label: _navitems[index]["title"],
          ),
        ),
      ),
    );
  }
}
