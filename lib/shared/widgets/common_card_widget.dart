import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madhang/core/constants/colors..dart';
import 'package:madhang/routes/route_name.dart';
import '../../../core/data/models/food_data_model.dart';
import '../../presentation/resturants/view/restaurant_details_screen.dart';


class HorizontalCard extends StatelessWidget {
  final FoodCardData data;
  final EdgeInsetsGeometry? margin;
  const HorizontalCard({super.key, required this.data, this.margin});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    // Detect theme
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.foodDetail, extra: data);
      },
      child: Container(
        width: width * 0.45,
        margin: margin,
        decoration: BoxDecoration(
          color: isDark ? Colors.black : Colors.white, // ✅ Container color
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color:
                  isDark
                      ? Colors.white.withOpacity(0.1) // ✅ White shadow in dark
                      : Colors.black.withOpacity(
                        0.05,
                      ), // ✅ Black shadow in light
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
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600], // optional override
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.red, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "${data.rating} (${data.reviews} reviews)",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        "\$${data.price}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color:
                              AppColors.primary900, // ✅ Primary color for price
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "\$${data.oldPrice}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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

class HorizontalCard2 extends StatelessWidget {
  final FoodCardData data;
  final EdgeInsetsGeometry? margin;
  const HorizontalCard2({super.key, required this.data, this.margin});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.foodDetail, extra: data);
      },
      child: Container(
        width: width * 0.63,
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🖼 Image Header
            Container(
              height: width * 0.28,
              margin: EdgeInsets.all(width * 0.01),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                color: Colors.grey[200],
                image: const DecorationImage(
                  image: AssetImage("assets/images/restaurant.png"),
                ),
              ),
            ),

            /// Info Section
            Padding(
              padding: EdgeInsets.all(width * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 📍 Location Row
                  Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.red, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        "Bali, Indonesia",
                        style: Theme.of(context).textTheme.labelSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 14,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "247 m",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  /// 🍽 Title
                  Text(
                    data.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  /// ⭐ Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.red, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        "${data.rating} (${data.reviews} review)",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
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

class VerticalCard extends StatelessWidget {
  final FoodCardData data;
  final EdgeInsetsGeometry? margin;

  const VerticalCard({super.key, required this.data, this.margin});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final name = data.title;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => RestaurantDetailScreen(
                  menuItems: data,
                  restaurantName: name.toString(),
                ),
          ),
        );
      },
      child: Container(
        margin:
            margin ??
            EdgeInsets.symmetric(
              vertical: width * 0.015,
              horizontal: width * 0.04,
            ),
        padding: EdgeInsets.all(width * 0.025),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            /// 🖼 Image on left
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: width * 0.22,
                height: width * 0.22,
                color: Colors.grey[200],
                child: const Image(
                  image: AssetImage("assets/images/restaurant.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),

            /// Info Section on right
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 📍 Location Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.favorite, color: Colors.red, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        "Bali, Indonesia",
                        style: Theme.of(context).textTheme.labelSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 14,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "247 m",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  /// 🍽 Title
                  Text(
                    data.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),

                  /// ⭐ Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.red, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        "${data.rating} (${data.reviews} review)",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
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

class VerticalCard2 extends StatefulWidget {
  final FoodCardData data;
  final EdgeInsetsGeometry? margin;

  const VerticalCard2({super.key, required this.data, this.margin});

  @override
  State<VerticalCard2> createState() => _VerticalCard2State();
}

class _VerticalCard2State extends State<VerticalCard2> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    final food = widget.data;

    return Container(
      margin:
          widget.margin ??
          EdgeInsets.symmetric(
            vertical: width * 0.015,
            horizontal: width * 0.04,
          ),
      padding: EdgeInsets.all(width * 0.025),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          /// 🖼 Food image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: width * 0.22,
              height: width * 0.22,
              color: Colors.grey[200],
              child: const Image(
                image: NetworkImage(
                  "https://lunabeachclubbali.com/wp-content/uploads/2023/12/luna-beach-club-restaurant-1.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),

          /// Info Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text("${123} sold", style: textTheme.bodySmall),
                const SizedBox(height: 4),

                /// Price + Old price
                Row(
                  children: [
                    Text(
                      "\$${food.price}",
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "\$${food.oldPrice}",
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.danger600,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: AppColors.danger600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// Action section (+ Add / Counter)
          quantity == 0
              ? SizedBox(
            height: 32,
            child: OutlinedButton(
              onPressed: () => setState(() => quantity = 1),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  width: 0.7,
                  color: Colors.grey, // border color
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 18,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Add",
                    style: textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          )
              : Container(
            padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.gray100, // light red background
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
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: AppColors.gray300, // lighter red
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
                      quantity.toString(),
                      style: textTheme.bodyMedium,
                    ),

                    const SizedBox(width: 12),

                    // Plus Button
                    InkWell(
                      onTap: () => setState(() => quantity++),
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
        ],
      ),
    );
  }


}
