import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../widgets/custom_button.dart';

class CheckMailboxScreen extends StatelessWidget {
  final String email;

  const CheckMailboxScreen({super.key, required this.email});

  /// 🔑 Function to mask email
  String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email; // invalid email, return as-is

    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 2) {
      // e.g. ab@gmail.com -> a*@gmail.com
      return "${username[0]}${"*" * (username.length - 1)}@$domain";
    }

    // Keep first and last character, mask the middle
    final masked = username[0] +
        "*" * (username.length - 2) +
        username[username.length - 1];

    return "$masked@$domain";
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            BackButton(),
            Text(
              "Back",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Icon (mailbox image)
              Image.asset(
                "assets/images/sms-tracking.png",
                height: 80,
                width: 80,
              ),
              const SizedBox(height: 32),

              /// Title
              Text(
                "Check your mailbox",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              /// Subtitle
              Text(
                "Click the link sent to ${maskEmail(email)} before reset your password",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                text: "Re-send Email",
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Verification email re-sent")),
                  );
                },
              ),
              const SizedBox(height: 16),
              customOutlinedButton(
                context,
                text: "Call Center",
                onTap: () {
                  // TODO: Call center action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
