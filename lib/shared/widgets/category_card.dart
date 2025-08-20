


import 'package:flutter/material.dart';

import '../../core/constants/colors..dart';



class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  const CategoryCard(
      {super.key,
        required this.icon,
        required this.label,
        this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: width * 0.04,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary900 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              color: isSelected ? Colors.white : Colors.black,
              size: width * 0.08),
          SizedBox(height: width * 0.02),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}