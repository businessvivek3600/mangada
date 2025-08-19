import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:madhang/screens/auth/register_screen.dart';
import 'package:madhang/screens/onboardingScreen/on_boarding_screen.dart';
import 'package:madhang/services/theme_service.dart';
import 'package:permission_handler/permission_handler.dart';

import 'controllers/theme_controller.dart';
import 'screens/home/home_page.dart';
import 'screens/splash/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Request location permission at startup
  await _requestPermissions();
  runApp(const MyApp());
}

Future<void> _requestPermissions() async {
  var status = await Permission.locationWhenInUse.status;
  if (!status.isGranted) {
    await Permission.locationWhenInUse.request();
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeService themeService = Get.put(ThemeService());
   return Obx(() => GetMaterialApp(
      debugShowCheckedModeBanner: false,
     theme: themeService.lightTheme,
     darkTheme: themeService.darkTheme,
     themeMode: themeService.themeMode,
      home: const SplashScreen(),
      getPages: [
        GetPage(name: '/onboarding', page: () => OnboardingScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/home', page: () => const MyHomePage()),

      ],
    ));
  }
}