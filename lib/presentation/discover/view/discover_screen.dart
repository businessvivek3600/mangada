import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:video_player/video_player.dart';
import '../../../core/constants/colors..dart';
import '../../../core/data/models/food_data_model.dart';

import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/horizontal_list_section.dart';
import '../../../shared/widgets/search_bar.dart';
import '../../resturants/view/restaurants_list_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final List<Map<String, String>> banners = [
    {"type": "image", "path": "assets/images/banner1.png"},
    {"type": "image", "path": "assets/images/banner2.png"},
    {"type": "image", "path": "assets/images/banner3.png"},
    {"type": "gif", "path": "assets/gif/1666098039939.gif"},
    {"type": "video", "path": "assets/video/1104284249-preview.mp4"},
  ];

  final Random random = Random();
  int randomStart = 0;

  @override
  void initState() {
    super.initState();
    // start carousel from random index
    randomStart = random.nextInt(banners.length);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.06),

          /// 🔍 Search Bar
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: 3,
            ),
            child: const SearchBarWidget(),
          ),

          /// 🎥 Banner Carousel
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.01),

                  /// 🔄 Carousel
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    width: double.infinity,
                    height: size.height * 0.25,
                    child: CarouselSlider.builder(
                      options: CarouselOptions(
                        height: size.height * 0.25,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 4),
                        initialPage: randomStart,
                        enlargeCenterPage: false,
                      ),
                      itemCount: banners.length,
                      itemBuilder: (context, index, realIdx) {
                        final banner = banners[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BannerWidget(banner: banner),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: size.height * 0.01),

                  /// ⭐ Top Rated Food
                  SectionHeader(title: "Top Rated Food", onSeeMore: () {}),
                  HorizontalListSection(items: items),

                  /// 🍽 Restaurants
                  SectionHeader(title: "Restaurants", onSeeMore: () {
                    Get.to(()=> const RestaurantsListScreen(),
                        transition: Transition.rightToLeftWithFade,
                        duration: const Duration(milliseconds: 800));
                  }),
                  HorizontalListSection(items: items,useNewDesign: true,),

                  SizedBox(height: size.height * 0.12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}

/// 🔹 Widget to handle Image, GIF, or Video safely
class BannerWidget extends StatefulWidget {
  final Map<String, String> banner;
  const BannerWidget({super.key, required this.banner});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  VideoPlayerController? _videoController;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    if (widget.banner["type"] == "video") {
      _videoController = VideoPlayerController.asset(widget.banner["path"]!)
        ..initialize().then((_) {
          if (mounted) {
            setState(() {});
            _videoController?.play();
            _videoController?.setLooping(true);
          }
        }).catchError((e) {
          setState(() => _hasError = true);
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(color: Colors.grey.shade300); // hide on error
    }

    switch (widget.banner["type"]) {
      case "image":
      case "gif":
        return Image.asset(
          widget.banner["path"]!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              Container(color: Colors.grey.shade300),
        );
      case "video":
        if (_videoController != null &&
            _videoController!.value.isInitialized) {
          return VideoPlayer(_videoController!);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      default:
        return const SizedBox();
    }
  }
}
