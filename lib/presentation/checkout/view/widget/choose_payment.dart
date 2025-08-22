import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:madhang/core/constants/colors..dart';
import 'package:madhang/shared/widgets/custom_button.dart';

class ChoosePaymentSheet extends StatefulWidget {
  const ChoosePaymentSheet({super.key});

  @override
  State<ChoosePaymentSheet> createState() => _ChoosePaymentSheetState();
}

class _ChoosePaymentSheetState extends State<ChoosePaymentSheet> {
  int selectedIndex = 1;

  final List<Map<String, dynamic>> paymentMethods = [
    {
      "title": "CASH",
      "icon": Iconsax.wallet_1,
    },
    {
      "title": "BANK TRANSFER",
      "icon": Iconsax.bank,
    },
    {
      "title": "DEBIT CARD",
      "icon": Iconsax.card,
    },
    {
      "title": "Add Payment Method",
      "icon": Iconsax.add,
      "isAdd": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          /// Drag indicator
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

          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select Payment Method",
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

          /// Payment List (scrollable)
          Expanded(
            child: ListView.separated(
              itemCount: paymentMethods.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = paymentMethods[index];
                final isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary900
                            : AppColors.gray200,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          item["icon"],
                          color: item["isAdd"] == true
                              ? Colors.red
                              : AppColors.gray700,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item["title"],
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: item["isAdd"] == true
                                  ? Colors.red
                                  : Colors.black,
                            ),
                          ),
                        ),
                        if (isSelected && item["isAdd"] != true)
                          const Icon(Icons.check_circle,
                              color: Colors.red, size: 20),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          /// Confirm Button (fixed bottom)
          CustomButton(
            text: "Confirm Payment Method",
            onPressed: () {
              Get.back(result: paymentMethods[selectedIndex]["title"]);
            },
          ),
        ],
      ),
    );
  }
}
