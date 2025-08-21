
import 'package:flutter/material.dart';
import '../../data/models/food_data_model.dart';
import 'common_card_widget.dart';

class HorizontalListSection extends StatelessWidget {
  final List<FoodCardData> items;
  final bool useNewDesign;
  const HorizontalListSection({super.key, required this.items,this.useNewDesign = false,});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height:  useNewDesign
          ? size.width * 0.52 : size.width * 0.63 , // based on card height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: size.width * 0.04),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final margin = EdgeInsets.only(
            right: index == items.length - 1 ? 16 : 8,
          );

          return useNewDesign
              ? HorizontalCard2(data: items[index], margin: margin)
              : HorizontalCard(data: items[index], margin: margin);
        },
      ),
    );
  }
}