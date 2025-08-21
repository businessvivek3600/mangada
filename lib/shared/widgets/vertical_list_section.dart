
import 'package:flutter/material.dart';
import 'package:madhang/shared/widgets/common_card_widget.dart';
import '../../data/models/food_data_model.dart';

class VerticalListSection extends StatelessWidget {
  final List<FoodCardData> items;
  final bool useNewDesign;
  const VerticalListSection({
    super.key,
    required this.items,
    this.useNewDesign = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // ✅ Let parent scroll
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return  useNewDesign ? VerticalCard2(
          data: items[index],
          margin: EdgeInsets.only(
            bottom: size.height * 0.015,
          ),
        ): VerticalCard(
          data: items[index],
          margin: EdgeInsets.only(
            bottom: size.height * 0.015,
          ),
        );
      },
    );
  }
}
