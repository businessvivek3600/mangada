import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:madhang/core/constants/colors..dart';
import 'package:madhang/presentation/checkout/view/widget/payment_sucess.dart';

import 'widget/change_address.dart';
import 'widget/choose_offer.dart';
import 'widget/choose_payment.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyOffers = [
      "weekendsale25",
      "freeshipping50",
      "newuser10",
      "bigdeal30",
    ];

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Checkout",
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.gray200, height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address
            _sectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Iconsax.location,
                        color: Colors.black,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text("Delivery Address", style: textTheme.labelMedium),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "House | Josephin | (+0) 123 456 789",
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "424 Kansas Ave, Brewster, KS 67732, United States",
                    style: textTheme.labelMedium,
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      Get.bottomSheet(
                        const ChangeAddressBottomSheet(),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      side: const BorderSide(color: AppColors.gray300),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 7,
                      ),
                    ),
                    child: Text(
                      "Change Delivery Address",
                      style: textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Items
            Text("Items", style: textTheme.titleSmall),
            const SizedBox(height: 8),
            _cartItem("Gudeg", "\$4.0", "\$5.0", "x2"),
            const SizedBox(height: 8),
            _cartItem("Nasi Liwet", "\$3.0", "\$5.0", "x1"),

            const SizedBox(height: 16),

            // Note
            Text("Note", style: textTheme.titleSmall),
            const SizedBox(height: 8),
            TextField(
              maxLines: 3,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary900, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.gray300, width: 1),
                ),
                hintText: "Type your note here",
                hintStyle: textTheme.bodyMedium?.copyWith(
                  color: AppColors.gray500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary900, width: 1),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Offer
            _sectionCard(
              onTap: () {
                Get.bottomSheet(
                  const ChooseOfferSheet(),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Iconsax.discount_shape,
                            color: AppColors.primary900,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Use Offer",
                            style: textTheme.labelLarge?.copyWith(
                              color: AppColors.gray400,
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.keyboard_arrow_down, size: 20),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Text(
                    "weekendsale25",
                    style: textTheme.titleSmall?.copyWith(
                      color: AppColors.primary900,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Discount 25% up to \$4",
                    style: textTheme.labelLarge?.copyWith(
                      color: AppColors.primary900,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Payment Method
            _sectionCard(
              onTap: () {
                Get.bottomSheet(
                  const ChoosePaymentSheet(),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                );

              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Iconsax.card,
                            color: AppColors.primary900,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Payment Method",
                            style: textTheme.labelLarge?.copyWith(
                              color: AppColors.gray400,
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.keyboard_arrow_down, size: 20),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Bank Transfer",
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary900,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Summary
            _priceRow("Sub-total", "\$15.0"),
            _priceRow("Discount Voucher", "- \$4.0", red: true),
            _priceRow("Fee", "\$0.25"),
            const Divider(),
            _priceRow("Total", "\$11.25", bold: true),

            SizedBox(height: size.height * 0.01),
          ],
        ),
      ),

      // Bottom Checkout Button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Total :",
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.gray500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "\$11.25",
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "\$15.0",
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary500,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.primary500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Get.offAll(()=> PaymentSuccess());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                ),
                child: const Text(
                  "Checkout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard({required Widget child, VoidCallback? onTap}) {
    final card = Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gray200, width: 1),
      ),
      child: child,
    );

    if (onTap != null) {
      // Make it tappable only when needed
      return InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: card,
      );
    } else {
      // Normal card
      return card;
    }
  }


  Widget _cartItem(String title, String price, String oldPrice, String qty) {
    return _sectionCard(
      child: Builder(
        builder: (context) {
          final textTheme = Theme.of(context).textTheme;
          return Row(
            children: [
              // product image
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.gray200,
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.immediate.co.uk/production/volatile/sites/30/2022/08/Corndogs-7832ef6.jpg?quality=90&resize=556,505',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // product info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          price,
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          oldPrice,
                          style: textTheme.bodySmall?.copyWith(
                            color: AppColors.primary500,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: AppColors.primary500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // qty
              Container(
                width: 72,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.gray200,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Center(
                  child: Text(
                    qty,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _priceRow(
    String label,
    String value, {
    bool red = false,
    bool bold = false,
  }) {
    return Builder(
      builder: (context) {
        final textTheme = Theme.of(context).textTheme;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: textTheme.bodyMedium?.copyWith(color: AppColors.gray500),
              ),
              Text(
                value,
                style: textTheme.bodyMedium?.copyWith(
                  color: red ? AppColors.primary500 : null,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
