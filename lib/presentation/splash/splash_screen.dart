import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/colors..dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // After 3 sec → go to Home/NextScreen
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed('/onboarding');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// Center Logo Image
            Center(
              child: Image.asset(
                "assets/images/sample-logo.png",
                width: 180,
                fit: BoxFit.contain,
              ),
            ),

            /// Bottom Progress Bar
            Positioned(
              bottom: 40,
              left: 30,
              right: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 5,
                  color: AppColors.gray200, // background track
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return FractionallySizedBox(
                        widthFactor: _animation.value,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          color: AppColors.primary900, // progress color
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
