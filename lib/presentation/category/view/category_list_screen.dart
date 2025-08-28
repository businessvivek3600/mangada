import 'package:flutter/material.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  final List<Map<String, dynamic>> categories = const [
    {"icon": Icons.rice_bowl, "label": "Rice"},
    {"icon": Icons.fastfood, "label": "Snacks"},
    {"icon": Icons.local_drink, "label": "Drinks"},
    {"icon": Icons.local_pizza, "label": "Pizza"},
    {"icon": Icons.cake, "label": "Desserts"},
    {"icon": Icons.soup_kitchen, "label": "Soups"},
    {"icon": Icons.set_meal, "label": "Meals"},
    {"icon": Icons.emoji_food_beverage, "label": "Beverages"},
    {"icon": Icons.breakfast_dining, "label": "Breakfast"},
    {"icon": Icons.lunch_dining, "label": "Lunch"},
    {"icon": Icons.dinner_dining, "label": "Dinner"},
    {"icon": Icons.more, "label": "Others"},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Categories"),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Clicked ${category['label']}")),
              );
            },
            child: Material(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.02),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(category["icon"], size: 40, color: theme.colorScheme.primary),
                    const SizedBox(height: 8),
                    Text(
                      category["label"],
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
