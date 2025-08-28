import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors..dart';
import '../../checkout/checkout_screen.dart';
import '../controller/cart_controller.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final cartController = Get.find<CartController>();
  // 🔹 Static demo cart items
  final List<Map<String, dynamic>> cartItems = [
    {
      "title": "Nasi Liwet",
      "price": 3.0,
      "oldPrice": 5.0,
      "quantity": 1,
      "selected": true,
    },
    {
      "title": "Gudeg",
      "price": 4.0,
      "oldPrice": 5.0,
      "quantity": 2,
      "selected": true,
    },
    {
      "title": "Nasi Liwet",
      "price": 3.0,
      "oldPrice": 5.0,
      "quantity": 1,
      "selected": true,
    },
  ];
  double get total =>
      cartItems.where((item) => item["selected"]).fold(
        0.0,
            (sum, item) => sum + (item["price"] * item["quantity"]),
      );

  double get oldTotal =>
      cartItems.where((item) => item["selected"]).fold(
        0.0,
            (sum, item) => sum + (item["oldPrice"] * item["quantity"]),
      );
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text("Cart", style: textTheme.titleLarge),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz_outlined, size: 24),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
      ),

      /// 🛒 Cart List
      body: Obx(() {
      if (cartController.cartItems.isEmpty) {
        return Center(child: Text("Your cart is empty"));
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          item["selected"]  = !item["selected"];
                        });
                      },
                      child: Icon(
                          item["selected"]
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color:  item["selected"]
                              ? theme.primaryColor : AppColors.gray300
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.15),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            /// ✅ Checkbox
                            /// 🖼 Image Placeholder
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.image, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(width: 12),

                            /// 🍴 Item Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item["title"],
                                      style: textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      )),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text("\$${item["price"]}",
                                          style: textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      const SizedBox(width: 6),
                                      Text(
                                        "\$${item["oldPrice"]}",
                                        style: textTheme.bodySmall?.copyWith(
                                          color:AppColors.danger600,
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: AppColors.danger600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.gray100, // light red background
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Minus Button
                                  // Minus Button
                                  InkWell(
                                    onTap: () {
                                      if (item["quantity"] > 1) {
                                        setState(() {
                                          item["quantity"]--;
                                        });
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: item["quantity"] > 1 ? AppColors.gray600 : AppColors.gray300,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  // Quantity Text
                                  Text(
                                    "${item["quantity"]}",
                                    style: textTheme.bodyMedium,
                                  ),

                                  const SizedBox(width: 12),

                                  // Plus Button
                                  InkWell(
                                    onTap:() {
                                      setState(() {
                                        item["quantity"]++;
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: const BoxDecoration(
                                        color: AppColors.danger950, // solid red
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            /// ➖ Quantity ➕
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: const EdgeInsets.only(bottom: 100),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// 🧾 Total
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total :", style: textTheme.bodySmall),
                    Row(
                      children: [
                        Text(
                          "\$${total.toStringAsFixed(1)}",
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "\$${oldTotal.toStringAsFixed(1)}",
                          style: textTheme.bodySmall?.copyWith(
                            color:AppColors.danger600,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: AppColors.danger600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                /// 🔴 Checkout Button
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const CheckoutScreen(),
                        transition: Transition.rightToLeftWithFade,
                        duration: const Duration(milliseconds: 800));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text("Checkout",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          )
        ],
      );})
    );
  }
}
