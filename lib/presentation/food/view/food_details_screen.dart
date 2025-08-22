import 'package:flutter/material.dart';
import '../../../core/constants/colors..dart';
import '../../../data/models/food_data_model.dart';


class FoodDetailScreen extends StatefulWidget {
  final FoodCardData data;

  const FoodDetailScreen({super.key, required this.data});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  String selectedVariant = "Regular"; // default variant
  int quantity = 1;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text("Food Details", style: textTheme.titleLarge),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Top image
            Center(
              child: Image.network(
                "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg"
                    "?cs=srgb&dl=pexels-ella-olsson-572949-1640777.jpg&fm=jpg",
              ),
            ),

            /// 🔹 Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title & Like
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.restaurant,
                                  color: AppColors.primary900, size: 18),
                              const SizedBox(width: 6),
                              Text(widget.data.subtitle,
                                  style: textTheme.bodyMedium),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(widget.data.title, style: textTheme.headlineMedium),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border,
                            color: AppColors.danger700),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// Rating
                  Row(
                    children: [
                      const Icon(Icons.star,
                          color: AppColors.warning800, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.data.rating} (${widget.data.reviews} reviews)",
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  /// Price
                  Row(
                    children: [
                      Text(
                        "\$${widget.data.price}",
                        style: textTheme.titleLarge?.copyWith(
                          color: AppColors.primary900,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "\$${widget.data.oldPrice}",
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.gray400,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.flash_on,
                          color: AppColors.warning700, size: 20),
                      const SizedBox(width: 4),
                      Text("Available on fast delivery",
                          style: textTheme.bodySmall),
                    ],
                  ),
                  const SizedBox(height: 16),

                  /// Description
                  AnimatedCrossFade(
                    firstChild: Text(
                      "Nasi Rames Sed ut perspiciatis unde omnis iste natus error sit voluptatem "
                          "accusantium doloremque laudantium, totam rem aperiam...",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium,
                    ),
                    secondChild: Text(
                      "Nasi Rames Sed ut perspiciatis unde omnis iste natus error sit voluptatem "
                          "accusantium doloremque laudantium, totam rem aperiam...",
                      style: textTheme.bodyMedium,
                    ),
                    crossFadeState: isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                  const SizedBox(height: 8),

                  GestureDetector(
                    onTap: () => setState(() => isExpanded = !isExpanded),
                    child: Text(
                      isExpanded ? "Read less" : "Read more",
                      style: textTheme.labelLarge?.copyWith(
                        color: AppColors.primary900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Variants
                  Text("Choose a Variant",
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),

                  Column(
                    children: [
                      RadioListTile<String>(
                        activeColor: AppColors.primary900,
                        title: Text("Regular", style: textTheme.bodyMedium),
                        value: "Regular",
                        groupValue: selectedVariant,
                        onChanged: (val) =>
                            setState(() => selectedVariant = val!),
                      ),
                      RadioListTile<String>(
                        activeColor: AppColors.primary900,
                        title: Text("Medium (+\$2)", style: textTheme.bodyMedium),
                        value: "Medium",
                        groupValue: selectedVariant,
                        onChanged: (val) =>
                            setState(() => selectedVariant = val!),
                      ),
                      RadioListTile<String>(
                        activeColor: AppColors.primary900,
                        title: Text("Large (+\$4)", style: textTheme.bodyMedium),
                        value: "Large",
                        groupValue: selectedVariant,
                        onChanged: (val) =>
                            setState(() => selectedVariant = val!),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      /// 🔹 Bottom bar fixed
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              /// 🔹 Quantity Control (like your design)
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.danger100, // light red background
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Minus Button
                      InkWell(
                        onTap: () {
                          if (quantity > 1) {
                            setState(() => quantity--);
                          }
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.danger400, // lighter red
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.remove,
                              color: Colors.white, size: 20),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Quantity Text
                      Text(
                        quantity.toString(),
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.danger700,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Plus Button
                      InkWell(
                        onTap: () => setState(() => quantity++),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: AppColors.danger950, // solid red
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),

              /// 🔹 Add to Cart button
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary900,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36),
                    ),
                  ),
                  onPressed: () {
                    debugPrint(
                        "Added ${widget.data.title} - $selectedVariant x$quantity to Cart");
                  },
                  child: Text(
                    "Add to Cart",
                    style: textTheme.titleMedium?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
