
import 'package:flutter/material.dart';

import '../../../core/constants/colors..dart';

class CustomSliverAppBar extends StatelessWidget {
  final String location;
  const CustomSliverAppBar({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      pinned: true,
      expandedHeight: size.height * 0.31,
      backgroundColor: AppColors.primary900,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white),
              SizedBox(width: size.width * 0.01),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: Colors.red[900],
                  value: location,
                  icon: const Icon(Icons.keyboard_arrow_down,
                      color: Colors.white),
                  items: [
                    DropdownMenuItem(
                      value: location,
                      child: Text(location,
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ],
                  onChanged: (_) {},
                ),
              ),
            ],
          ),
          const Icon(Icons.notifications_none, color: Colors.white),
        ],
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, AppColors.primary900],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  "assets/images/rrr-removebg-preview.png",
                  fit: BoxFit.contain,
                  height: size.height * 0.23,
                  width: size.width * 0.45,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.12,
                  left: size.width * 0.04,
                  right: size.width * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Grab Our\nExclusive Food\nDiscounts Now!",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: size.width * 0.07,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColors.warning900,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.06,
                              vertical: size.height * 0.015,
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Order Now",
                            style: theme.textTheme.titleSmall!.copyWith(
                              color: Colors.white,
                              fontSize: size.width * 0.035,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.all(size.width * 0.04),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Transform.rotate(
                            angle: 0.5,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Discount",
                                    style: theme.textTheme.bodySmall?.copyWith(
                                        fontSize: size.width * 0.025)),
                                Text(
                                  "35%",
                                  style: theme.textTheme.headlineMedium
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.primaryColor,
                                    fontSize: size.width * 0.07,
                                  ),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}

