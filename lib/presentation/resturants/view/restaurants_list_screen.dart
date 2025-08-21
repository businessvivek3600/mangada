import 'package:flutter/material.dart';
import 'package:madhang/shared/widgets/vertical_list_section.dart';

import '../../../data/models/food_data_model.dart';
import '../../../shared/widgets/horizontal_list_section.dart';
import '../../../shared/widgets/search_bar.dart';
import '../../../shared/widgets/section_header.dart';

class RestaurantsListScreen extends StatefulWidget {
  const RestaurantsListScreen({super.key});

  @override
  State<RestaurantsListScreen> createState() => _RestaurantsListScreenState();
}

class _RestaurantsListScreenState extends State<RestaurantsListScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text("Restaurants", style: textTheme.titleLarge),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔍 Search Bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: 3,
              ),
              child: const SearchBarWidget(),
            ),
            SectionHeader(title: "Near You", onSeeMore: () {}),
            HorizontalListSection(items: items,useNewDesign: true,),
            SizedBox(height: 10,),
            SectionHeader(title: "All Restaurants", showSeeMore: false,),
            VerticalListSection(items: items),
          ],
        ),
      ),
    );
  }
}
