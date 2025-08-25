import 'package:flutter/material.dart';

import '../../../core/data/models/food_data_model.dart';
import '../../../shared/widgets/category_card.dart';
import '../../category/view/category_screen.dart';


class CategoryList extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  const CategoryList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.11,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: size.width * 0.03),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryScreen(
                    categoryTitle: cat["label"],
                    items: [
                      FoodCardData(
                        title: "Nasi Rames",
                        subtitle: "Resto Mbok Ijah",
                        price: 2.0,
                        oldPrice: 3.0,
                        rating: 4.9,
                        reviews: 115,
                      ),
                      FoodCardData(
                        title: "Nasi Liwet",
                        subtitle: "Resto Mbok Ijah",
                        price: 3.0,
                        oldPrice: 5.0,
                        rating: 4.9,
                        reviews: 115,
                      ),
                      FoodCardData(
                        title: "Nasi Pecel Lele",
                        subtitle: "Resto Idola",
                        price: 2.0,
                        oldPrice: 3.0,
                        rating: 4.9,
                        reviews: 115,
                      ),
                      FoodCardData(
                        title: "Nasi Bebek Carok",
                        subtitle: "Carok",
                        price: 4.0,
                        oldPrice: 5.0,
                        rating: 4.9,
                        reviews: 115,
                      ),
                    ],
                  ),
                ),
              );
            },
            child: CategoryCard(
              icon: cat["icon"],
              label: cat["label"],
              isSelected: index == 0,
            ),
          );
        },
      ),
    );
  }
}
