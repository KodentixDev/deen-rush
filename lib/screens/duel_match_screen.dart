import 'dart:async';

import 'package:flutter/material.dart';

import '../config/app_assets.dart';
import '../data/quiz_catalog.dart';
import '../l10n/app_strings.dart';
import '../models/battle_profile.dart';
import 'duel_quiz_screen.dart';

class DuelMatchScreen extends StatefulWidget {
  const DuelMatchScreen({
    super.key,
    required this.category,
    required this.levelLabel,
    required this.accentColor,
  });

  final QuizCategory category;
  final String levelLabel;
  final Color accentColor;

  @override
  State<DuelMatchScreen> createState() => _DuelMatchScreenState();
}

class _DuelMatchScreenState extends State<DuelMatchScreen> {
  final List<BattleProfile> _profiles = const [
    BattleProfile('RAIDEN_X', '39', 320, Color(0xFFFFA460), Color(0xFF6A31D4)),
    BattleProfile('NORA_J', '41', 360, Color(0xFF7EE8C4), Color(0xFF0A7A63)),
    BattleProfile('SARAH_K', '37', 305, Color(0xFFFFC1B0), Color(0xFFB7462F)),
    BattleProfile('MIRA_L', '40', 342, Color(0xFFD1C3FF), Color(0xFF6C50D8)),
  ];

  Timer? _timer;
  late BattleProfile _opponent;
  int _countdown = 3;
  bool _openingQuiz = false;

  @override
  void initState() {
    super.initState();
    _pickOpponent();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _pickOpponent() {
    final seed = DateTime.now().microsecondsSinceEpoch % _profiles.length;
    _opponent = _profiles[seed];
  }

  void _startCountdown() {
    _timer?.cancel();
    _countdown = 3;
    if (mounted) {
      setState(() {});
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_countdown > 1) {
        setState(() => _countdown -= 1);
        return;
      }

      timer.cancel();
      _openQuiz();
    });
  }

  void _reroll() {
    setState(_pickOpponent);
    _startCountdown();
  }

  void _openQuiz() {
    if (_openingQuiz) {
      return;
    }

    _openingQuiz = true;
    _timer?.cancel();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (context) => DuelQuizScreen(
          category: widget.category,
          levelLabel: widget.levelLabel,
          accentColor: widget.accentColor,
          opponent: _opponent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F4EF),
      body: SafeArea(
        child: Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: 390,
              height: 844,
              child: Stack(
                children: [
                  Positioned(
                    left: -82,
                    top: 116,
                    child: Container(
                      width: 166,
                      height: 166,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFDCCEF9),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -22,
                    top: 206,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFE2DC),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -72,
                    top: 358,
                    child: Container(
                      width: 246,
                      height: 246,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFD8F5E7),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -34,
                    bottom: 136,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE0D5FB),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 14, 22, 8),
                    child: Column(
                      children: [
                        const _BattleHeader(),
                        const SizedBox(height: 22),
                        Text(
                          strings.text('duelMatchMode'),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFB23B2E),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          strings.text('duelQuickBattle'),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 31,
                            height: 1,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.2,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 22),
                        _BattleCard(
                          name: strings.text('duelYou'),
                          levelLabel: widget.levelLabel,
                          strength: 840,
                          badgeColor: const Color(0xFFB6462F),
                          portraitColor: const Color(0xFF779894),
                          avatarOnLeft: true,
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: 52,
                                child: Text(
                                  strings.text('duelReadyGo'),
                                  style: TextStyle(
                                    fontSize: 44,
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF1D1B1B).withValues(alpha: 0.10),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 34,
                                child: _CountdownDisc(value: _countdown),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 4,
                                child: _BattleCard(
                                  name: _opponent.name,
                                  levelLabel: _opponent.levelLabel,
                                  strength: _opponent.strength,
                                  badgeColor: _opponent.accent,
                                  portraitColor: _opponent.avatarColor,
                                  avatarOnLeft: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        _ActionButton(
                          label: strings.text('duelAcceptChallenge'),
                          color: const Color(0xFF79F0C7),
                          onTap: _openQuiz,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(color: Color(0xFFCFCAC4), thickness: 1),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                strings.text('duelQuickActions'),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF8B8682),
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(color: Color(0xFFCFCAC4), thickness: 1),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _FlatActionChip(
                                icon: Icons.shuffle_rounded,
                                label: strings.text('duelReroll'),
                                color: const Color(0xFFB7462F),
                                onTap: _reroll,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _FlatActionChip(
                                icon: Icons.flag_rounded,
                                label: strings.text('duelPass'),
                                color: const Color(0xFF6C50D8),
                                onTap: () => Navigator.of(context).pop(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const _BattleBottomNav(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BattleHeader extends StatelessWidget {
  const _BattleHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.star_rounded, size: 30, color: Color(0xFFFF7A67)),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            'DEENRUSH',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
        ),
        _HeaderAvatar(size: 50),
      ],
    );
  }
}

class _BattleCard extends StatelessWidget {
  const _BattleCard({
    required this.name,
    required this.levelLabel,
    required this.strength,
    required this.badgeColor,
    required this.portraitColor,
    required this.avatarOnLeft,
  });

  final String name;
  final String levelLabel;
  final int strength;
  final Color badgeColor;
  final Color portraitColor;
  final bool avatarOnLeft;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final portrait = _BattlePortrait(size: 96, color: portraitColor);
    final content = Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: avatarOnLeft ? 14 : 0,
          right: avatarOnLeft ? 0 : 14,
          top: 8,
          bottom: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                if (!avatarOnLeft) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'LVL $levelLabel',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF252220),
                    ),
                  ),
                ),
                if (avatarOnLeft) ...[
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'LVL $levelLabel',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 14),
            const _StrengthPills(),
            const SizedBox(height: 10),
            Text(
              '${strings.text('duelStrengthScore')}: $strength',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF7B7671),
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );

    return Container(
      height: 160,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.97),
        borderRadius: BorderRadius.circular(36),
      ),
      child: Row(
        children: avatarOnLeft ? [portrait, content] : [content, portrait],
      ),
    );
  }
}

class _StrengthPills extends StatelessWidget {
  const _StrengthPills();

  @override
  Widget build(BuildContext context) {
    const colors = [
      Color(0xFFB6462F),
      Color(0xFF0A7A63),
      Color(0xFF6C50D8),
      Color(0xFFF67A61),
      Color(0xFFECE6DE),
      Color(0xFFECE6DE),
    ];

    return Row(
      children: List.generate(colors.length, (index) {
        return Expanded(
          child: Container(
            height: 18,
            margin: EdgeInsets.only(right: index == colors.length - 1 ? 0 : 8),
            decoration: BoxDecoration(
              color: colors[index],
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.black, width: 1.5),
            ),
          ),
        );
      }),
    );
  }
}

class _CountdownDisc extends StatelessWidget {
  const _CountdownDisc({required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 154,
      height: 154,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 154,
              height: 154,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            width: 146,
            height: 146,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFB6462F),
            ),
            alignment: Alignment.center,
            child: Text(
              '$value',
              style: const TextStyle(
                fontSize: 66,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderAvatar extends StatelessWidget {
  const _HeaderAvatar({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFF9B6F),
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Image.asset(
              AppAssets.logo,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class _BattlePortrait extends StatelessWidget {
  const _BattlePortrait({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              AppAssets.logo,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 84,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 76,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                height: 76,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(999),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          label,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.bolt_rounded, size: 28, color: Colors.black),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlatActionChip extends StatelessWidget {
  const _FlatActionChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF1EEEA),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 10),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2B2928),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BattleBottomNav extends StatelessWidget {
  const _BattleBottomNav();

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: _NavItem(
              icon: Icons.home_rounded,
              label: strings.text('navHome'),
            ),
          ),
          Expanded(
            child: _NavItem(
              icon: Icons.sports_martial_arts_rounded,
              label: strings.text('navDuel'),
              selected: true,
            ),
          ),
          Expanded(
            child: _NavItem(
              icon: Icons.bar_chart_rounded,
              label: strings.text('navRanks'),
            ),
          ),
          Expanded(
            child: _NavItem(
              icon: Icons.person_rounded,
              label: strings.text('navMe'),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return SizedBox(
        height: 86,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 74,
              height: 74,
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 74,
                      height: 74,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF7A67),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.sports_martial_arts_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(height: 2),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            label,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: 74,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(icon, color: const Color(0xFF4F4B4B), size: 24),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4F4B4B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
