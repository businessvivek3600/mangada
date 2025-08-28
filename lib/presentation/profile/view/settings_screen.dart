import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:madhang/core/constants/colors..dart';

import '../../../routes/route_name.dart';
import '../controller/setting_controller.dart';
import 'components/notification_settings.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = Get.put(SettingsController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Edit Profile
            _settingsItem(
              context,
              title: "Edit Profile",
              subtitle: "Change your name, description and profile photo",
              icon: Iconsax.user_edit,
              onTap: () {
                context.pushNamed(Routes.editProfile);
              },
            ),

            // Notification Settings
            _settingsItem(
              context,
              title: "Notification Settings",
              subtitle: "Define what emails and notifications you want to see",
              icon: Iconsax.notification,
              onTap: () {
               context.pushNamed(Routes.notificationSettings);
              },
            ),

            // Account Settings
            _settingsItem(
              context,
              title: "Account Settings",
              subtitle: "Change your email or delete your account",
              icon: Iconsax.setting,
              onTap: () {
                context.pushNamed(Routes.accountSettings);
              },
            ),

            // App Permissions
            _settingsItem(
              context,
              title: "App Permissions",
              subtitle: "Open your phone settings",
              icon: Iconsax.security_safe,
              onTap: () {
                AppSettings.openAppSettings();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsItem(BuildContext context,
      {required String title,
        required String subtitle,
        required IconData icon,
        VoidCallback? onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.black),
      title: Text(title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          )),
      subtitle: Text(subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey,
          )),
      trailing: const Icon(Iconsax.arrow_right_3, size: 18, color: Colors.black),
    );
  }
}


