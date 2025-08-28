import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madhang/core/constants/colors..dart';

import '../../../shared/widgets/search_bar.dart';
import 'order_details.dart';

class FoodOrderScreen extends StatelessWidget {
  const FoodOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(height: 1, color: Colors.grey.shade300),
        ),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Food Order",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔍 Search Bar + Filter
            Row(children: [Expanded(child: SearchBarWidget())]),
            const SizedBox(height: 12),

            /// Date & Status Filter
            Row(
              children: [
                Expanded(
                  child: _FilterChip(
                    label: "Date",
                    value: "10/10/2024",
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _FilterChip(
                    label: "Status",
                    value: "All",
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// Section title
            Text("Today", style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 12),

            /// Order List
            Expanded(
              child: ListView(
                children: [
                  OrderCard(
                    status: "Order is being delivered",
                    statusColor: AppColors.warning900,
                    productCount: 3,
                    price: 11.25,
                    date: "10/10/2024 | 11:07AM",
                    isCompleted: false,
                  ),
                  OrderCard(
                    status: "Completed",
                    statusColor: Colors.green,
                    productCount: 3,
                    price: 11.25,
                    date: "10/10/2024 | 11:07AM",
                    isCompleted: true,
                  ),
                  OrderCard(
                    status: "Completed",
                    statusColor: Colors.green,
                    productCount: 3,
                    price: 11.25,
                    date: "10/10/2024 | 11:07AM",
                    isCompleted: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =====================
/// Order Card Widget
/// =====================
class OrderCard extends StatelessWidget {
  final String status;
  final Color statusColor;
  final int productCount;
  final double price;
  final String date;
  final bool isCompleted;

  const OrderCard({
    super.key,
    required this.status,
    required this.statusColor,
    required this.productCount,
    required this.price,
    required this.date,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Status Chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Text(
                status,
                style: textTheme.bodySmall?.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),

            /// Order Info
            Text("${productCount}x product", style: textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text(
              "\$${price.toStringAsFixed(2)}",
              style: textTheme.titleSmall?.copyWith(fontSize: 14),
            ),

            const Divider(height: 20),

            /// Date + Detail
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order: $date", style: textTheme.bodyMedium),
                GestureDetector(
                  onTap: () {
                    Get.to(()=> const FoodOrderDetails(),
                      );
                  },
                  child: Row(
                    children: [
                      Text(
                        "Detail",
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary900,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: AppColors.primary900,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// =====================
/// FilterChip (Date/Status)
/// =====================
class _FilterChip extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray200, width: 0.7),
          borderRadius: BorderRadius.circular(36),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side (label + value stacked)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.labelSmall),
                Text(value, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),

            // Right side (arrow)
            const Icon(Icons.keyboard_arrow_down, size: 24),
          ],
        ),
      ),
    );
  }
}
