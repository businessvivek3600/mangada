import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../routes/route_name.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Settings"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Change Email"),
              trailing: const Icon(Iconsax.arrow_right_3),
              onTap: () {
                context.pushNamed(Routes.changeEmail);
              },
            ),
            SizedBox(height: 10,),
            const Divider(height: 1),
            SizedBox(height: 10,),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Delete Account"),
              trailing: const Icon(Iconsax.arrow_right_3),
              onTap: () {
                context.pushNamed(Routes.deleteAccount);
              },
            ),
          ],
        ),
      ),
    );
  }
}
