import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  // Master toggle
  var enableAll = true.obs;

  // Promos
  var promosPush = true.obs;
  var promosWhatsApp = false.obs;

  // Social
  var socialPush = true.obs;
  var socialWhatsApp = false.obs;

  // Orders
  var ordersPush = true.obs;
  var ordersWhatsApp = false.obs;

  // Profile info
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final anniversaryController = TextEditingController();
  final genderController = TextEditingController();

  void saveChanges() {
    // TODO: Replace with API call
    Get.snackbar("Settings Saved", "Your notification preferences have been updated!");
  }

  void updateProfile() {
    Get.snackbar("Profile Updated", "Your profile changes have been saved!");
  }

  @override
  void onClose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    dobController.dispose();
    anniversaryController.dispose();
    genderController.dispose();
    super.onClose();
  }
}
