import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// ================= CONTROLLER ================= ///
class ThemeController extends GetxController {
  var isDark = false.obs;

  ThemeMode get themeMode => isDark.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(themeMode);
  }
}