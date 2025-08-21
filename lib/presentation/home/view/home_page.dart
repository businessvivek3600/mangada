import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:madhang/core/constants/colors..dart';
import '../../../data/models/food_data_model.dart';
import '../../../shared/widgets/horizontal_list_section.dart';
import '../../../shared/widgets/section_header.dart';
import '../widgets/category_list.dart';
import '../widgets/custom_sliver_appbar.dart';
import '../../../shared/widgets/search_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _currentLocation = "Loading...";

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (!mounted) return;

      if (placemarks.isNotEmpty) {
        setState(() {
          _currentLocation =
              "${placemarks.first.locality}, ${placemarks.first.country}";
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _currentLocation = "Location unavailable";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          /// Collapsible AppBar
          CustomSliverAppBar(location: _currentLocation),
          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.01)),

          /// Search Bar
          SliverToBoxAdapter(child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
            ),
            child: SearchBarWidget(),
          )),
          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.01)),
          /// Categories
          SliverToBoxAdapter(
            child: CategoryList(
              categories: const [
                {"icon": Icons.rice_bowl, "label": "Rice"},
                {"icon": Icons.fastfood, "label": "Snacks"},
                {"icon": Icons.local_drink, "label": "Drinks"},
                {"icon": Icons.more_horiz, "label": "More"},
              ],
            ),
          ),

          /// Recommended
          SliverToBoxAdapter(
            child: SectionHeader(title: "Recommended For You"),
          ),
          SliverToBoxAdapter(
            child: HorizontalListSection(
              items: items,
            ),
          ),

          /// Near You
          SliverToBoxAdapter(child: SectionHeader(title: "Near You")),
          SliverToBoxAdapter(
            child: HorizontalListSection(
              items: items,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.01)),
        ],
      ),
    );
  }
}
