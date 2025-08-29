import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:madhang/core/constants/api_constant.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../core/data/models/login_response_model.dart';
import '../../../core/data/repositories/auth_repo.dart';
import '../../../main.dart';
import '../../../routes/route_name.dart';

class AuthController extends GetxController {
  // Text controllers for login form
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // For loading state
  var isLoading = false.obs;

  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  LoginResponse? loginResponse;

  ///------------------- Login function
  Future<void> login(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      toast(
        "Please enter username and password",
        bgColor: Colors.redAccent,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await dioClient.post(
        ApiConstants.login,
        data: {
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        },
      );

      print("✅ Login Response Status: ${response.statusCode}");
      print("✅ Login Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        loginResponse = LoginResponse.fromJson(response.data);
        final status = response.data['status'] ?? false;
        print("login status: ✅ ✅ ✅ $status");

        if (loginResponse!.status) {
          toast(
            "Login Successfully: Welcome ${loginResponse!.data.userData.firstName}!",
            bgColor: Colors.green,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
          );
          /// 👉 Navigate to Main Screen
          context.goNamed(Routes.main);
        } else {
          toast(
            loginResponse?.message ?? 'Login Failed',
            bgColor: Colors.redAccent,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
          );
        }
      } else {
        toast(
          "Server Error: ${response.statusCode}",
          bgColor: Colors.redAccent,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      print("❌ Exception during login: $e");
      toast(
        e.toString(),
        bgColor: Colors.redAccent,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// ---------------- SIGNUP ----------------
  Future<void> signup({required String email, required String password}) async {
    try {
      isLoading.value = true;

      final response = await dioClient.post(
        ApiConstants.signup,
        data: {
          'email': email.trim(),
          'password': password.trim(),
        },
      );

      print("✅ Signup Response Status: ${response.statusCode}");
      print("✅ Signup Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final status = response.data['status'] ?? false;
        final message = response.data['message'] ?? 'Unknown response';

        if (status) {
          toast(
            "Signup Successful: $message",
            bgColor: Colors.green,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
          );
        } else {
          toast(
            "Signup Failed: $message",
            bgColor: Colors.redAccent,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
          );
        }
      } else {
        toast(
          "Server Error: ${response.statusCode}",
          bgColor: Colors.redAccent,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      print("❌ Exception during signup: $e");
      toast(
        e.toString(),
        bgColor: Colors.redAccent,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
      );
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
