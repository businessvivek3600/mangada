
import 'package:flutter/material.dart';
import 'package:madhang/core/constants/colors..dart';
import 'package:madhang/presentation/discover/view/discover_screen.dart';
import 'package:madhang/presentation/home/view/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    MyHomePage(),
   DiscoverScreen(),
    Center(child: Text("Cart Page")),
    Center(child: Text("Orders Page")),
    Center(child: Text("Profile Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: AppColors.primary900,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Discover"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "My Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
