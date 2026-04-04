import 'package:flutter/material.dart';

class CategoryItem {
  const CategoryItem({
    required this.labelKey,
    required this.icon,
    required this.color,
  });

  final String labelKey;
  final IconData icon;
  final Color color;
}
