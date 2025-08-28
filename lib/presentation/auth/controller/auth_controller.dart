import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/data/models/login_response_model.dart';
import '../../../core/data/repositories/auth_repo.dart';

class AuthController extends GetxController {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  // Text controllers for login form
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // For loading state
  var isLoading = false.obs;
  LoginResponseModel? loginResponse;
  // Login function
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please enter email and password");
      return;
    }

    try {
      isLoading.value = true;
      loginResponse = await authRepo.login(email, password);

      if (loginResponse != null && loginResponse!.status) {
        Get.snackbar("Success", loginResponse!.message);
        // Navigate after login
        // Get.offAll(() => HomeScreen());
      } else {
        Get.snackbar("Error", loginResponse?.message ?? "Login failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
