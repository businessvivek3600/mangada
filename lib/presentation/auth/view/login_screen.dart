import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../core/data/database/functions.dart';
import '../../../routes/route_name.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/custom_button.dart';

import '../../main/main_screen.dart';
import '../controller/auth_controller.dart';
import 'forgot_passowrd.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
final AuthController  authController = Get.find<AuthController>();

  void _onRegister() {
    authController.login( context);
    //context.goNamed(Routes.main);
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
                  controller: authController.emailController,
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
                Obx(() {

                  return AppTextField(
                    controller:authController.passwordController,
                    hintText: "Password",
                    prefixIcon: Icons.vpn_key_outlined,
                    obscureText: authController.isPasswordHidden.value, // 👀 reactive toggle
                    textInputAction: TextInputAction.done,
                    suffixIcon: IconButton(
                      icon: Icon(
                        authController.isPasswordHidden.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: authController.togglePasswordVisibility, // 🔄 toggle
                    ),
                    validator: Validators.validateLoginPassword,
                    onFieldSubmitted: (_) => _onRegister(),
                  );
                }),
                // 🔹 Forgot Password button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // 👉 Navigate to Forgot Password Screen
                 context.pushNamed(Routes.forgotPassword);
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
                        context.goNamed(Routes.register);
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
