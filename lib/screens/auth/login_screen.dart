import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:madhang/screens/auth/register_screen.dart';
import 'package:madhang/screens/home/home_page.dart';

import '../../widgets/app_text_field.dart';
import '../../widgets/custom_button.dart';
import 'forgot_passowrd.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    Get.offAll(()=> const MyHomePage(),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 800));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                /// Title
                Text("Login Account", style: theme.textTheme.displaySmall),
                const SizedBox(height: 4),
                Text(
                  "Welcome back to your account",
                  style: theme.textTheme.bodyLarge,
                ),

                const SizedBox(height: 32),

                /// Email Field
                AppTextField(
                  controller: _emailController,
                  hintText: "Enter your email",
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                /// Password Field
                AppTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  prefixIcon: Icons.vpn_key_outlined,
                  obscureText: true,
                  suffixIcon: const Icon(
                    Icons.visibility_off_outlined,
                    color: Colors.grey,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                // 🔹 Forgot Password button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // 👉 Navigate to Forgot Password Screen
                 Get.to(() => ForgotPasswordScreen());
                      debugPrint("Forgot password tapped");
                    },
                    child: Text(
                      "Forgot Password?",
                      style:  TextStyle(
                      color:theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// Register Button
                CustomButton(text: "Login", onPressed: _onRegister),

                const SizedBox(height: 24),

                /// Divider
                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 0.3)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("or login with"),
                    ),
                    Expanded(child: Divider(thickness: 0.3)),
                  ],
                ),

                const SizedBox(height: 24),

                /// Social Buttons
                customOutlinedButton(
                  context,
                  icon: const FaIcon(FontAwesomeIcons.google),
                  text: "Login with Google",
                  onTap: () {

                  },
                ),
                const SizedBox(height: 12),
                customOutlinedButton(
                  context,
                  icon: FaIcon(
                    FontAwesomeIcons.apple,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                  ),
                  text: "Login with Apple",
                  onTap: () {

                  },
                ),
                const SizedBox(height: 12),
                customOutlinedButton(
                  context,
                  icon: const FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Colors.blue,
                  ),
                  text: "Login with Facebook",
                  onTap: () {

                  },
                ),

                const SizedBox(height: 24),

                /// Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: theme.textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offAll(
                          () => RegisterScreen(),
                          transition: Transition.rightToLeftWithFade,
                          duration: const Duration(milliseconds: 800),
                        );
                      },
                      child:  Text(
                        "Register",
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
        ),
      ),

    );
  }
}
