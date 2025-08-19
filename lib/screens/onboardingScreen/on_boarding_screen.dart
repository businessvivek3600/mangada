import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madhang/screens/auth/login_screen.dart';
import '../../widgets/custom_button.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<OnboardingPageData> pages = [
    OnboardingPageData(
      image:
      "assets/images/intro-1-removebg-preview.png", // sample food image
      title: "Welcome to Madhang App!",
      description: "Bring the taste of Indonesian food right to your doorstep!",
    ),
    OnboardingPageData(
      image:
      "assets/images/pizza-removebg-preview.png", // sample food image
      title: "Explore Indonesian Specialties",
      description:
      "Discover a variety of delicious and authentic dishes that will pamper your tongue",
    ),
    OnboardingPageData(
      image:
      "assets/images/rrr-removebg-preview.png", // sample food image
      title: "Fast & Easy Delivery",
      description: "Get your favorite meals delivered to your home quickly!",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: pages.length,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        itemBuilder: (context, index) {
          final page = pages[index];
          return OnboardingPage(
            image: page.image,
            title: page.title,
            description: page.description,
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CustomButton(
            text: _currentIndex == pages.length - 1
                ? "Let’s get started!"
                : "Next",
            onPressed: () {
              if (_currentIndex == pages.length - 1) {
                Get.offAll(() => LoginScreen());
              } else {
                _controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class OnboardingPageData {
  final String image;
  final String title;
  final String description;

  OnboardingPageData({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPage({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // background + main image
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset("assets/images/image (5).png"),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipOval(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 55),

        // Title text
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall, // adapts to light/dark

          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 16),

        // Description text
        Text(
          description,
          style:
    Theme.of(context).textTheme.bodyMedium, // theme body color

          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

