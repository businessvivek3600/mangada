import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:madhang/core/constants/colors..dart';
import 'package:madhang/routes/route_name.dart';

import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            // Title
            Text("Profile", style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),

            const SizedBox(height: 24),

            // Profile Avatar
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.grey,
                  child: Icon(Iconsax.user, size: 48, color: Colors.white),
                ),
                GestureDetector(
                  onTap: () {
                  context.pushNamed(Routes.editProfile);
                  },
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.primary900,
                    child: const Icon(Iconsax.edit, size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Name + Email
            Text("Josephin", style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            Text("josephin@gmail.com", style: textTheme.bodySmall?.copyWith(color: Colors.grey)),

            const SizedBox(height: 24),

            // Menu Items
            _menuItem(
              context,
              icon: Iconsax.notification,
              label: "Notifications",
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("4", style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ),
            _menuItem(context, icon: Iconsax.card, label: "Payment"),
            _menuItem(context, icon: Iconsax.setting, label: "Settings",onTap: () => context.pushNamed(Routes.settings),),
            _menuItem(context, icon: Iconsax.message_question, label: "Help Center",onTap: () => context.pushNamed(Routes.helpCenter),),
            _menuItem(context, icon: Iconsax.security_safe, label: "Privacy Policy"),
            _menuItem(context, icon: Iconsax.logout, label: "Logout",onTap: () => context.goNamed(Routes.login),),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(BuildContext context, {required IconData icon, required String label, Widget? trailing, VoidCallback? onTap,}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, size: 22, color: Colors.black),
        title: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        trailing: trailing ?? const Icon(Iconsax.arrow_right_3, size: 20, color: Colors.black),
      ),
    );
  }
}
