

import 'notification_model.dart';

class Preferences {
  final Notifications notifications;
  final String language;
  final String currency;
  final List<dynamic> dietaryRestrictions;

  Preferences({
    required this.notifications,
    required this.language,
    required this.currency,
    required this.dietaryRestrictions,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) => Preferences(
    notifications: Notifications.fromJson(json["notifications"]),
    language: json["language"] ?? "en",
    currency: json["currency"] ?? "INR",
    dietaryRestrictions:
    List<dynamic>.from(json["dietaryRestrictions"] ?? []),
  );

  Map<String, dynamic> toJson() => {
    "notifications": notifications.toJson(),
    "language": language,
    "currency": currency,
    "dietaryRestrictions": dietaryRestrictions,
  };
}