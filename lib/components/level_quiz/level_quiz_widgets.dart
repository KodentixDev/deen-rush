import 'package:flutter/material.dart';

class QuizOptionTile extends StatelessWidget {
  const QuizOptionTile({
    super.key,
    required this.index,
    required this.label,
    required this.isSelected,
    required this.isCorrect,
    required this.showResult,
    required this.onTap,
  });

  final int index;
  final String label;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isSelectedWrong = showResult && isSelected && !isCorrect;
    final backgroundColor = isCorrect && showResult
        ? (isDark ? const Color(0xFF2A3D18) : const Color(0xFFE6F9BF))
        : isSelectedWrong
            ? (isDark ? const Color(0xFF133542) : const Color(0xFFD7F5F7))
            : theme.colorScheme.surface;
    final borderColor = isCorrect && showResult
        ? const Color(0xFFB4DD37)
        : isSelectedWrong
            ? const Color(0xFF1CB6C3)
            : theme.colorScheme.outlineVariant;
    final badgeColor = isCorrect && showResult
        ? const Color(0xFFC8F24C)
        : isSelectedWrong
            ? const Color(0xFF1CB6C3).withValues(alpha: 0.22)
            : theme.colorScheme.surfaceContainerHighest;
    final badgeTextColor = isCorrect && showResult
        ? const Color(0xFF4C6400)
        : isSelectedWrong
            ? const Color(0xFF1CB6C3)
            : theme.colorScheme.onSurfaceVariant;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: borderColor,
              width: showResult && (isCorrect || isSelectedWrong) ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: badgeColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  String.fromCharCode(65 + index),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: badgeTextColor,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
