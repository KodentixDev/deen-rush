import 'package:flutter/material.dart';

class BattleProfile {
  const BattleProfile(
    this.name,
    this.levelLabel,
    this.strength,
    this.avatarColor,
    this.accent,
  );

  final String name;
  final String levelLabel;
  final int strength;
  final Color avatarColor;
  final Color accent;
}
