import 'package:flutter/material.dart';

class ChangeEmailScreen extends StatelessWidget {
  const ChangeEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Email"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            "To change your email, please login to your account on our "
                "website using a desktop/laptop.\n\n"
                "Click on your Profile on top right -> Tap on Settings -> "
                "Under Profile Information locate your Email -> Tap on Change to update your email.\n\n"
                "Complete the verification process via the confirmation Email "
                "sent on the registered & new Email ID.\n\n"
                "In case of any difficulties, please contact us at help@zomato.com.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        ),
      ),
    );
  }
}
