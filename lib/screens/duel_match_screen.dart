import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    final index = math.Random(seed).nextInt(_profiles.length);
    _opponent = _profiles[index];
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
    final categoryTitle = strings.categoryLabel(widget.category.labelKey);
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
                  const Positioned.fill(child: _RoomBackdrop()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _RoomHeader(
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
                                _RoomCodeCard(
                                  label: _matchText('codeLabel'),
                                  code: _roomCode,
                                  onCopy: _copyRoomCode,
                                ),
                                const SizedBox(height: 14),
                                _CategoryOverviewCard(
                                  icon: widget.category.icon,
                                  title: categoryTitle,
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
                                      child: _PlayerCard(
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
                                            ? _PlayerCard(
                                                key: const ValueKey('opponent'),
                                                accent: _opponent.accent,
                                                primaryLabel: _opponent.name,
                                                secondaryLabel:
                                                    '${strings.text('duelLevelLabel')} ${_opponent.levelLabel}',
                                                avatarLabel: _opponent.name,
                                              )
                                            : _SearchingPlayerCard(
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
                                _StatusCard(
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
                        _FooterActionCard(
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
                      child: _CountdownOverlay(
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

class _RoomHeader extends StatelessWidget {
  const _RoomHeader({
    required this.modeLabel,
    required this.onBack,
  });

  final String modeLabel;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.white.withValues(alpha: 0.14),
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onBack,
            customBorder: const CircleBorder(),
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.arrow_back_rounded,
                size: 22,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.sports_kabaddi_rounded,
                size: 16,
                color: Color(0xFFD8FF57),
              ),
              const SizedBox(width: 8),
              Text(
                modeLabel,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RoomCodeCard extends StatelessWidget {
  const _RoomCodeCard({
    required this.label,
    required this.code,
    required this.onCopy,
  });

  final String label;
  final String code;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF4B1FA9).withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label: $code',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.4,
                color: Colors.white,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onCopy,
              borderRadius: BorderRadius.circular(14),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.content_copy_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryOverviewCard extends StatelessWidget {
  const _CategoryOverviewCard({
    required this.icon,
    required this.title,
    required this.summary,
    required this.levelLabel,
    required this.highlightColor,
    required this.questionCount,
    required this.questionLabel,
    required this.minutes,
    required this.minutesLabel,
    required this.duelModeLabel,
  });

  final IconData icon;
  final String title;
  final String summary;
  final String levelLabel;
  final Color highlightColor;
  final int questionCount;
  final String questionLabel;
  final int minutes;
  final String minutesLabel;
  final String duelModeLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: highlightColor.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      summary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        color: Colors.white.withValues(alpha: 0.78),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  levelLabel,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _StatPill(
                icon: Icons.sports_martial_arts_rounded,
                label: duelModeLabel,
              ),
              _StatPill(
                icon: Icons.quiz_outlined,
                label: '$questionCount $questionLabel',
              ),
              _StatPill(
                icon: Icons.schedule_rounded,
                label: '$minutes $minutesLabel',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: Colors.white.withValues(alpha: 0.88)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerCard extends StatelessWidget {
  const _PlayerCard({
    super.key,
    required this.accent,
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.avatarLabel,
  });

  final Color accent;
  final String primaryLabel;
  final String secondaryLabel;
  final String avatarLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AvatarBubble(
            label: avatarLabel,
            color: accent,
          ),
          const SizedBox(height: 14),
          Text(
            primaryLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            secondaryLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.72),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchingPlayerCard extends StatelessWidget {
  const _SearchingPlayerCard({
    super.key,
    required this.accent,
    required this.title,
    required this.subtitle,
  });

  final Color accent;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.10),
            ),
            alignment: Alignment.center,
            child: SizedBox(
              width: 26,
              height: 26,
              child: CircularProgressIndicator(
                strokeWidth: 2.8,
                valueColor: AlwaysStoppedAnimation<Color>(accent),
                backgroundColor: Colors.white.withValues(alpha: 0.18),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.70),
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarBubble extends StatelessWidget {
  const _AvatarBubble({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.96),
            color.withValues(alpha: 0.62),
          ],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
      ),
      alignment: Alignment.center,
      child: Text(
        _initials(label),
        style: const TextStyle(
          fontSize: 18,
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

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFFD8FF57)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterActionCard extends StatelessWidget {
  const _FooterActionCard({
    required this.label,
    required this.accent,
    required this.textColor,
    required this.icon,
  });

  final String label;
  final Color accent;
  final Color textColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: textColor),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountdownOverlay extends StatelessWidget {
  const _CountdownOverlay({
    required this.opponentName,
    required this.value,
    required this.caption,
  });

  final String opponentName;
  final int value;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xAA260B61),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  opponentName,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutBack,
                    ),
                    child: child,
                  );
                },
                child: Text(
                  '$value',
                  key: ValueKey(value),
                  style: const TextStyle(
                    fontSize: 128,
                    height: 0.9,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFFFD53A),
                    shadows: [
                      Shadow(
                        color: Color(0xAA7C4700),
                        offset: Offset(0, 7),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                caption,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoomBackdrop extends StatelessWidget {
  const _RoomBackdrop();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -80,
            right: -70,
            child: Container(
              width: 240,
              height: 240,
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
            left: -42,
            top: 120,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF97EEFF).withValues(alpha: 0.18),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -48,
            bottom: 90,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFFD86B).withValues(alpha: 0.16),
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
