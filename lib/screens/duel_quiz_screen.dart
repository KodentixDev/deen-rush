import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../config/app_assets.dart';
import '../data/quiz_catalog.dart';
import '../l10n/app_strings.dart';
import '../models/battle_profile.dart';

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
  late final List<QuizQuestion> _questions;
  Timer? _timer;
  int _questionIndex = 0;
  int _secondsLeft = 15;
  int? _selectedIndex;
  bool _locked = false;

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

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = 15;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_secondsLeft > 1) {
        setState(() => _secondsLeft -= 1);
        return;
      }

      timer.cancel();
      _handleAdvance();
    });
  }

  List<QuizQuestion> _buildQuestions(QuizCategory category) {
    final base = category.levels.expand((level) => level.questions).toList();
    if (base.isEmpty) {
      return const [];
    }

    final questions = <QuizQuestion>[];
    while (questions.length < 7) {
      questions.add(base[questions.length % base.length]);
    }
    return questions;
  }

  void _handleAnswer(int index) {
    if (_locked) {
      return;
    }

    _timer?.cancel();
    setState(() {
      _locked = true;
      _selectedIndex = index;
    });

    Future<void>.delayed(const Duration(milliseconds: 700), _handleAdvance);
  }

  void _handleAdvance() {
    if (!mounted) {
      return;
    }

    if (_questionIndex >= _questions.length - 1) {
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      _questionIndex += 1;
      _selectedIndex = null;
      _locked = false;
    });
    _startTimer();
  }

  String _quizText(String value) {
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final question = _questions[_questionIndex];
    final progress = (_questionIndex + 1) / _questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F4EF),
      body: SafeArea(
        child: Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: 390,
              height: 920,
              child: Stack(
                children: [
                  Positioned(
                    left: -58,
                    top: 86,
                    child: Container(
                      width: 210,
                      height: 250,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFFDCCEF9).withValues(alpha: 0.85),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -18,
                    bottom: 16,
                    child: Container(
                      width: 190,
                      height: 190,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFFFFD8CF).withValues(alpha: 0.80),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 14, 22, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 30,
                              color: Color(0xFFFF7A67),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'DEENRUSH',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            _QuizAvatar(
                              color: widget.opponent.avatarColor,
                              size: 50,
                              outlined: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        _QuizProgressBar(progress: progress),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            _ProgressDots(
                              total: _questions.length,
                              currentIndex: _questionIndex,
                            ),
                            const Spacer(),
                            _LevelPill(
                              label: strings.text('duelLevelLabel'),
                              level: widget.levelLabel,
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Center(
                          child: _CountdownRing(secondsLeft: _secondsLeft),
                        ),
                        const SizedBox(height: 20),
                        _QuestionPromptCard(text: _quizText(question.prompt)),
                        const SizedBox(height: 14),
                        ...List.generate(question.options.length, (index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: index == question.options.length - 1 ? 0 : 12,
                            ),
                            child: _AnswerChoiceCard(
                              marker: String.fromCharCode(65 + index),
                              label: _quizText(question.options[index]),
                              selected: _selectedIndex == index,
                              onTap: () => _handleAnswer(index),
                            ),
                          );
                        }),
                        const Spacer(),
                        _CoachFooter(
                          hint: strings.text('duelCoachHint'),
                          accentColor: widget.accentColor,
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

class _QuizProgressBar extends StatelessWidget {
  const _QuizProgressBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F0EA),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.black, width: 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: progress.clamp(0.0, 1.0).toDouble(),
          child: const DecoratedBox(
            decoration: BoxDecoration(
              color: Color(0xFF7A44F7),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(999),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressDots extends StatelessWidget {
  const _ProgressDots({
    required this.total,
    required this.currentIndex,
  });

  final int total;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (index) {
        final active = index <= currentIndex;
        return Container(
          width: 18,
          height: 18,
          margin: EdgeInsets.only(right: index == total - 1 ? 0 : 10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? Colors.black : const Color(0xFFF8F5F1),
            border: Border.all(color: Colors.black, width: 1.6),
          ),
        );
      }),
    );
  }
}

class _LevelPill extends StatelessWidget {
  const _LevelPill({
    required this.label,
    required this.level,
  });

  final String label;
  final String level;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          '$label $level',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: Color(0xFF2F2C2A),
          ),
        ),
      ),
    );
  }
}

class _CountdownRing extends StatelessWidget {
  const _CountdownRing({required this.secondsLeft});

  final int secondsLeft;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 118,
      height: 118,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size.square(112),
            painter: const _CountdownRingPainter(),
          ),
          Text(
            '$secondsLeft',
            style: const TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _CountdownRingPainter extends CustomPainter {
  const _CountdownRingPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFB6462F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Offset.zero & size,
      -0.95,
      math.pi * 1.7,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _QuestionPromptCard extends StatelessWidget {
  const _QuestionPromptCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.98),
            borderRadius: BorderRadius.circular(42),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 19,
              height: 1.22,
              fontWeight: FontWeight.w900,
              color: Color(0xFF2F2C2A),
            ),
          ),
        ),
        Positioned(
          right: -8,
          top: -8,
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFB59BFF),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              size: 24,
              color: Color(0xFF5A21D6),
            ),
          ),
        ),
      ],
    );
  }
}

class _AnswerChoiceCard extends StatelessWidget {
  const _AnswerChoiceCard({
    required this.marker,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String marker;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFEEE8) : const Color(0xFFF5F1EC),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Text(
                marker,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF2F2C2A),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2F2C2A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoachFooter extends StatelessWidget {
  const _CoachFooter({
    required this.hint,
    required this.accentColor,
  });

  final String hint;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _QuizAvatar(
          color: Color(0xFFFF7A67),
          size: 48,
          square: true,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              hint,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFE1DDD7),
          ),
          child: Icon(
            Icons.lightbulb_rounded,
            color: accentColor,
          ),
        ),
      ],
    );
  }
}

class _QuizAvatar extends StatelessWidget {
  const _QuizAvatar({
    required this.color,
    required this.size,
    this.outlined = false,
    this.square = false,
  });

  final Color color;
  final double size;
  final bool outlined;
  final bool square;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(size * 0.26);

    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(outlined ? 2 : size * 0.08),
      decoration: BoxDecoration(
        color: outlined ? Colors.black : color,
        shape: square ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: square ? borderRadius : null,
      ),
      child: Container(
        padding: EdgeInsets.all(size * 0.08),
        decoration: BoxDecoration(
          color: color,
          shape: square ? BoxShape.rectangle : BoxShape.circle,
          borderRadius: square ? borderRadius : null,
        ),
        child: ClipRRect(
          borderRadius: square ? borderRadius : BorderRadius.circular(size),
          child: Image.asset(
            AppAssets.logo,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
