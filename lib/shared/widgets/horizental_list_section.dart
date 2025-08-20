
import 'package:flutter/material.dart';

import '../../data/models/food_data_model.dart';
import '../../presentation/home/widgets/food_card.dart';

class HorizontalListSection extends StatelessWidget {
  final List<FoodCardData> items;
  const HorizontalListSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.width * 0.65, // based on card height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: size.width * 0.04),
        itemCount: items.length,
        itemBuilder: (context, index) =>
            FoodCard(data: items[index], margin: EdgeInsets.only(right: size.width * 0.04)),
      ),
    );
  }
}