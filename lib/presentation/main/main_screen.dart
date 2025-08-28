import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:madhang/core/constants/colors..dart';
import '../cart/view/my_cart_screen.dart';
import '../discover/view/discover_screen.dart';
import '../food/view/food_order_screen.dart';
import '../home/view/home_page.dart';
import '../profile/view/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _controller = NotchBottomBarController(index: 0);
  final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _pages = [
    const MyHomePage(),
    const DiscoverScreen(),
    MyCartScreen(),
    const FoodOrderScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: Colors.white,
        showLabel: true,
        notchColor: AppColors.primary900,
        kIconSize: 24.0,
        kBottomRadius: 20.0,
        itemLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.home, color: Colors.grey),
            activeItem: Icon(Icons.home, color: Colors.white),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.explore, color: Colors.grey),
            activeItem: Icon(Icons.explore, color: Colors.white),
            itemLabel: 'Discover',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.shopping_bag, color: Colors.grey),
            activeItem: Icon(Icons.shopping_bag, color: Colors.white),
            itemLabel: 'My Cart',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.restaurant, color: Colors.grey),
            activeItem: Icon(Icons.restaurant, color: Colors.white),
            itemLabel: 'Orders',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.person, color: Colors.grey),
            activeItem: Icon(Icons.person, color: Colors.white),
            itemLabel: 'Profile',
          ),
        ],
      ),
    );
  }
}
