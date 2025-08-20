import 'package:flutter/material.dart';
import '../../../data/models/food_data_model.dart';
import '../../food_detail/view/food_details_screen.dart';


class FoodCard extends StatelessWidget {
  final FoodCardData data;
  final EdgeInsetsGeometry? margin;
  const FoodCard({super.key, required this.data, this.margin});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    // Detect theme
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FoodDetailScreen(data: data),
          ),
        );
      },
      child: Container(
        width: width * 0.45,
        margin: margin,
        decoration: BoxDecoration(
          color: isDark ? Colors.black : Colors.white,   // ✅ Container color
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.white.withOpacity(0.1) // ✅ White shadow in dark
                  : Colors.black.withOpacity(0.05), // ✅ Black shadow in light
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: width * 0.3,
              margin: EdgeInsets.all(width * 0.01),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/rrr-removebg-preview.png"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.red, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "${data.rating} (${data.reviews} reviews)",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        "\$${data.price}",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "\$${data.oldPrice}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
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
