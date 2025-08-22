import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/colors..dart';

class FoodOrderDetails extends StatefulWidget {
  const FoodOrderDetails({Key? key}) : super(key: key);

  @override
  State<FoodOrderDetails> createState() => _FoodOrderDetailsState();
}

class _FoodOrderDetailsState extends State<FoodOrderDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

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
          "Detail Food Order",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          /// 🔹 Fixed Map/Header
          Container(
            width: double.infinity,
            height: size.height * 0.35, // fixed height for map

            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/map.png",
                ), // replace with actual map image
                fit: BoxFit.cover,
              ),
              color: Colors.grey[300],
            ),
          ),

          /// 🔹 Draggable Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.65, // start just below 300px
            minChildSize: 0.65, // collapsed
            maxChildSize: 0.65, // expanded
            builder: (context, controller) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  controller: controller,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// drag handle
                      Center(
                        child: Container(
                          width: 32,
                          height: 1.5,
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: AppColors.gray200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      /// 🔹 Status timeline
                      /// 🔹 Status timeline
                      Text("Status", style: textTheme.titleMedium),
                      const SizedBox(height: 12),

                      Column(
                        children: [
                          ...[
                            OrderStatus(
                              date: "10 October 2024 | 14:26 WIB",
                              title: "Order has been received and processed",
                              active: true,
                            ),
                            OrderStatus(
                              date: "10 October 2024 | 03:20 WIB",
                              title: "Order is being packed",
                            ),
                            OrderStatus(
                              date: "10 October 2024 | 05:30 WIB",
                              title: "Order delivered",
                            ),
                            OrderStatus(
                              date: "10 October 2024 | 08:12 WIB",
                              title: "Order received",
                            ),
                          ].asMap().entries.map((entry) {
                            final index = entry.key;
                            final s = entry.value;
                            return _StatusStep(
                              active: s.active,
                              date: s.date,
                              title: s.title,
                              isLast: index == 3, // 👈 mark last step
                            );
                          }),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// 🔹 Order Info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Date", style: textTheme.bodySmall),
                          Text(
                            "10/10/2024 | 11:07AM",
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Invoice", style: textTheme.bodySmall),
                          Text("INV/MDG/0934582", style: textTheme.bodyMedium),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Payment Method", style: textTheme.bodySmall),
                          Text("BANK TRANSFER", style: textTheme.bodyMedium),
                        ],
                      ),
                      const Divider(height: 32),

                      /// 🔹 Driver Info
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: AppColors.danger600,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Driver", style: textTheme.bodySmall),
                              Text("David Nguyen", style: textTheme.bodyMedium),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      /// 🔹 Delivery Address
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.gray200),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Address",
                              style: textTheme.bodySmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "House | Josephin | (+0) 123 456 789\n"
                              "424 Kansas Ave, Brewster, KS 67732, United States",
                              style: textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 12),
                            OutlinedButton(
                              onPressed: () {},
                              child: const Text("Change Delivery Address"),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// 🔹 Items
                      Text("Items", style: textTheme.titleMedium),
                      const SizedBox(height: 12),
                      _OrderItem(name: "Gudeg", price: 4, oldPrice: 5, qty: 2),
                      _OrderItem(
                        name: "Nasi Liwet",
                        price: 3,
                        oldPrice: 5,
                        qty: 1,
                      ),
                      const Divider(height: 32),

                      /// 🔹 Totals
                      _RowText(label: "Sub-total", value: "\$15.0"),
                      _RowText(label: "Discount Voucher", value: "- \$4.0"),
                      _RowText(label: "Fee", value: "\$0.25"),
                      const SizedBox(height: 8),
                      _RowText(
                        label: "Total",
                        value: "\$11.25",
                        bold: true,
                        color: AppColors.primary900,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatusStep extends StatelessWidget {
  final bool active;
  final String date;
  final String title;
  final bool isLast; // 👈 add this

  const _StatusStep({
    Key? key,
    required this.active,
    required this.date,
    required this.title,
    this.isLast = false, // 👈 default false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Timeline (circle + line)
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? Colors.white : AppColors.gray200,
                border: Border.all(
                  color: active ? AppColors.primary600 : AppColors.gray300,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.image,
                size: 18,
                color: active ? AppColors.primary600 : AppColors.gray400,
              ),
            ),

            /// 👇 Only show line if not last
            if (!isLast)
              Container(width: 2, height: 50, color: AppColors.gray300),
          ],
        ),
        const SizedBox(width: 12),

        /// Texts
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: textTheme.bodySmall?.copyWith(color: AppColors.gray500),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                  color: active ? AppColors.primary900 : AppColors.gray700,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}

class _OrderItem extends StatelessWidget {
  final String name;
  final int qty;
  final double price;
  final double? oldPrice;

  const _OrderItem({
    Key? key,
    required this.name,
    required this.qty,
    required this.price,
    this.oldPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Name & qty
          Text("$qty × $name", style: textTheme.bodyMedium),

          /// Price
          Row(
            children: [
              if (oldPrice != null)
                Text(
                  "\$$oldPrice",
                  style: textTheme.bodySmall?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.gray400,
                  ),
                ),
              const SizedBox(width: 6),
              Text(
                "\$${(qty * price).toStringAsFixed(2)}",
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RowText extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  final Color? color;

  const _RowText({
    Key? key,
    required this.label,
    required this.value,
    this.bold = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
              color: color ?? AppColors.gray600,
            ),
          ),
          Text(
            value,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
              color: color ?? AppColors.gray900,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderStatus {
  final String date;
  final String title;
  final bool active;

  OrderStatus({required this.date, required this.title, this.active = false});
}
