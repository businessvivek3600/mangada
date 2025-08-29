import 'package:madhang/core/data/models/user_data_model.dart';

class LoginResponse {
  final bool status;
  final String message;
  final LoginData data;

  LoginResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json["status"] ?? false,
    message: json["message"] ?? "",
    data: LoginData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class LoginData {
  final UserData userData;
  final String sessionToken;

  LoginData({
    required this.userData,
    required this.sessionToken,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    userData: UserData.fromJson(json["user_data"]),
    sessionToken: json["session_token"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "user_data": userData.toJson(),
    "session_token": sessionToken,
  };
}






