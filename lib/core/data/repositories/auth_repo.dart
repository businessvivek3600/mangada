import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/api_constant.dart';
import '../../constants/app_constant.dart';
import '../database/dio/base/api_response_model.dart';
import '../database/dio/dio/dio_client.dart';
import '../database/dio/exception/api_error_handler.dart';
import '../models/login_response_model.dart';


class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.dioClient,
    required this.sharedPreferences,
  });

  static const String tag = 'AuthRepo';

  /// Save token to shared preferences
  Future<void> saveUserToken(String token) async {
    dioClient.updateUserToken(token);
    try {
      await sharedPreferences.setString(SPConstants.userToken, token);
      await setIsLogin(true);
    } catch (e) {
      rethrow;
    }
  }

  /// Save isLogin status
  Future<void> setIsLogin(bool value) async {
    await sharedPreferences.setBool(SPConstants.isLogin, value);
  }

  String getUserToken() {
    return sharedPreferences.getString(SPConstants.userToken) ?? '';
  }

  /// -------- AUTH API FUNCTIONS -------- ///

  /// 🔹 User Signup
  Future<ApiResponse> signUp(FormData formData) async {
    try {
      final response = await dioClient.post(
        ApiConstants.signup,
        data: formData,
      );

      debugPrint('✅ SIGNUP RESPONSE: ${response.data}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /// 🔹 User Login
  Future<LoginResponseModel> login(String email, String password) async {
    try {
      final body = {"email": email, "password": password};
      print("🔹 Login API Body: $body");

      final response = await dioClient.post(
        ApiConstants.login,
        data: body,
      );

      print("🔹 Login API Response: ${response.data}");

      if (response.statusCode == 200) {
        final loginResponse = LoginResponseModel.fromJson(response.data);

        if (loginResponse.sessionToken != null) {
          await saveUserToken(loginResponse.sessionToken!);
        }

        return loginResponse;
      } else {
        throw Exception("Login failed: ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Login error: $e");
    }
  }
}

  /// 🔹 Forgot Password
  Future<ApiResponse> forgotPassword(FormData formData) async {
    try {
      final response = await dioClient.post(
        ApiConstants.forgetPassword,
        data: formData,
      );

      debugPrint('✅ FORGOT PASSWORD RESPONSE: ${response.data}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /// 🔹 Reset Password
  Future<ApiResponse> resetPassword(FormData formData) async {
    try {
      final response = await dioClient.post(
        ApiConstants.resetPassword,
        data: formData,
      );

      debugPrint('✅ RESET PASSWORD RESPONSE: ${response.data}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /// 🔹 Logout
  Future<ApiResponse> logout(FormData formData) async {
    try {
      final response = await dioClient.post(
        ApiConstants.logout,
        data: formData,
      );

      debugPrint('✅ LOGOUT RESPONSE: ${response.data}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /// 🔹 Refresh Token
  Future<ApiResponse> refreshToken(FormData formData) async {
    try {
      final response = await dioClient.post(
        ApiConstants.refreshToken,
        data: formData,
      );

      debugPrint('✅ REFRESH TOKEN RESPONSE: ${response.data}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
