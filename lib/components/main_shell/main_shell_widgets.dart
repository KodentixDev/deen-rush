import 'package:flutter/material.dart';

class ShellNavItem {
  const ShellNavItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

class SketchBottomNav extends StatelessWidget {
  const SketchBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<ShellNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xCC8B63FF),
        borderRadius: BorderRadius.circular(34),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40381678),
            blurRadius: 28,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Row(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == currentIndex;

          return Expanded(
            flex: isSelected ? 2 : 1,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 52,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFF6F2FF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: isSelected
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item.icon,
                            size: 20,
                            color: const Color(0xFF7A53F9),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              item.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF7A53F9),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Icon(
                        item.icon,
                        size: 22,
                        color: Colors.white.withValues(alpha: 0.88),
                      ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
