import 'package:flutter/material.dart';

import '../models/category_item.dart';

const homeCategories = [
  CategoryItem(
    labelKey: 'fiqh',
    icon: Icons.balance_rounded,
    color: Color(0xFF37BFA1),
  ),
  CategoryItem(
    labelKey: 'quran',
    icon: Icons.menu_book_rounded,
    color: Color(0xFF4A90FF),
  ),
  CategoryItem(
    labelKey: 'history',
    icon: Icons.account_balance_rounded,
    color: Color(0xFFFF9E4F),
  ),
  CategoryItem(
    labelKey: 'culture',
    icon: Icons.palette_rounded,
    color: Color(0xFF9A64FF),
  ),
  CategoryItem(
    labelKey: 'geography',
    icon: Icons.public_rounded,
    color: Color(0xFF29B7C8),
  ),
  CategoryItem(
    labelKey: 'mixed',
    icon: Icons.grid_view_rounded,
    color: Color(0xFFFF6464),
  ),
];
