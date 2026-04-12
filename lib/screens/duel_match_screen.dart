import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/duel/duel_match_widgets.dart';
import '../data/quiz_catalog.dart';
import '../l10n/app_strings.dart';
import '../models/battle_profile.dart';
import 'duel_quiz_screen.dart';

const Map<String, String> _duelRoomStringsEn = {
  'title': 'Waiting Room',
  'waitingBody': 'Searching for an opponent. Your 1v1 room is ready.',
  'foundBody': 'Opponent found. The quiz will open in a few seconds.',
  'codeLabel': 'Code',
  'players': 'Players',
  'searching': 'Searching opponent...',
  'startsIn': 'Starting in',
  'oneVsOne': '1 vs 1',
  'minutes': 'min',
  'copied': 'Room code copied',
};

const Map<String, String> _duelRoomStringsAz = {
  'title': 'Gözləmə otağı',
  'waitingBody': 'Rəqib axtarılır. 1-ə 1 otağın hazırdır.',
  'foundBody': 'Rəqib tapıldı. Quiz bir neçə saniyəyə açılacaq.',
  'codeLabel': 'Kod',
  'players': 'Oyunçular',
  'searching': 'Rəqib axtarılır...',
  'startsIn': 'Başlayır',
  'oneVsOne': '1-ə 1',
  'minutes': 'dəq',
  'copied': 'Otaq kodu kopyalandı',
};

const Map<String, String> _duelRoomStringsTr = {
  'title': 'Bekleme Odası',
  'waitingBody': 'Rakip aranıyor. 1v1 odan hazır.',
  'foundBody': 'Rakip bulundu. Quiz birkaç saniye içinde açılacak.',
  'codeLabel': 'Kod',
  'players': 'Oyuncular',
  'searching': 'Rakip aranıyor...',
  'startsIn': 'Başlıyor',
  'oneVsOne': '1 vs 1',
  'minutes': 'dk',
  'copied': 'Oda kodu kopyalandı',
};

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
  static const int _countdownStart = 5;
  static const int _questionsPerRound = 10;
  static const Duration _matchmakingDelay = Duration(seconds: 2);

  final List<BattleProfile> _profiles = const [
    BattleProfile('Nora Khan', '41', 360, Color(0xFFFFC67C), Color(0xFFFF8A3D)),
    BattleProfile('Mira Noor', '37', 330, Color(0xFF8BE2E2), Color(0xFF1CB6C3)),
    BattleProfile('Zayd Ali', '44', 384, Color(0xFFAED7FF), Color(0xFF4A90FF)),
    BattleProfile('Sarah Iman', '39', 346, Color(0xFFD6B0FF), Color(0xFF9A64FF)),
  ];

  Timer? _matchmakingTimer;
  Timer? _countdownTimer;
  late BattleProfile _opponent;
  late final String _roomCode;
  bool _opponentFound = false;
  bool _openingQuiz = false;
  int _countdown = _countdownStart;

  @override
  void initState() {
    super.initState();
    _roomCode = _buildRoomCode();
    _pickOpponent();
    _beginMatchmaking();
  }

  @override
  void dispose() {
    _matchmakingTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _pickOpponent() {
    final seed = DateTime.now().microsecondsSinceEpoch;
    _opponent = _profiles[math.Random(seed).nextInt(_profiles.length)];
  }

  String _buildRoomCode() {
    const alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final random = math.Random(
      DateTime.now().millisecondsSinceEpoch ^ widget.category.id.hashCode,
    );

    return List.generate(
      6,
      (_) => alphabet[random.nextInt(alphabet.length)],
    ).join();
  }

  void _beginMatchmaking() {
    _matchmakingTimer?.cancel();
    _countdownTimer?.cancel();
    _countdown = _countdownStart;
    _opponentFound = false;

    _matchmakingTimer = Timer(_matchmakingDelay, () {
      if (!mounted) {
        return;
      }

      setState(() => _opponentFound = true);
      _startCountdown();
    });
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdown = _countdownStart;

    if (mounted) {
      setState(() {});
    }

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
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

  String _matchText(String key) {
    final strings = AppStrings.of(context);
    final values = switch (strings.locale.languageCode) {
      'az' => _duelRoomStringsAz,
      'tr' => _duelRoomStringsTr,
      _ => _duelRoomStringsEn,
    };

    return values[key] ?? _duelRoomStringsEn[key] ?? key;
  }

  Future<void> _copyRoomCode() async {
    await Clipboard.setData(ClipboardData(text: _roomCode));
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF2B135F),
          content: Text(_matchText('copied')),
        ),
      );
  }

  void _openQuiz() {
    if (_openingQuiz) {
      return;
    }

    _openingQuiz = true;
    _matchmakingTimer?.cancel();
    _countdownTimer?.cancel();

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
    final theme = Theme.of(context);
    final previewLevel = widget.category.levels.isEmpty
        ? null
        : widget.category.levels.first;
    final categorySummary = previewLevel == null
        ? strings.text('duelModeSubtitle')
        : strings.quizLevelSummary(
            widget.category.id,
            previewLevel.number,
            previewLevel.summary,
          );
    final minutes = math.max(4, ((_questionsPerRound * 15) / 60).ceil());

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
                  const Positioned.fill(child: DuelRoomBackdrop()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DuelRoomHeader(
                          modeLabel: _matchText('oneVsOne'),
                          onBack: () => Navigator.of(context).pop(),
                        ),
                        const SizedBox(height: 18),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _matchText('title'),
                                  style: theme.textTheme.headlineLarge?.copyWith(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -1,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _opponentFound
                                      ? _matchText('foundBody')
                                      : _matchText('waitingBody'),
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.82),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                DuelRoomCodeCard(
                                  label: _matchText('codeLabel'),
                                  code: _roomCode,
                                  onCopy: _copyRoomCode,
                                ),
                                const SizedBox(height: 14),
                                DuelCategoryOverviewCard(
                                  icon: widget.category.icon,
                                  title: strings.categoryLabel(widget.category.labelKey),
                                  summary: categorySummary,
                                  levelLabel:
                                      '${strings.text('duelLevelLabel')} ${widget.levelLabel}',
                                  highlightColor: widget.category.color,
                                  questionCount: _questionsPerRound,
                                  questionLabel: strings.text('categoryQuestions'),
                                  minutesLabel: _matchText('minutes'),
                                  minutes: minutes,
                                  duelModeLabel: _matchText('oneVsOne'),
                                ),
                                const SizedBox(height: 22),
                                Text(
                                  _matchText('players'),
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DuelPlayerCard(
                                        accent: widget.accentColor,
                                        primaryLabel: strings.text('playerYou'),
                                        secondaryLabel:
                                            '${strings.text('duelLevelLabel')} ${widget.levelLabel}',
                                        avatarLabel: strings.text('playerYou'),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 260),
                                        switchInCurve: Curves.easeOutCubic,
                                        switchOutCurve: Curves.easeOutCubic,
                                        child: _opponentFound
                                            ? DuelPlayerCard(
                                                key: const ValueKey('opponent'),
                                                accent: _opponent.accent,
                                                primaryLabel: _opponent.name,
                                                secondaryLabel:
                                                    '${strings.text('duelLevelLabel')} ${_opponent.levelLabel}',
                                                avatarLabel: _opponent.name,
                                              )
                                            : DuelSearchingPlayerCard(
                                                key: const ValueKey('searching'),
                                                accent: widget.category.color,
                                                title: _matchText('searching'),
                                                subtitle: _matchText('waitingBody'),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                DuelRoomStatusCard(
                                  icon: _opponentFound
                                      ? Icons.rocket_launch_rounded
                                      : Icons.wifi_tethering_rounded,
                                  label: _opponentFound
                                      ? '${_matchText('startsIn')} $_countdown'
                                      : _matchText('searching'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        DuelRoomFooterActionCard(
                          label: _opponentFound
                              ? '${_matchText('startsIn')} $_countdown'
                              : _matchText('searching'),
                          accent: _opponentFound
                              ? const Color(0xFFD8FF57)
                              : Colors.white.withValues(alpha: 0.18),
                          textColor:
                              _opponentFound ? const Color(0xFF211058) : Colors.white,
                          icon: _opponentFound
                              ? Icons.play_circle_fill_rounded
                              : Icons.hourglass_top_rounded,
                        ),
                      ],
                    ),
                  ),
                  if (_opponentFound && !_openingQuiz)
                    Positioned.fill(
                      child: DuelRoomCountdownOverlay(
                        opponentName: _opponent.name,
                        value: _countdown,
                        caption: strings.text('duelReadyGo'),
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
