import 'package:flutter/material.dart';

import '../../data/quiz_catalog.dart';

class DuelRoundIconButton extends StatelessWidget {
  const DuelRoundIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.14),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, size: 22, color: Colors.white),
        ),
      ),
    );
  }
}

class DuelTimerPill extends StatelessWidget {
  const DuelTimerPill({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF5522B7).withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(
            Icons.alarm_rounded,
            size: 18,
            color: Color(0xFFFFD84A),
          ),
        ],
      ),
    );
  }
}

class DuelQuizProgressHeader extends StatelessWidget {
  const DuelQuizProgressHeader({
    super.key,
    required this.progress,
    required this.questionCounter,
    required this.userAccent,
    required this.opponentAccent,
    required this.userName,
    required this.opponentName,
  });

  final double progress;
  final String questionCounter;
  final Color userAccent;
  final Color opponentAccent;
  final String userName;
  final String opponentName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Text(
                    questionCounter,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.82),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _DuelLinearQuizProgress(progress: progress),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: _DuelAvatarPair(
              userAccent: userAccent,
              opponentAccent: opponentAccent,
              userName: userName,
              opponentName: opponentName,
            ),
          ),
        ),
      ],
    );
  }
}

class DuelQuestionPanel extends StatelessWidget {
  const DuelQuestionPanel({
    super.key,
    required this.categoryTitle,
    required this.prompt,
    required this.question,
    required this.selectedIndex,
    required this.showResult,
    required this.onSelect,
  });

  final String categoryTitle;
  final String prompt;
  final QuizQuestion question;
  final int? selectedIndex;
  final bool showResult;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.98),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoryTitle,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF8C8C95),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            prompt,
            style: const TextStyle(
              fontSize: 19,
              height: 1.26,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1F1F28),
            ),
          ),
          const SizedBox(height: 22),
          ...List.generate(question.options.length, (index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == question.options.length - 1 ? 0 : 12,
              ),
              child: _DuelAnswerOptionTile(
                label: question.options[index],
                selected: selectedIndex == index,
                correct: question.correctIndex == index,
                showResult: showResult,
                onTap: () => onSelect(index),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class DuelNextButton extends StatelessWidget {
  const DuelNextButton({
    super.key,
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.72,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(999),
          child: Ink(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFE94A), Color(0xFFFFD63B)],
              ),
              borderRadius: BorderRadius.circular(999),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF734200).withValues(alpha: 0.18),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Color(0xFF755300),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DuelQuizBackdrop extends StatelessWidget {
  const DuelQuizBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -78,
            right: -64,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.16),
                    Colors.white.withValues(alpha: 0.02),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: -40,
            top: 120,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF97EEFF).withValues(alpha: 0.16),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: -50,
            bottom: 50,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF6EFFF6).withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DuelLinearQuizProgress extends StatelessWidget {
  const _DuelLinearQuizProgress({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.24),
        borderRadius: BorderRadius.circular(999),
      ),
      clipBehavior: Clip.antiAlias,
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: progress.clamp(0.0, 1.0),
          child: const DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0xFFFFD84A),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(999),
                right: Radius.circular(999),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DuelAvatarPair extends StatelessWidget {
  const _DuelAvatarPair({
    required this.userAccent,
    required this.opponentAccent,
    required this.userName,
    required this.opponentName,
  });

  final Color userAccent;
  final Color opponentAccent;
  final String userName;
  final String opponentName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _DuelMiniAvatar(
          label: userName,
          accent: userAccent,
        ),
        Transform.translate(
          offset: const Offset(-8, 0),
          child: _DuelMiniAvatar(
            label: opponentName,
            accent: opponentAccent,
          ),
        ),
      ],
    );
  }
}

class _DuelMiniAvatar extends StatelessWidget {
  const _DuelMiniAvatar({
    required this.label,
    required this.accent,
  });

  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: accent,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Text(
        _initials(label),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    );
  }

  static String _initials(String value) {
    final parts = value
        .replaceAll('_', ' ')
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();

    if (parts.isEmpty) {
      return '?';
    }

    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }

    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }
}

class _DuelAnswerOptionTile extends StatelessWidget {
  const _DuelAnswerOptionTile({
    required this.label,
    required this.selected,
    required this.correct,
    required this.showResult,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool correct;
  final bool showResult;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final state = _tileState();

    return InkWell(
      onTap: showResult ? null : onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: state.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: state.border),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF23232B),
                ),
              ),
            ),
            if (state.icon != null)
              Icon(state.icon, color: state.iconColor, size: 24),
          ],
        ),
      ),
    );
  }

  _DuelAnswerTilePalette _tileState() {
    if (!showResult) {
      return const _DuelAnswerTilePalette(
        background: Colors.white,
        border: Color(0xFFD3D3D9),
      );
    }

    if (correct) {
      return const _DuelAnswerTilePalette(
        background: Color(0xFFDDF8DB),
        border: Color(0xFFB7E6B1),
        icon: Icons.check_circle_rounded,
        iconColor: Color(0xFF35B86B),
      );
    }

    if (selected) {
      return const _DuelAnswerTilePalette(
        background: Color(0xFFFAD7D8),
        border: Color(0xFFE7B3B6),
        icon: Icons.cancel_rounded,
        iconColor: Color(0xFFE34D5C),
      );
    }

    return const _DuelAnswerTilePalette(
      background: Colors.white,
      border: Color(0xFFD3D3D9),
    );
  }
}

class _DuelAnswerTilePalette {
  const _DuelAnswerTilePalette({
    required this.background,
    required this.border,
    this.icon,
    this.iconColor,
  });

  final Color background;
  final Color border;
  final IconData? icon;
  final Color? iconColor;
}
