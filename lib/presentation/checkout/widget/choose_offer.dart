import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:madhang/core/constants/colors..dart';
import 'package:madhang/shared/widgets/custom_button.dart';

class ChooseOfferSheet extends StatefulWidget {
  const ChooseOfferSheet({super.key});

  @override
  State<ChooseOfferSheet> createState() => _ChooseOfferSheetState();
}

class _ChooseOfferSheetState extends State<ChooseOfferSheet> {
  int selectedIndex = 0;

  final List<Map<String, String>> offers = [
    {
      "code": "weekendsale25",
      "discount": "Discount 25% up to \$4",
      "validUntil": "Valid until 26 August 2024 | 12:00 AM",
    },
    {
      "code": "newuser50",
      "discount": "Discount 50% up to \$6",
      "validUntil": "Valid until 30 September 2024 | 12:00 AM",
    },
    {
      "code": "freeship",
      "discount": "Free Shipping on orders above \$20",
      "validUntil": "Valid until 15 October 2024 | 12:00 AM",
    },
    {
      "code": "flash10",
      "discount": "Discount 10% up to \$2",
      "validUntil": "Valid until 1 September 2024 | 12:00 AM",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // ==== FIXED HEADER ====
            Column(
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

                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Use Offer",
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Voucher input field
                TextField(
                  decoration: InputDecoration(
                    hintText: "Input code voucher",
                    suffixIcon: const Icon(Iconsax.search_normal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),

            // ==== SCROLLABLE OFFERS ====
            Expanded(
              child: ListView.builder(
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  final offer = offers[index];
                  return _voucherCard(
                    context,
                    isSelected: selectedIndex == index,
                    code: offer["code"]!,
                    discount: offer["discount"]!,
                    validUntil: offer["validUntil"]!,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // ==== FIXED BOTTOM BUTTON ====
            CustomButton(
              text: "Apply Offer",
              onPressed: () {
                final selectedOffer = offers[selectedIndex];
                Get.back(result: selectedOffer);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _voucherCard(
      BuildContext context, {
        required bool isSelected,
        required String code,
        required String discount,
        required String validUntil,
        required VoidCallback onTap,
      }) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary900 : AppColors.gray200,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Code + Icon
            Row(
              children: [
                const Icon(Iconsax.discount_shape, color: Colors.red),
                const SizedBox(width: 6),
                Text(
                  code,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
                const Spacer(),
                if (isSelected)
                  const Icon(Iconsax.tick_circle,
                      size: 20, color: Colors.red),
              ],
            ),

            const SizedBox(height: 8),

            Text(discount,
                style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500, color: Colors.black)),

            const SizedBox(height: 4),

            Text(validUntil,
                style: textTheme.bodySmall?.copyWith(color: AppColors.gray600)),

            const SizedBox(height: 10),

            Text(
              "Term & Conditions",
              style: textTheme.bodySmall
                  ?.copyWith(color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
