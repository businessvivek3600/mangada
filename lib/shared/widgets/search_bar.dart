


import 'package:flutter/material.dart';
import 'package:madhang/core/constants/colors..dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return  Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        decoration: BoxDecoration(
          color: isDark ? AppColors.gray800 : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            SizedBox(width: size.width * 0.02),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search food",
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.tune, color: Colors.red),
              onPressed: () {},
            ),
          ],
        ),

    );
  }
}