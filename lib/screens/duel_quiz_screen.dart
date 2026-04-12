import 'dart:async';

import 'package:flutter/material.dart';

import '../components/duel/duel_quiz_widgets.dart';
import '../data/quiz_catalog.dart';
import '../l10n/app_strings.dart';
import '../models/battle_profile.dart';

const Map<String, String> _duelQuizUiEn = {
  'point': 'point',
  'of': 'of',
};

const Map<String, String> _duelQuizUiAz = {
  'point': 'xal',
  'of': '/',
};

const Map<String, String> _duelQuizUiTr = {
  'point': 'puan',
  'of': '/',
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

    return glue == '/' ? '$current / $total' : '$current $glue $total';
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final question = _questions[_questionIndex];

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
                  const Positioned.fill(child: DuelQuizBackdrop()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            DuelRoundIconButton(
                              icon: Icons.arrow_back_rounded,
                              onTap: () => Navigator.of(context).pop(),
                            ),
                            const Spacer(),
                            DuelTimerPill(label: _formatTime(_timeLeft)),
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
                        DuelQuizProgressHeader(
                          progress: (_questionIndex + 1) / _questions.length,
                          questionCounter: _questionCounterLabel(),
                          userAccent: widget.accentColor,
                          opponentAccent: widget.opponent.accent,
                          opponentName: widget.opponent.name,
                          userName: strings.text('playerYou'),
                        ),
                        const SizedBox(height: 18),
                        Expanded(
                          child: DuelQuestionPanel(
                            categoryTitle: strings.categoryLabel(
                              widget.category.labelKey,
                            ),
                            prompt: question.prompt,
                            question: question,
                            selectedIndex: _selectedIndex,
                            showResult: _showResult,
                            onSelect: _handleAnswer,
                          ),
                        ),
                        const SizedBox(height: 18),
                        DuelNextButton(
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
