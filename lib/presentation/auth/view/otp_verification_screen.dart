import 'dart:async';
import 'package:flutter/material.dart';

import '../../../shared/widgets/custom_button.dart';


class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otpControllers = List.generate(6, (_) => TextEditingController());
  late Timer _timer;
  int _secondsRemaining = 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    for (var c in _otpControllers) {
      c.dispose();
    }
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _onVerify() {
    final otp = _otpControllers.map((c) => c.text).join();
    debugPrint("Entered OTP: $otp");
    // ✅ Handle OTP verification logic
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(),
            Text("Back",
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),

            /// Title
            Text("Verification", style: theme.textTheme.displaySmall),
            const SizedBox(height: 4),
            Text("We need to verify your email",
                style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal,color: Colors.grey)),
            const SizedBox(height: 16),
            Text(
              "To verify your account, enter the 6 digit OTP code\nthat we sent to your email.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),

            /// OTP Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 52,
                  height: 52,
                  child: TextField(
                    controller: _otpControllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(36),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(36),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            /// Timer
            Text(
              _secondsRemaining > 0
                  ? "00:${_secondsRemaining.toString().padLeft(2, '0')}"
                  : "Expired",
              style:  TextStyle(
                color:theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),

            const SizedBox(height: 24),

            /// Verify Button
            CustomButton(
              text: "Verify",
              onPressed: _onVerify,
            ),

            const SizedBox(height: 16),

            /// Resend OTP
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn’t receive the OTP code? "),
                GestureDetector(
                  onTap: () {
                    debugPrint("Resend OTP clicked");
                    setState(() {
                      _secondsRemaining = 60;
                      _startTimer();
                    });
                  },
                  child:  Text(
                    "Resend OTP",
                    style: TextStyle(
                      color:theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
