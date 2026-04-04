import 'package:flutter/material.dart';

import '../../l10n/app_strings.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({
    super.key,
    required this.strings,
    required this.currentIndex,
    required this.onTap,
  });

  final AppStrings strings;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItemData(
        icon: Icons.home_rounded,
        label: strings.navHome,
      ),
      _NavItemData(
        icon: Icons.bar_chart_rounded,
        label: strings.navLeagues,
      ),
      _NavItemData(
        icon: Icons.shopping_bag_rounded,
        label: strings.navShop,
      ),
      _NavItemData(
        icon: Icons.settings_rounded,
        label: strings.navSettings,
      ),
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: List.generate(
          items.length,
          (index) {
            final item = items[index];
            final isSelected = index == currentIndex;

            return Expanded(
              child: GestureDetector(
                onTap: () => onTap(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFE7FFF2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        color: isSelected
                            ? const Color(0xFF20A86B)
                            : const Color(0xFF9EA8B9),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: isSelected
                              ? const Color(0xFF20A86B)
                              : const Color(0xFF9EA8B9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}
