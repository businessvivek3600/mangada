import 'prefernces_model.dart';

class UserData {
  final Preferences preferences;
  final String id;
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final String? avatar;
  final String role;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final bool isActive;
  final List<dynamic> deviceTokens;
  final List<dynamic> addresses;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String lastLogin;
  final String fullName;
  final bool isAccountLocked;

  UserData({
    required this.preferences,
    required this.id,
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    this.avatar,
    required this.role,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.isActive,
    required this.deviceTokens,
    required this.addresses,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.lastLogin,
    required this.fullName,
    required this.isAccountLocked,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    preferences: Preferences.fromJson(json["preferences"]),
    id: json["_id"] ?? "",
    email: json["email"] ?? "",
    phone: json["phone"] ?? "",
    firstName: json["firstName"] ?? "",
    lastName: json["lastName"] ?? "",
    avatar: json["avatar"],
    role: json["role"] ?? "",
    isEmailVerified: json["isEmailVerified"] ?? false,
    isPhoneVerified: json["isPhoneVerified"] ?? false,
    isActive: json["isActive"] ?? false,
    deviceTokens: List<dynamic>.from(json["deviceTokens"] ?? []),
    addresses: List<dynamic>.from(json["addresses"] ?? []),
    createdAt: json["createdAt"] ?? "",
    updatedAt: json["updatedAt"] ?? "",
    v: json["__v"] ?? 0,
    lastLogin: json["lastLogin"] ?? "",
    fullName: json["fullName"] ?? "",
    isAccountLocked: json["isAccountLocked"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "preferences": preferences.toJson(),
    "_id": id,
    "email": email,
    "phone": phone,
    "firstName": firstName,
    "lastName": lastName,
    "avatar": avatar,
    "role": role,
    "isEmailVerified": isEmailVerified,
    "isPhoneVerified": isPhoneVerified,
    "isActive": isActive,
    "deviceTokens": deviceTokens,
    "addresses": addresses,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
    "lastLogin": lastLogin,
    "fullName": fullName,
    "isAccountLocked": isAccountLocked,
  };
}