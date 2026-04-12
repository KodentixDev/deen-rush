import 'package:flutter/material.dart';

class WinnerEntry {
  const WinnerEntry({
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

class RankingEntry {
  const RankingEntry({
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

class RanksBackground extends StatelessWidget {
  const RanksBackground({super.key});

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

class PeriodSwitcher extends StatelessWidget {
  const PeriodSwitcher({
    super.key,
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

class RanksInsightCard extends StatelessWidget {
  const RanksInsightCard({
    super.key,
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

class PodiumSection extends StatelessWidget {
  const PodiumSection({
    super.key,
    required this.players,
  });

  final List<WinnerEntry> players;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 232,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const gap = 10.0;
          final centerWidth = constraints.maxWidth * 0.36;
          final sideWidth = (constraints.maxWidth - centerWidth - (gap * 2)) / 2;
          final leftX = 0.0;
          final centerX = sideWidth + gap;
          final rightX = centerX + centerWidth + gap;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: leftX,
                bottom: 0,
                width: sideWidth,
                child: const _PodiumPedestal(
                  number: '2',
                  height: 92,
                  topColor: Color(0xFFD8CAFF),
                  bottomColor: Color(0xFFB08EFF),
                  capInset: 6,
                ),
              ),
              Positioned(
                left: centerX,
                bottom: 0,
                width: centerWidth,
                child: const _PodiumPedestal(
                  number: '1',
                  height: 126,
                  topColor: Color(0xFFEDE3FF),
                  bottomColor: Color(0xFFC19FFF),
                  capInset: 16,
                  capHeight: 16,
                ),
              ),
              Positioned(
                left: rightX,
                bottom: 0,
                width: sideWidth,
                child: const _PodiumPedestal(
                  number: '3',
                  height: 92,
                  topColor: Color(0xFFD7CAFF),
                  bottomColor: Color(0xFFA884FF),
                  capInset: 6,
                ),
              ),
              Positioned(
                left: leftX,
                bottom: 112,
                width: sideWidth,
                child: _WinnerBadge(player: players[0], compact: true),
              ),
              Positioned(
                left: centerX,
                bottom: 142,
                width: centerWidth,
                child: _WinnerBadge(player: players[1]),
              ),
              Positioned(
                left: rightX,
                bottom: 112,
                width: sideWidth,
                child: _WinnerBadge(player: players[2], compact: true),
              ),
            ],
          );
        },
      ),
    );
  }
}

class RankTile extends StatelessWidget {
  const RankTile({
    super.key,
    required this.entry,
    required this.allTimeMode,
    required this.pointsLabel,
  });

  final RankingEntry entry;
  final bool allTimeMode;
  final String pointsLabel;

  @override
  Widget build(BuildContext context) {
    final badgeFill = switch (entry.rank) {
      1 => const Color(0xFFFFD83D),
      2 => const Color(0xFFD7D8E4),
      3 => const Color(0xFFFFB45B),
      _ => Colors.transparent,
    };
    final badgeTextColor = entry.rank <= 3
        ? const Color(0xFF6B5200)
        : Colors.white.withValues(alpha: 0.90);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.13),
            Colors.white.withValues(alpha: 0.08),
          ],
        ),
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
              color: badgeFill,
              border: Border.all(
                color: entry.rank <= 3
                    ? Colors.transparent
                    : Colors.white.withValues(alpha: 0.52),
              ),
            ),
            child: Text(
              '${entry.rank}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: badgeTextColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          _AvatarChip(color: entry.avatarColor, icon: entry.icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: allTimeMode ? 17 : 18,
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

class _PodiumPedestal extends StatelessWidget {
  const _PodiumPedestal({
    required this.number,
    required this.height,
    required this.topColor,
    required this.bottomColor,
    this.capInset = 8,
    this.capHeight = 12,
  });

  final String number;
  final double height;
  final Color topColor;
  final Color bottomColor;
  final double capInset;
  final double capHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipPath(
          clipper: _PodiumCapClipper(),
          child: Container(
            height: capHeight,
            margin: EdgeInsets.symmetric(horizontal: capInset),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.97),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x22FFFFFF),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
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
            style: TextStyle(
              fontSize: number == '1' ? 60 : 56,
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

  final WinnerEntry player;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final avatarSize = compact ? 62.0 : 82.0;

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
        Text(
          player.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: compact ? 13.5 : 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 10 : 12,
            vertical: 4,
          ),
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
                  ? Colors.white.withValues(alpha: 0.92)
                  : const Color(0xFF7B5A00),
            ),
          ),
        ),
      ],
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

class _PodiumCapClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.12, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.88, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
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
