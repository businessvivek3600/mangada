import 'user_data_model.dart';

class LoginResponseModel {
  final bool status;
  final String message;
  final UserData? userData;
  final String? sessionToken;

  LoginResponseModel({
    required this.status,
    required this.message,
    this.userData,
    this.sessionToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      userData: json['data'] != null
          ? UserData.fromJson(json['data']['user_data'])
          : null,
      sessionToken: json['data']?['session_token'],
    );
  }
}


