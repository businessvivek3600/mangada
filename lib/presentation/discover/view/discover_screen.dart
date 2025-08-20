import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors..dart';


class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔍 Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.gray300),
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.gray600),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Nasi Padang",
                          hintStyle: textTheme.bodyMedium?.copyWith(
                            color: AppColors.gray500,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Icon(Icons.tune, color: AppColors.primary900),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              /// 🔴 Promo Banner
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary900,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order your favorite food!",
                      style: textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Container(
                        width: 200,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(child: Text("Image placeholder")),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Claim discount up to 40%",
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),

              /// ⭐ Top Rated Food
              _SectionHeader(title: "Top Rated Food", onTap: () {}),
              const SizedBox(height: 12),
              SizedBox(
                height: 210,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, index) => _FoodCard(
                    title: "Sate Padang",
                    subtitle: "Sate Pak Maman",
                    price: 2.0,
                    oldPrice: 3.0,
                    rating: 4.9,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// 🍴 Restaurants
              _SectionHeader(title: "Restaurants", onTap: () {}),
              const SizedBox(height: 12),
              SizedBox(
                height: 210,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, index) => _RestaurantCard(
                    name: "Warung Mak Beng",
                    location: "Bali, Indonesia",
                    distance: "247.5 m",
                    rating: 4.9,
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

/// 🔹 Section Header with "See more"
class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const _SectionHeader({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: onTap,
          child: Text(
            "See more",
            style: textTheme.bodyMedium?.copyWith(color: AppColors.primary900),
          ),
        ),
      ],
    );
  }
}

/// 🔹 Food Card
class _FoodCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final double oldPrice;
  final double rating;

  const _FoodCard({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.oldPrice,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.gray200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text("Image placeholder")),
            ),
          ),
          const SizedBox(height: 8),
          Text(title, style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(subtitle, style: textTheme.bodySmall?.copyWith(color: AppColors.gray600)),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, size: 14, color: AppColors.primary900),
              const SizedBox(width: 4),
              Text("$rating", style: textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                "\$$price",
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "\$$oldPrice",
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.gray500,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 🔹 Restaurant Card
class _RestaurantCard extends StatelessWidget {
  final String name;
  final String location;
  final String distance;
  final double rating;

  const _RestaurantCard({
    required this.name,
    required this.location,
    required this.distance,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.gray200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text("Image placeholder")),
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(Icons.location_on, size: 14, color: AppColors.primary900),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  "$location • $distance",
                  style: textTheme.bodySmall?.copyWith(color: AppColors.gray600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, size: 14, color: AppColors.primary900),
              const SizedBox(width: 4),
              Text("$rating", style: textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
