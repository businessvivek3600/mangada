import 'package:flutter/material.dart';
import 'package:madhang/core/constants/colors..dart';
import '../../../data/models/food_data_model.dart';
import '../../../shared/widgets/vertical_list_section.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String restaurantName;
  final FoodCardData menuItems;

  const RestaurantDetailScreen({
    super.key,
    required this.restaurantName,
    required this.menuItems,
  });

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  String selectedCategory = "All Menu";

  final List<String> categories = [
    "All Menu",
    "Rice",
    "Drinks",
    "Snacks",
    "Bundle",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text("Detail Restaurant", style: textTheme.titleLarge),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🖼 Restaurant Image
            Container(
              width: double.infinity,
              height: size.height * 0.25,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://baliuntold.com/wp-content/uploads/2024/06/Merlins-Ubud-restaurant.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            SizedBox(height: size.height * 0.01),

            /// 🏬 Restaurant Info
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.flash_on,
                        color: AppColors.warning900,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Available on fast delivery",
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.restaurantName,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 16,
                        color: AppColors.primary900,
                      ),
                      const SizedBox(width: 4),
                      Text("Bali, Indonesia", style: textTheme.bodyMedium),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: AppColors.primary900,
                      ),
                      const SizedBox(width: 4),
                      Text("247,5 m", style: textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.star, color: AppColors.primary900, size: 18),
                      const SizedBox(width: 4),
                      Text("4.9 (999+ review)", style: textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// 🍴 Categories
            SizedBox(
              height: 32,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == selectedCategory;
                  return GestureDetector(
                    onTap: () => setState(() => selectedCategory = category),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.warning950 : Colors.white,
                        border:
                            isSelected
                                ? null
                                : Border.all(
                                  width: 0.7,
                                  color: Colors.grey, // border color
                                ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category,
                        style: textTheme.bodySmall?.copyWith(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            /// 📋 Food List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Text(
                "All Restaurants",
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),

            VerticalListSection(items: items, useNewDesign: true),
            SizedBox(height: size.height * 0.06),
          ],
        ),
      ),

      /// 🛒 Bottom Bar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            /// 🔹 Quantity Control (like your design)
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 0.7),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 26,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                  ),

                  /// 🔴 Badge
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "1", // dynamic cart count
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
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
                onPressed: () {},
                child: Text(
                  "Add to Cart",
                  style: textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
