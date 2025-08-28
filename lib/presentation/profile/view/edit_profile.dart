import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:madhang/core/constants/colors..dart';
import 'package:madhang/shared/widgets/custom_button.dart';


import '../../../shared/widgets/app_text_field.dart';
import '../controller/setting_controller.dart';
import 'settings_screen.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = Get.put(SettingsController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("Profile", style: textTheme.titleMedium),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Avatar
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: const AssetImage(
                    "assets/images/p1.png",
                  ), // replace with NetworkImage if dynamic
                  backgroundColor: Colors.grey.shade200,
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primary900,
                  child: const Icon(
                    Iconsax.edit,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Name
            AppTextField(
              hintText: "Name",
              prefixIcon: Iconsax.user,
              controller: controller.nameController,
            ),
            const SizedBox(height: 16),

            // Mobile
            AppTextField(
              hintText: "Mobile",
              prefixIcon: Iconsax.call,
              controller: controller.mobileController,
              keyboardType: TextInputType.phone,
              suffixIcon: TextButton(
                onPressed: () {},
                child: Text(
                  "CHANGE",
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Email
            AppTextField(
              hintText: "Email",
              prefixIcon: Iconsax.sms,
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              suffixIcon: TextButton(
                onPressed: () {},
                child: Text(
                  "CHANGE",
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // DOB
            GestureDetector(
              onTap:
                  () => pickDate(
                    context: context,
                    controller: controller.dobController,
                  ),
              child: AbsorbPointer(
                child: AppTextField(
                  hintText: "Date of birth",
                  prefixIcon: Iconsax.calendar_1,
                  controller: controller.dobController,
                  suffixIcon: const Icon(
                    Iconsax.calendar_1,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Anniversary
            GestureDetector(
              onTap:
                  () => pickDate(
                    context: context,
                    controller: controller.anniversaryController,
                  ),
              child: AbsorbPointer(
                child: AppTextField(
                  hintText: "Anniversary",
                  prefixIcon: Iconsax.gift,
                  controller: controller.anniversaryController,
                  suffixIcon: const Icon(
                    Iconsax.calendar_1,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Gender
            AppTextField(
              hintText: "Gender",
              prefixIcon: Iconsax.personalcard,
              controller: controller.genderController,
            ),

            const SizedBox(height: 32),

            // Update button
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomButton(text: "Update Profile", onPressed: () {}),
        ),
      ),
    );
  }
}
///Date Picker
Future<void> pickDate({
  required BuildContext context,
  required TextEditingController controller,
}) async {
  DateTime now = DateTime.now();

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: DateTime(1950),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.primary900,   // header background
            onPrimary: Colors.white,         // header text
            onSurface: Colors.black,         // body text
          ),
          dialogBackgroundColor: Colors.white,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary900, // buttons
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    controller.text = DateFormat("dd MMM yyyy").format(pickedDate);
  }
}