import 'package:flutter/material.dart';

import '../../data/home_categories.dart';
import '../../l10n/app_strings.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({
    super.key,
    required this.strings,
  });

  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                strings.categoriesTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF26354E),
                ),
              ),
            ),
            Text(
              strings.seeAll,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF20A8B2),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeCategories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final category = homeCategories[index];

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: category.color.withValues(alpha: 0.14),
                    ),
                    child: Icon(
                      category.icon,
                      color: category.color,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    strings.categoryLabel(category.labelKey),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF50607A),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
