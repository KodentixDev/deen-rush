import 'package:flutter/material.dart';

import '../../data/quiz_catalog.dart';

class DuelAdventureItem {
  const DuelAdventureItem({
    required this.category,
    required this.level,
    required this.progress,
    required this.color,
    required this.accent,
    required this.titleColor,
    required this.icon,
    required this.pattern,
    required this.tilt,
  });

  final QuizCategory category;
  final String level;
  final double progress;
  final Color color;
  final Color accent;
  final Color titleColor;
  final IconData icon;
  final DuelCardPattern pattern;
  final double tilt;
}

enum DuelCardPattern {
  none,
  dots,
  stripes,
}

extension DuelQuizCategoryCopy on QuizCategory {
  QuizCategory copyAs({
    String? id,
    String? labelKey,
    IconData? icon,
    Color? color,
  }) {
    return QuizCategory(
      id: id ?? this.id,
      labelKey: labelKey ?? this.labelKey,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      levels: levels,
    );
  }
}
