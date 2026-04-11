import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';

class RanksScreen extends StatefulWidget {
  const RanksScreen({super.key});

  @override
  State<RanksScreen> createState() => _RanksScreenState();
}

class _RanksScreenState extends State<RanksScreen> {
  int _selectedPeriod = 0;

  static const _weeklyTopThree = [
    _WinnerEntry(
      rank: 2,
      name: 'Donin',
      score: '11200',
      accent: Color(0xFF8D73FF),
      medal: Color(0xFFD8D8E6),
      avatarColor: Color(0xFFF16FD9),
      icon: Icons.face_3_rounded,
    ),
    _WinnerEntry(
      rank: 1,
      name: 'Calzoni',
      score: '12400',
      accent: Color(0xFFFFD83D),
      medal: Color(0xFFFFD83D),
      avatarColor: Color(0xFFFFE8AE),
      icon: Icons.elderly_rounded,
    ),
    _WinnerEntry(
      rank: 3,
      name: 'Baptista',
      score: '10500',
      accent: Color(0xFFFFB45B),
      medal: Color(0xFFFFB45B),
      avatarColor: Color(0xFF82A9FF),
      icon: Icons.face_4_rounded,
    ),
  ];

  static const _allTimeTopThree = [
    _WinnerEntry(
      rank: 2,
      name: 'Victoria',
      score: '18840',
      accent: Color(0xFF8D73FF),
      medal: Color(0xFFD8D8E6),
      avatarColor: Color(0xFFFB7EAD),
      icon: Icons.face_5_rounded,
    ),
    _WinnerEntry(
      rank: 1,
      name: 'Mr.Dat',
      score: '21400',
      accent: Color(0xFFFFD83D),
      medal: Color(0xFFFFD83D),
      avatarColor: Color(0xFFFFE1A0),
      icon: Icons.sentiment_very_satisfied_rounded,
    ),
    _WinnerEntry(
      rank: 3,
      name: 'Saris',
      score: '17600',
      accent: Color(0xFFFFB45B),
      medal: Color(0xFFFFB45B),
      avatarColor: Color(0xFFA1B4FF),
      icon: Icons.person_rounded,
    ),
  ];

  static const _weeklyRankings = [
    _RankingEntry(
      rank: 4,
      name: 'Brandon Siphron',
      points: '9888',
      avatarColor: Color(0xFFF9C498),
      icon: Icons.person_rounded,
    ),
    _RankingEntry(
      rank: 5,
      name: 'Roger Donin',
      points: '9888',
      avatarColor: Color(0xFFF0B36A),
      icon: Icons.face_4_rounded,
    ),
    _RankingEntry(
      rank: 6,
      name: 'Allison Vaccaro',
      points: '9888',
      avatarColor: Color(0xFFD9D7FF),
      icon: Icons.face_6_rounded,
    ),
    _RankingEntry(
      rank: 7,
      name: 'Sana Noura',
      points: '9750',
      avatarColor: Color(0xFFFC9CC2),
      icon: Icons.face_3_rounded,
    ),
    _RankingEntry(
      rank: 8,
      name: 'Yusuf Kareem',
      points: '9540',
      avatarColor: Color(0xFF9FCEFF),
      icon: Icons.person_2_rounded,
    ),
    _RankingEntry(
      rank: 9,
      name: 'Aubrey Khan',
      points: '9415',
      avatarColor: Color(0xFFF7CD7A),
      icon: Icons.face_5_rounded,
    ),
  ];

  static const _allTimeRankings = [
    _RankingEntry(
      rank: 4,
      name: 'Layla Monroe',
      points: '16220',
      avatarColor: Color(0xFFF3BA86),
      icon: Icons.face_3_rounded,
    ),
    _RankingEntry(
      rank: 5,
      name: 'Roger Donin',
      points: '15980',
      avatarColor: Color(0xFFF0B36A),
      icon: Icons.face_4_rounded,
    ),
    _RankingEntry(
      rank: 6,
      name: 'Allison Vaccaro',
      points: '15670',
      avatarColor: Color(0xFFD9D7FF),
      icon: Icons.face_6_rounded,
    ),
    _RankingEntry(
      rank: 7,
      name: 'Noah Rahman',
      points: '15140',
      avatarColor: Color(0xFF95CBFF),
      icon: Icons.person_rounded,
    ),
    _RankingEntry(
      rank: 8,
      name: 'Debra Malik',
      points: '14880',
      avatarColor: Color(0xFFFFCC8E),
      icon: Icons.face_5_rounded,
    ),
    _RankingEntry(
      rank: 9,
      name: 'Aubrey Khan',
      points: '14550',
      avatarColor: Color(0xFFF7CD7A),
      icon: Icons.face_2_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final topThree = _selectedPeriod == 0 ? _weeklyTopThree : _allTimeTopThree;
    final rankings = _selectedPeriod == 0 ? _weeklyRankings : _allTimeRankings;

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF8E45FE),
            Color(0xFF7F45FC),
            Color(0xFF5A71FF),
          ],
        ),
      ),
      child: Stack(
        children: [
          const Positioned.fill(child: _RanksBackground()),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.text('homeLeaderboard'),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 18),
                _PeriodSwitcher(
                  weeklyLabel: strings.text('rankPeriodWeekly'),
                  allTimeLabel: strings.text('rankPeriodAllTime'),
                  selectedIndex: _selectedPeriod,
                  onChanged: (index) => setState(() => _selectedPeriod = index),
                ),
                const SizedBox(height: 14),
                _InsightCard(
                  rankLabel: '#4',
                  message: _insightMessage(strings.locale.languageCode),
                ),
                const SizedBox(height: 18),
                _PodiumSection(players: topThree),
                const SizedBox(height: 14),
                ...rankings.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _RankTile(
                      entry: entry,
                      pointsLabel: _pointsLabel(strings.locale.languageCode),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _insightMessage(String languageCode) {
    if (_selectedPeriod == 0) {
      switch (languageCode) {
        case 'az':
          return 'Sen oyuncularin 60%-den daha yaxsi oynayirsan!';
        case 'tr':
          return 'Oyuncularin %60\'indan daha iyi gidiyorsun!';
        case 'ru':
          return 'Ty igraesh luchshe, chem 60% igrokov!';
        case 'ar':
          return 'anta afdal min 60% min al-laibin!';
        default:
          return 'You are doing better than 60% of other players!';
      }
    }

    switch (languageCode) {
      case 'az':
        return 'Sen butun oyuncularin 82%-den daha yaxsi oynayirsan!';
      case 'tr':
        return 'Tum oyuncularin %82\'sinden daha iyi gidiyorsun!';
      case 'ru':
        return 'Ty igraesh luchshe, chem 82% vseh igrokov!';
      case 'ar':
        return 'anta afdal min 82% min jami al-laibin!';
      default:
        return 'You are doing better than 82% of all players!';
    }
  }

  String _pointsLabel(String languageCode) {
    switch (languageCode) {
      case 'az':
        return 'xal';
      case 'tr':
        return 'puan';
      case 'ru':
        return 'ochkov';
      case 'ar':
        return 'nuqta';
      default:
        return 'points';
    }
  }
}

class _RanksBackground extends StatelessWidget {
  const _RanksBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -92,
          right: -40,
          child: _SoftOrb(
            size: 220,
            color: Colors.white.withValues(alpha: 0.12),
            borderColor: Colors.white.withValues(alpha: 0.10),
          ),
        ),
        Positioned(
          top: 20,
          left: -120,
          child: _SoftOrb(
            size: 320,
            color: Colors.transparent,
            borderColor: Colors.white.withValues(alpha: 0.10),
          ),
        ),
        Positioned(
          bottom: 92,
          left: -90,
          child: _SoftOrb(
            size: 200,
            color: const Color(0x26FFFFFF),
            borderColor: Colors.white.withValues(alpha: 0.08),
          ),
        ),
        Positioned(
          bottom: -30,
          right: -40,
          child: _SoftOrb(
            size: 170,
            color: Colors.white.withValues(alpha: 0.07),
            borderColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}

class _SoftOrb extends StatelessWidget {
  const _SoftOrb({
    required this.size,
    required this.color,
    required this.borderColor,
  });

  final double size;
  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: 1.2),
      ),
    );
  }
}

class _PeriodSwitcher extends StatelessWidget {
  const _PeriodSwitcher({
    required this.weeklyLabel,
    required this.allTimeLabel,
    required this.selectedIndex,
    required this.onChanged,
  });

  final String weeklyLabel;
  final String allTimeLabel;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0x662E0E68),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2C240C5A),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _PeriodChip(
              label: weeklyLabel,
              selected: selectedIndex == 0,
              onTap: () => onChanged(0),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _PeriodChip(
              label: allTimeLabel,
              selected: selectedIndex == 1,
              onTap: () => onChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _PeriodChip extends StatelessWidget {
  const _PeriodChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: selected ? const Color(0xFFFFE135) : Colors.transparent,
          boxShadow: selected
              ? const [
                  BoxShadow(
                    color: Color(0x33FFD93D),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: selected
                ? const Color(0xFF8C5A00)
                : Colors.white.withValues(alpha: 0.55),
          ),
        ),
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({
    required this.rankLabel,
    required this.message,
  });

  final String rankLabel;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              rankLabel,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 15,
                height: 1.25,
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

class _PodiumSection extends StatelessWidget {
  const _PodiumSection({required this.players});

  final List<_WinnerEntry> players;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 206,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final columnWidth = (width - 20) / 3;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                bottom: 0,
                width: columnWidth,
                child: _PodiumBlock(
                  number: '2',
                  height: 98,
                  topColor: const Color(0xFFCDBEFF),
                  bottomColor: const Color(0xFFA984FF),
                ),
              ),
              Positioned(
                left: columnWidth - 2,
                bottom: 0,
                width: columnWidth + 4,
                child: _PodiumBlock(
                  number: '1',
                  height: 132,
                  topColor: const Color(0xFFE7DBFF),
                  bottomColor: const Color(0xFFB998FF),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                width: columnWidth,
                child: _PodiumBlock(
                  number: '3',
                  height: 84,
                  topColor: const Color(0xFFC1B4FF),
                  bottomColor: const Color(0xFF9E84FF),
                ),
              ),
              Positioned(
                left: 8,
                bottom: 88,
                width: columnWidth - 8,
                child: _WinnerBadge(player: players[0], compact: true),
              ),
              Positioned(
                left: columnWidth - 18,
                bottom: 118,
                width: columnWidth + 36,
                child: _WinnerBadge(player: players[1]),
              ),
              Positioned(
                right: 8,
                bottom: 78,
                width: columnWidth - 8,
                child: _WinnerBadge(player: players[2], compact: true),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PodiumBlock extends StatelessWidget {
  const _PodiumBlock({
    required this.number,
    required this.height,
    required this.topColor,
    required this.bottomColor,
  });

  final String number;
  final double height;
  final Color topColor;
  final Color bottomColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 14,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.94),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          ),
        ),
        Container(
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [topColor, bottomColor],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x201B0B52),
                blurRadius: 14,
                offset: Offset(0, 10),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 58,
              height: 0.95,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _WinnerBadge extends StatelessWidget {
  const _WinnerBadge({
    required this.player,
    this.compact = false,
  });

  final _WinnerEntry player;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final avatarSize = compact ? 62.0 : 78.0;
    final nameStyle = TextStyle(
      fontSize: compact ? 14 : 16,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            ClipPath(
              clipper: _HexagonClipper(),
              child: Container(
                width: avatarSize,
                height: avatarSize,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white.withValues(alpha: 0.72),
                    ],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33120A44),
                      blurRadius: 18,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: player.avatarColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    player.icon,
                    size: compact ? 34 : 42,
                    color: const Color(0xFF5D3D20),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -7,
              child: Container(
                width: compact ? 20 : 22,
                height: compact ? 20 : 22,
                decoration: BoxDecoration(
                  color: player.medal,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  size: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(player.name, style: nameStyle),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: player.accent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            player.score,
            style: TextStyle(
              fontSize: compact ? 10 : 11,
              fontWeight: FontWeight.w700,
              color: compact
                  ? Colors.white.withValues(alpha: 0.90)
                  : const Color(0xFF7B5A00),
            ),
          ),
        ),
      ],
    );
  }
}

class _RankTile extends StatelessWidget {
  const _RankTile({
    required this.entry,
    required this.pointsLabel,
  });

  final _RankingEntry entry;
  final String pointsLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22180D57),
            blurRadius: 12,
            offset: Offset(0, 7),
          ),
        ],
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.52)),
            ),
            child: Text(
              '${entry.rank}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white.withValues(alpha: 0.90),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _AvatarChip(
            color: entry.avatarColor,
            icon: entry.icon,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${entry.points} $pointsLabel',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarChip extends StatelessWidget {
  const _AvatarChip({
    required this.color,
    required this.icon,
  });

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x2A1E0F66),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(
          icon,
          color: const Color(0xFF5C3D20),
          size: 27,
        ),
      ),
    );
  }
}

class _HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width, size.height * 0.25);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(0, size.height * 0.75);
    path.lineTo(0, size.height * 0.25);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _WinnerEntry {
  const _WinnerEntry({
    required this.rank,
    required this.name,
    required this.score,
    required this.accent,
    required this.medal,
    required this.avatarColor,
    required this.icon,
  });

  final int rank;
  final String name;
  final String score;
  final Color accent;
  final Color medal;
  final Color avatarColor;
  final IconData icon;
}

class _RankingEntry {
  const _RankingEntry({
    required this.rank,
    required this.name,
    required this.points,
    required this.avatarColor,
    required this.icon,
  });

  final int rank;
  final String name;
  final String points;
  final Color avatarColor;
  final IconData icon;
}
