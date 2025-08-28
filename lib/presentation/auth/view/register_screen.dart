import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/route_name.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/custom_button.dart';
import 'login_screen.dart';
import 'otp_verification_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
    context.pushNamed(Routes.otpVerification);

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
                Text("Register Account", style: theme.textTheme.displaySmall),
                const SizedBox(height: 4),
                Text("Let’s create your account first",
                    style: theme.textTheme.bodyLarge),

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
                    final emailRegex =
                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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
                  suffixIcon: const Icon(Icons.visibility_off_outlined, color: Colors.grey),
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

                const SizedBox(height: 30),

                /// Register Button
                CustomButton(
                  text: "Register",
                  onPressed: _onRegister,
                ),

                const SizedBox(height: 24),

                /// Divider
                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 0.3)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("or register with"),
                    ),
                    Expanded(child: Divider(thickness: 0.3)),
                  ],
                ),

                const SizedBox(height: 24),

                /// Social Buttons
                customOutlinedButton(
                  context,
                  icon: const FaIcon(FontAwesomeIcons.google),
                  text: "Register with Google", onTap: () {

                },
                ),
                const SizedBox(height: 12),
                customOutlinedButton(
                  context,
                  icon: FaIcon(
                    FontAwesomeIcons.apple,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  text: "Register with Apple", onTap: () {

                },
                ),
                const SizedBox(height: 12),
                customOutlinedButton(
                  context,
                  icon: const FaIcon(FontAwesomeIcons.facebook,
                      color: Colors.blue),
                  text: "Register with Facebook", onTap: () {

                },
                ),

                const SizedBox(height: 24),

                /// Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                        style: theme.textTheme.titleSmall),
                    TextButton(
                      onPressed: () {
                        context.goNamed(Routes.login);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// Terms
                Text.rich(
                  TextSpan(
                    text: "By clicking Register you agree to Recogonotes\n",
                    style: theme.textTheme.bodySmall,
                    children: [
                      TextSpan(
                        text: "Term of Use",
                        style: TextStyle(
                          color:theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
