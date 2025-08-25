
import 'package:flutter/material.dart';
import '../../../core/data/models/food_data_model.dart';

import '../../../shared/widgets/common_card_widget.dart';
import '../../../shared/widgets/search_bar.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryTitle;
  final List<FoodCardData> items;

  const CategoryScreen({
    super.key,
    required this.categoryTitle,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading:BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.05),
            SearchBarWidget(),
            Expanded(
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // two columns
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.7, // control card height
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return HorizontalCard(data: item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
