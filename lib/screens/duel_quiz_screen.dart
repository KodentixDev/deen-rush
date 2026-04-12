import 'dart:async';

import 'package:flutter/material.dart';

import '../data/quiz_catalog.dart';
import '../l10n/app_strings.dart';
import '../models/battle_profile.dart';

const Map<String, String> _duelQuizUiEn = {
  'point': 'point',
  'of': 'of',
};

const Map<String, String> _duelQuizUiAz = {
  'point': 'xal',
  'of': ' / ',
};

const Map<String, String> _duelQuizUiTr = {
  'point': 'puan',
  'of': ' / ',
};

class DuelQuizScreen extends StatefulWidget {
  const DuelQuizScreen({
    super.key,
    required this.category,
    required this.levelLabel,
    required this.accentColor,
    required this.opponent,
  });

  final QuizCategory category;
  final String levelLabel;
  final Color accentColor;
  final BattleProfile opponent;

  @override
  State<DuelQuizScreen> createState() => _DuelQuizScreenState();
}

class _DuelQuizScreenState extends State<DuelQuizScreen> {
  static const int _questionCount = 10;
  static const int _roundDurationSeconds = 260;

  late final List<QuizQuestion> _questions;
  Timer? _timer;
  int _questionIndex = 0;
  int _timeLeft = _roundDurationSeconds;
  int? _selectedIndex;
  bool _showResult = false;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _questions = _buildQuestions(widget.category);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List<QuizQuestion> _buildQuestions(QuizCategory category) {
    final base = category.levels.expand((level) => level.questions).toList();
    if (base.isEmpty) {
      return const [];
    }

    final questions = <QuizQuestion>[];
    while (questions.length < _questionCount) {
      questions.add(base[questions.length % base.length]);
    }
    return questions;
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_timeLeft > 1) {
        setState(() => _timeLeft -= 1);
        return;
      }

      timer.cancel();
      Navigator.of(context).pop();
    });
  }

  String _uiText(String key) {
    final strings = AppStrings.of(context);
    final values = switch (strings.locale.languageCode) {
      'az' => _duelQuizUiAz,
      'tr' => _duelQuizUiTr,
      _ => _duelQuizUiEn,
    };

    return values[key] ?? _duelQuizUiEn[key] ?? key;
  }

  void _handleAnswer(int index) {
    if (_showResult) {
      return;
    }

    final question = _questions[_questionIndex];
    final isCorrect = index == question.correctIndex;

    setState(() {
      _selectedIndex = index;
      _showResult = true;
      if (isCorrect) {
        _score += 10;
      }
    });
  }

  void _handleAdvance() {
    if (!_showResult) {
      return;
    }

    if (_questionIndex >= _questions.length - 1) {
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      _questionIndex += 1;
      _selectedIndex = null;
      _showResult = false;
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  String _questionCounterLabel() {
    final current = (_questionIndex + 1).toString().padLeft(2, '0');
    final total = _questions.length.toString().padLeft(2, '0');
    final glue = _uiText('of');

    if (glue.trim() == '/') {
      return '$current$glue$total';
    }

    return '$current $glue $total';
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final question = _questions[_questionIndex];
    final progress = (_questionIndex + 1) / _questions.length;
    final categoryTitle = strings.categoryLabel(widget.category.labelKey);

    return Scaffold(
      backgroundColor: const Color(0xFF7B45F7),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6F34ED),
              Color(0xFF8B4FFD),
              Color(0xFF5C2BD8),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Stack(
                children: [
                  const Positioned.fill(child: _QuizBackdrop()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _RoundIconButton(
                              icon: Icons.arrow_back_rounded,
                              onTap: () => Navigator.of(context).pop(),
                            ),
                            const Spacer(),
                            _TimerPill(label: _formatTime(_timeLeft)),
                          ],
                        ),
                        const SizedBox(height: 22),
                        Row(
                          children: [
                            const Icon(
                              Icons.stars_rounded,
                              size: 24,
                              color: Color(0xFFFFD84A),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$_score ${_uiText('point')}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _QuizProgressHeader(
                          progress: progress,
                          questionCounter: _questionCounterLabel(),
                          userAccent: widget.accentColor,
                          opponentAccent: widget.opponent.accent,
                          opponentName: widget.opponent.name,
                          userName: strings.text('playerYou'),
                        ),
                        const SizedBox(height: 18),
                        Expanded(
                          child: _QuestionPanel(
                            categoryTitle: categoryTitle,
                            prompt: question.prompt,
                            question: question,
                            selectedIndex: _selectedIndex,
                            showResult: _showResult,
                            onSelect: _handleAnswer,
                          ),
                        ),
                        const SizedBox(height: 18),
                        _NextButton(
                          label: strings.text('nextQuestion').toUpperCase(),
                          enabled: _showResult,
                          onTap: _handleAdvance,
                        ),
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

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
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

class _TimerPill extends StatelessWidget {
  const _TimerPill({required this.label});

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

class _QuizProgressHeader extends StatelessWidget {
  const _QuizProgressHeader({
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
              _LinearQuizProgress(progress: progress),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: _AvatarPair(
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

class _LinearQuizProgress extends StatelessWidget {
  const _LinearQuizProgress({required this.progress});

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

class _AvatarPair extends StatelessWidget {
  const _AvatarPair({
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
        _MiniAvatar(
          label: userName,
          accent: userAccent,
        ),
        Transform.translate(
          offset: const Offset(-8, 0),
          child: _MiniAvatar(
            label: opponentName,
            accent: opponentAccent,
          ),
        ),
      ],
    );
  }
}

class _MiniAvatar extends StatelessWidget {
  const _MiniAvatar({
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

class _QuestionPanel extends StatelessWidget {
  const _QuestionPanel({
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
              child: _AnswerOptionTile(
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

class _AnswerOptionTile extends StatelessWidget {
  const _AnswerOptionTile({
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

  _AnswerTilePalette _tileState() {
    if (!showResult) {
      return const _AnswerTilePalette(
        background: Colors.white,
        border: Color(0xFFD3D3D9),
      );
    }

    if (correct) {
      return const _AnswerTilePalette(
        background: Color(0xFFDDF8DB),
        border: Color(0xFFB7E6B1),
        icon: Icons.check_circle_rounded,
        iconColor: Color(0xFF35B86B),
      );
    }

    if (selected) {
      return const _AnswerTilePalette(
        background: Color(0xFFFAD7D8),
        border: Color(0xFFE7B3B6),
        icon: Icons.cancel_rounded,
        iconColor: Color(0xFFE34D5C),
      );
    }

    return const _AnswerTilePalette(
      background: Colors.white,
      border: Color(0xFFD3D3D9),
    );
  }
}

class _AnswerTilePalette {
  const _AnswerTilePalette({
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

class _NextButton extends StatelessWidget {
  const _NextButton({
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

class _QuizBackdrop extends StatelessWidget {
  const _QuizBackdrop();

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
