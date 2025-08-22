import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:madhang/core/constants/colors..dart';
import 'package:madhang/shared/widgets/custom_button.dart';

class ChangeAddressBottomSheet extends StatelessWidget {
  const ChangeAddressBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration:  BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.gray300,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Text("Select Delivery Address",
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),

            const SizedBox(height: 16),

            // Current Address
            _addressCard(
              context,
              isCurrent: true,
              title: "Current Delivery Address",
              name: "House | Josephin | (+0) 123 456 789",
              address: "424 Kansas Ave, Brewster, KS 67732, United States",
              onEdit: () {},
            ),

            const SizedBox(height: 12),

            /// Other Address
            _addressCard(
              context,
              isCurrent: false,
              title: "Delivery Address",
              name: "Apartment | Alex | (+0) 987 654 321",
              address: "221B Baker Street, London, UK",
              onEdit: () {},
            ),


            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(

                onPressed: () {},
                icon:  Icon(Icons.add, color: AppColors.primary500),
                label: const Text("Add Delivery Address"),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),

            const SizedBox(height: 24),

            CustomButton(text: "Confirm Delivery Address", onPressed: () {
              Get.back(); // close bottom sheet
            },),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _addressCard(
      BuildContext context, {
        required bool isCurrent,
        required String title,
        required String name,
        required String address,
        required VoidCallback onEdit,
      }) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          color: isCurrent ? AppColors.primary900 : AppColors.gray200,
          width: isCurrent ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title + Icon
          Row(
            children: [
              Icon(
                isCurrent ? Iconsax.location : Iconsax.location5,
                size: 18,
                color: isCurrent ? AppColors.primary900 : null,
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color:
                  isCurrent ? AppColors.primary900 :null,
                ),
              ),
              const Spacer(),
              if (isCurrent)
                const Icon(Iconsax.tick_circle,
                    size: 20, color: AppColors.primary900),
            ],
          ),

          const SizedBox(height: 8),

          /// Name + Phone
          Text(
            name,
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 4),

          /// Address
          Text(
            address,
            style: textTheme.bodyMedium?.copyWith(
            ),
          ),

          const SizedBox(height: 10),

          /// Edit Button
          OutlinedButton(
            onPressed: onEdit,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.gray200),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              padding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            ),
            child: Text(
              "Edit Address",
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
