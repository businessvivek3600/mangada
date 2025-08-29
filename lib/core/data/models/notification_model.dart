class Notifications {
  final bool email;
  final bool sms;
  final bool push;

  Notifications({
    required this.email,
    required this.sms,
    required this.push,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
    email: json["email"] ?? false,
    sms: json["sms"] ?? false,
    push: json["push"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "sms": sms,
    "push": push,
  };
}