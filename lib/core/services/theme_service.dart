import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors..dart';




/// ================= THEME SERVICE ================= ///
class ThemeService extends GetxService with WidgetsBindingObserver {
  static const String _key = 'isDarkMode';
  final _box = GetStorage();

  final RxnBool _isDarkMode = RxnBool();
  RxBool isDark = false.obs;

  ThemeMode get themeMode {
    if (_isDarkMode.value == null) {
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    }
    return _isDarkMode.value! ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    if (_box.hasData(_key)) {
      _isDarkMode.value = _box.read(_key);
    } else {
      _isDarkMode.value = null;
    }

    isDark.value = themeMode == ThemeMode.dark;
    Get.changeThemeMode(themeMode);

    ever(_isDarkMode, (_) {
      isDark.value = themeMode == ThemeMode.dark;
    });
  }

  @override
  void didChangePlatformBrightness() {
    if (_isDarkMode.value == null) {
      Get.changeThemeMode(themeMode);
      isDark.value = themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme() {
    final current = themeMode == ThemeMode.dark;
    _isDarkMode.value = !current;
    _box.write(_key, _isDarkMode.value);
    Get.changeThemeMode(themeMode);
    isDark.value = themeMode == ThemeMode.dark;
  }

  ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary900,
    scaffoldBackgroundColor: AppColors.gray50,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary900,
      background: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(size: 16), // light theme
     // titleTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary900,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      const TextTheme(
        displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black),
        displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
        displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),

        headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),

        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),

        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black87),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black54),

        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87),
        labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black54),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary900),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary900,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStatePropertyAll(AppColors.primary900),
    ),
  );

  ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary900,
    scaffoldBackgroundColor: AppColors.gray900,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary900,
      background: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary900,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(size: 20), // dark theme
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary900,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      const TextTheme(
        displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
        displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
        displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),

        headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),

        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),

        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white70),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white60),

        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white70),
        labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.white60),
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary900),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary900,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStatePropertyAll(AppColors.primary900),
    ),
  );
}
