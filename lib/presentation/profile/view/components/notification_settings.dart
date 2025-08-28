import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../controller/setting_controller.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Notification Preferences",
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Enable All
            Obx(() => SwitchListTile(
              title: Text("Enable all",
                  style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
              subtitle: Text("Activate all notifications",
                  style: textTheme.bodySmall?.copyWith(color: Colors.grey)),
              value: controller.enableAll.value,
              onChanged: (val) => controller.enableAll.value = val,
            )),
            const Divider(),

            // Promos
            _buildSection(
              context,
              title: "Promos and offers",
              subtitle:
              "Receive updates about coupons, promotions and money-saving offers",
              pushValue: controller.promosPush,
              whatsappValue: controller.promosWhatsApp,
            ),

            // Social
            _buildSection(
              context,
              title: "Social notifications",
              subtitle:
              "Get notified when someone follows your profile, or when you get likes and comments on reviews and photos posted by you",
              pushValue: controller.socialPush,
              whatsappValue: controller.socialWhatsApp,
            ),

            // Orders
            _buildSection(
              context,
              title: "Orders and purchases",
              subtitle:
              "Receive updates related to your order status, memberships, table bookings and more",
              pushValue: controller.ordersPush,
              whatsappValue: controller.ordersWhatsApp,
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.saveChanges();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Save changes"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title,
        required String subtitle,
        required RxBool pushValue,
        required RxBool whatsappValue}) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(subtitle,
            style: textTheme.bodySmall?.copyWith(color: Colors.grey)),
        const SizedBox(height: 8),

        // Push toggle
        Obx(() => SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Iconsax.notification),
          title: const Text("Push"),
          value: pushValue.value,
          onChanged: (val) => pushValue.value = val,
        )),

        // WhatsApp toggle
        Obx(() => SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: Icon(FontAwesomeIcons.whatsapp, color: Colors.green),
          title: const Text("WhatsApp"),
          value: whatsappValue.value,
          onChanged: (val) => whatsappValue.value = val,
        )),
        const Divider(),
      ],
    );
  }
}
