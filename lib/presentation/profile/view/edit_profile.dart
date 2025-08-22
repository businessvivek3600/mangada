import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:madhang/core/constants/colors..dart';
import 'package:madhang/shared/widgets/custom_button.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(height: 1, color: Colors.grey.shade300),
        ),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body:SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Profile Avatar
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 44,
                  backgroundColor: Colors.grey,
                  child: Icon(Iconsax.user, size: 48, color: Colors.white),
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.warning800,
                  child: const Icon(
                    Iconsax.edit,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Full Name
            _inputField(
              context,
              label: "Full Name",
              hint: "Enter your full name",
              initialValue: "Josephin",
            ),

            const SizedBox(height: 16),

            // Email
            _inputField(
              context,
              label: "Email",
              hint: "Enter your email",
              initialValue: "josephin@gmail.com",
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 16),

            // Phone Number
            _inputField(
              context,
              label: "Phone Number",
              hint: "Enter your phone number",
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 32),

            // Save Button
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                text: "Save Change",
                onPressed: () {
                  // Save changes logic here
                },
              ),

              const SizedBox(height: 12),

              customOutlinedButton(context, text: "Cancel", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(
    BuildContext context, {
    required String label,
    required String hint,
    String? initialValue,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 0.8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: AppColors.primary900, width: 2),
        ),
      ),
    );
  }
}
