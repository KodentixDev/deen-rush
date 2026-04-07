import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';

class RanksScreen extends StatefulWidget {
  const RanksScreen({super.key});

  @override
  State<RanksScreen> createState() => _RanksScreenState();
}

class _RanksScreenState extends State<RanksScreen> {
  static const _background = Color(0xFFF9F4EF);
  static const _stageWidth = 360.0;

  int _selectedPeriod = 0;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);

    return DecoratedBox(
      decoration: const BoxDecoration(color: _background),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final scale = math.min(1.0, constraints.maxWidth / _stageWidth);
          final stageWidth = _stageWidth * scale;
          final stageLeft = (constraints.maxWidth - stageWidth) / 2;

          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 96 * scale),
                child: Center(
                  child: SizedBox(
                    width: stageWidth,
                    child: Column(
                      children: [
                        _ScaledStage(
                          scale: scale,
                          height: 64,
                          child: const _BrandHeader(),
                        ),
                        _ScaledStage(
                          scale: scale,
                          height: 75,
                          child: _LeaderboardTabs(
                            strings: strings,
                            selectedIndex: _selectedPeriod,
                            onChanged: (index) {
                              setState(() => _selectedPeriod = index);
                            },
                          ),
                        ),
                        _ScaledStage(
                          scale: scale,
                          height: 330,
                          child: const _PodiumSection(),
                        ),
                        _ScaledStage(
                          scale: scale,
                          height: 780,
                          child: _RankList(strings: strings),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: stageLeft + (15 * scale),
                right: stageLeft + (15 * scale),
                bottom: 8 * scale,
                child: _ScaledStage(
                  scale: scale,
                  height: 90,
                  child: _SelfRankCard(strings: strings),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ScaledStage extends StatelessWidget {
  const _ScaledStage({
    required this.scale,
    required this.height,
    required this.child,
  });

  final double scale;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * scale,
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: _RanksScreenState._stageWidth,
          height: height,
          child: child,
        ),
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 11, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.star_rounded,
            size: 28,
            color: Color(0xFFFF7A67),
          ),
          const SizedBox(width: 11),
          const Text(
            'DEENRUSH',
            style: TextStyle(
              fontSize: 26,
              height: 1,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.7,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 38,
            height: 38,
            padding: const EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: const _CoachAvatar(),
          ),
        ],
      ),
    );
  }
}

class _LeaderboardTabs extends StatelessWidget {
  const _LeaderboardTabs({
    required this.strings,
    required this.selectedIndex,
    required this.onChanged,
  });

  final AppStrings strings;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    const segmentWidth = 106.0;
    final labels = [
      strings.text('rankPeriodDaily'),
      strings.text('rankPeriodWeekly'),
      strings.text('rankPeriodAllTime'),
    ];

    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Container(
          width: 330,
          height: 47,
          decoration: BoxDecoration(
            color: const Color(0xFFE2E0DC),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOutCubic,
                left: 6 + (segmentWidth * selectedIndex),
                top: 6,
                child: Container(
                  width: segmentWidth,
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF7A67),
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: Colors.black, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 1.8),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: List.generate(labels.length, (index) {
                  final isSelected = selectedIndex == index;

                  return SizedBox(
                    width: 110,
                    height: 47,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(26),
                      onTap: () => onChanged(index),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              labels[index],
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: isSelected
                                    ? const Color(0xFF36110F)
                                    : const Color(0xFF5F5B5A),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PodiumSection extends StatelessWidget {
  const _PodiumSection();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: const [
        Positioned(
          left: 15,
          top: 208,
          child: _SidePodium(
            rank: '2',
            name: 'Sara.K',
            xp: '1,840 XP',
            pillColor: Color(0xFF87F7BE),
            medalColor: Color(0xFFBFC1C2),
            medalTop: -83,
            avatarTop: -66,
            avatarLeft: 22,
          ),
        ),
        Positioned(
          left: 125,
          top: 164,
          child: _CenterPodium(),
        ),
        Positioned(
          left: 236,
          top: 222,
          child: _SidePodium(
            rank: '3',
            name: 'Amira.R',
            xp: '1,720 XP',
            pillColor: Color(0xFFA986FF),
            medalColor: Color(0xFFD57B24),
            medalTop: -75,
            avatarTop: -58,
            avatarLeft: 24,
          ),
        ),
      ],
    );
  }
}

class _CenterPodium extends StatelessWidget {
  const _CenterPodium();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 151,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: -90,
            child: SizedBox(
              width: 96,
              height: 112,
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: const [
                  Positioned(
                    top: 0,
                    child: Icon(
                      Icons.star_rounded,
                      size: 76,
                      color: Color(0xFFFFD300),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: _WarriorAvatar(
                      size: 82,
                      borderWidth: 4,
                      variant: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
              child: Container(
                width: 103,
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0xFFFF7A67),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(17),
                ),
              ),
              child: Column(
                children: const [
                  SizedBox(height: 17),
                  Text(
                    '1',
                    style: TextStyle(
                      fontSize: 40,
                      height: 0.92,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF5B130C),
                    ),
                  ),
                  SizedBox(height: 9),
                  Text(
                    'Yusuf_78',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF3F0E0C),
                    ),
                  ),
                  SizedBox(height: 7),
                  _XpChip(
                    text: '2,150 XP',
                    width: 63,
                    height: 22,
                    background: Colors.black,
                    foreground: Colors.white,
                    borderWidth: 0,
                    fontSize: 11,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidePodium extends StatelessWidget {
  const _SidePodium({
    required this.rank,
    required this.name,
    required this.xp,
    required this.pillColor,
    required this.medalColor,
    required this.medalTop,
    required this.avatarTop,
    required this.avatarLeft,
  });

  final String rank;
  final String name;
  final String xp;
  final Color pillColor;
  final Color medalColor;
  final double medalTop;
  final double avatarTop;
  final double avatarLeft;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 103,
      height: 102,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: avatarTop,
            left: avatarLeft,
            child: WarriorAvatar(size: 58, variant: rank == '2' ? 1 : 2),
          ),
          Positioned(
            top: medalTop,
            left: 41,
            child: _MedalBadge(color: medalColor),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: 103,
              height: 96,
              decoration: const BoxDecoration(
                color: Color(0xFFE2E0DC),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(58),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 14),
                  Text(
                    rank,
                    style: const TextStyle(
                      fontSize: 31,
                      height: 0.94,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF252323),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF5E5A59),
                    ),
                  ),
                  const SizedBox(height: 5),
                  _XpChip(
                    text: xp,
                    width: 62,
                    height: 22,
                    background: pillColor,
                    foreground: const Color(0xFF274235),
                    borderWidth: 1.3,
                    fontSize: 10.5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MedalBadge extends StatelessWidget {
  const _MedalBadge({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F4EF),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 3),
      ),
      child: Icon(
        Icons.star_rounded,
        size: 15,
        color: color,
      ),
    );
  }
}

class _RankList extends StatelessWidget {
  const _RankList({required this.strings});

  final AppStrings strings;

  static const _items = [
    _RankRowData('4', 'Hamza.N', 'rankLevel12Warrior', '1,640 XP', 4),
    _RankRowData('5', 'Omar.F', 'rankLevel11Sage', '1,595 XP', 5),
    _RankRowData('6', 'Layla.M', 'rankLevel10Guardian', '1,420 XP', 6),
    _RankRowData('7', 'Noah.A', 'rankLevel10Scholar', '1,365 XP', 7),
    _RankRowData('8', 'Aisha.B', 'rankLevel9Seeker', '1,230 XP', 8),
    _RankRowData('9', 'Musa.T', 'rankLevel9Warrior', '1,140 XP', 9),
    _RankRowData('10', 'Zehra.S', 'rankLevel8Sage', '1,020 XP', 10),
    _RankRowData('11', 'Ali.R', 'rankLevel8Guardian', '960 XP', 11),
    _RankRowData('12', 'Mariam.H', 'rankLevel7Scholar', '900 XP', 12),
    _RankRowData('13', 'Ibrahim.Y', 'rankLevel7Seeker', '870 XP', 13),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          for (final item in _items) ...[
            _RankRow(item: item, strings: strings),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _RankRow extends StatelessWidget {
  const _RankRow({
    required this.item,
    required this.strings,
  });

  final _RankRowData item;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 65,
      decoration: BoxDecoration(
        color: const Color(0xFFF0EEEB),
        borderRadius: BorderRadius.circular(36),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            child: Text(
              item.rank,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w900,
                color: Color(0xFF84807E),
              ),
            ),
          ),
          _NumberAvatar(number: item.avatarNumber),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 19,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF242121),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  strings.text(item.subtitleKey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF625E5C),
                  ),
                ),
              ],
            ),
          ),
          _XpChip(
            text: item.xp,
            width: 67,
            height: 28,
            background: const Color(0xFFF3F1EE),
            foreground: const Color(0xFF2E2B2A),
            borderWidth: 2,
            fontSize: 11.5,
            compactXp: true,
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}

class _SelfRankCard extends StatelessWidget {
  const _SelfRankCard({required this.strings});

  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 79,
      decoration: BoxDecoration(
        color: const Color(0xFF83F0C2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(7, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 54,
            child: Text(
              '14',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                height: 1,
                fontWeight: FontWeight.w900,
                color: Color(0xFF05695C),
              ),
            ),
          ),
          const WarriorAvatar(size: 58, variant: 3),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SelfNameLine(label: strings.text('rankYouName')),
                const SizedBox(height: 6),
                Text(
                  strings.text('rankKeepGoing'),
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.05,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF077163),
                  ),
                ),
              ],
            ),
          ),
          const _XpChip(
            text: '840 XP',
            width: 74,
            height: 36,
            background: Color(0xFF05775D),
            foreground: Color(0xFF95F8C9),
            borderWidth: 2,
            fontSize: 15,
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

class _SelfNameLine extends StatelessWidget {
  const _SelfNameLine({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 17,
              height: 1,
              fontWeight: FontWeight.w900,
              color: Color(0xFF076B5E),
            ),
          ),
        ),
        const SizedBox(width: 6),
        const Icon(
          Icons.check_circle_rounded,
          size: 15,
          color: Color(0xFF066B5D),
        ),
      ],
    );
  }
}

class _XpChip extends StatelessWidget {
  const _XpChip({
    required this.text,
    required this.width,
    required this.height,
    required this.background,
    required this.foreground,
    required this.borderWidth,
    required this.fontSize,
    this.compactXp = false,
  });

  final String text;
  final double width;
  final double height;
  final Color background;
  final Color foreground;
  final double borderWidth;
  final double fontSize;
  final bool compactXp;

  @override
  Widget build(BuildContext context) {
    final parts = text.split(' ');

    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
        border: borderWidth == 0
            ? null
            : Border.all(color: Colors.black, width: borderWidth),
      ),
      child: compactXp && parts.length == 2
          ? RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: parts.first,
                style: TextStyle(
                  fontSize: fontSize,
                  height: 1,
                  fontWeight: FontWeight.w900,
                  color: foreground,
                ),
                children: [
                  TextSpan(
                    text: ' ${parts.last}',
                    style: TextStyle(
                      fontSize: fontSize * 0.58,
                      fontWeight: FontWeight.w900,
                      color: foreground.withValues(alpha: 0.78),
                    ),
                  ),
                ],
              ),
            )
          : Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                height: 1,
                fontWeight: FontWeight.w900,
                color: foreground,
              ),
            ),
    );
  }
}

class _CoachAvatar extends StatelessWidget {
  const _CoachAvatar();

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CustomPaint(
        painter: _CoachAvatarPainter(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class WarriorAvatar extends StatelessWidget {
  const WarriorAvatar({
    super.key,
    required this.size,
    required this.variant,
  });

  final double size;
  final int variant;

  @override
  Widget build(BuildContext context) {
    return _WarriorAvatar(
      size: size,
      variant: variant,
      borderWidth: 0,
    );
  }
}

class _WarriorAvatar extends StatelessWidget {
  const _WarriorAvatar({
    required this.size,
    required this.variant,
    required this.borderWidth,
  });

  final double size;
  final int variant;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(borderWidth),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: borderWidth == 0 ? Colors.transparent : Colors.black,
      ),
      child: ClipOval(
        child: CustomPaint(
          painter: _WarriorAvatarPainter(variant: variant),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _NumberAvatar extends StatelessWidget {
  const _NumberAvatar({required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 43,
      height: 43,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
        border: Border.all(color: Colors.black, width: 2),
      ),
      padding: const EdgeInsets.all(2),
      child: ClipOval(
        child: CustomPaint(
          painter: _NumberAvatarPainter(number: number),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _CoachAvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final bg = Paint()..color = const Color(0xFF173A42);
    canvas.drawRect(Offset.zero & size, bg);

    canvas.drawCircle(
      Offset(w * 0.5, h * 0.55),
      w * 0.42,
      Paint()..color = const Color(0xFF315F66),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.44),
        width: w * 0.47,
        height: h * 0.55,
      ),
      Paint()..color = const Color(0xFFFFB18D),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.23, h * 0.42)
        ..cubicTo(w * 0.28, h * 0.06, w * 0.68, h * 0.06, w * 0.77, h * 0.38)
        ..cubicTo(w * 0.66, h * 0.23, w * 0.43, h * 0.25, w * 0.33, h * 0.47)
        ..close(),
      Paint()..color = const Color(0xFF10151B),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.38, h * 0.43),
        width: w * 0.05,
        height: h * 0.04,
      ),
      Paint()..color = Colors.black,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.62, h * 0.43),
        width: w * 0.05,
        height: h * 0.04,
      ),
      Paint()..color = Colors.black,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.53),
        width: w * 0.18,
        height: h * 0.12,
      ),
      0.2,
      math.pi - 0.4,
      false,
      Paint()
        ..color = const Color(0xFF8E3D35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.24, h)
        ..lineTo(w * 0.38, h * 0.68)
        ..lineTo(w * 0.62, h * 0.68)
        ..lineTo(w * 0.77, h)
        ..close(),
      Paint()..color = const Color(0xFFE9F1F0),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.4, h * 0.74)
        ..lineTo(w * 0.5, h * 0.9)
        ..lineTo(w * 0.6, h * 0.74),
      Paint()
        ..color = const Color(0xFF0C6E7A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2,
    );
  }

  @override
  bool shouldRepaint(_CoachAvatarPainter oldDelegate) => false;
}

class _WarriorAvatarPainter extends CustomPainter {
  const _WarriorAvatarPainter({required this.variant});

  final int variant;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final shade = variant % 3;
    final background = [
      const Color(0xFF102B31),
      const Color(0xFF245C61),
      const Color(0xFF153845),
    ][shade];

    canvas.drawRect(Offset.zero & size, Paint()..color = background);
    canvas.drawCircle(
      Offset(w * (0.48 + (variant == 2 ? 0.08 : 0)), h * 0.54),
      w * 0.55,
      Paint()..color = const Color(0xFF133941),
    );

    final earPaint = Paint()..color = const Color(0xFF58B7BC);
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.24, h * 0.43)
        ..lineTo(w * 0.02, h * 0.34)
        ..lineTo(w * 0.22, h * 0.56)
        ..close(),
      earPaint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.76, h * 0.43)
        ..lineTo(w * 0.98, h * 0.34)
        ..lineTo(w * 0.78, h * 0.56)
        ..close(),
      earPaint,
    );

    final hairPaint = Paint()
      ..color = const Color(0xFF111215)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.045
      ..strokeCap = StrokeCap.round;

    for (var i = -3; i <= 3; i++) {
      final x = w * (0.5 + (i * 0.055));
      canvas.drawLine(
        Offset(x, h * 0.04),
        Offset(x + (i * 0.9), h * 0.95),
        hairPaint,
      );
    }

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.43),
        width: w * 0.45,
        height: h * 0.66,
      ),
      Paint()..color = const Color(0xFF63C2C8),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.42),
        width: w * 0.35,
        height: h * 0.58,
      ),
      Paint()..color = const Color(0xFF409BA6),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.34, h * 0.13)
        ..cubicTo(w * 0.43, h * 0.03, w * 0.66, h * 0.06, w * 0.72, h * 0.24)
        ..cubicTo(w * 0.62, h * 0.17, w * 0.43, h * 0.18, w * 0.3, h * 0.25),
      Paint()..color = const Color(0xFF15181A),
    );

    final markPaint = Paint()
      ..color = const Color(0xFF1C5D66)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.018
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(w * 0.38, h * 0.28), Offset(w * 0.27, h * 0.24), markPaint);
    canvas.drawLine(Offset(w * 0.62, h * 0.28), Offset(w * 0.73, h * 0.24), markPaint);
    canvas.drawLine(Offset(w * 0.42, h * 0.53), Offset(w * 0.32, h * 0.57), markPaint);
    canvas.drawLine(Offset(w * 0.58, h * 0.53), Offset(w * 0.68, h * 0.57), markPaint);

    final eyePaint = Paint()..color = const Color(0xFFE2D05B);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.39, h * 0.38),
        width: w * 0.1,
        height: h * 0.048,
      ),
      eyePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.61, h * 0.38),
        width: w * 0.1,
        height: h * 0.048,
      ),
      eyePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.39, h * 0.38),
        width: w * 0.025,
        height: h * 0.05,
      ),
      Paint()..color = Colors.black,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.61, h * 0.38),
        width: w * 0.025,
        height: h * 0.05,
      ),
      Paint()..color = Colors.black,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.5, h * 0.4)
        ..lineTo(w * 0.46, h * 0.53)
        ..lineTo(w * 0.54, h * 0.53),
      Paint()
        ..color = const Color(0xFF1E6975)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.018,
    );
    canvas.drawLine(
      Offset(w * 0.42, h * 0.6),
      Offset(w * 0.58, h * 0.6),
      Paint()
        ..color = const Color(0xFF1B2D32)
        ..strokeWidth = w * 0.02
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawPath(
      Path()
        ..moveTo(w * 0.34, h)
        ..lineTo(w * 0.4, h * 0.68)
        ..lineTo(w * 0.6, h * 0.68)
        ..lineTo(w * 0.67, h)
        ..close(),
      Paint()..color = const Color(0xFF2E777E),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.25, h)
        ..lineTo(w * 0.39, h * 0.76)
        ..lineTo(w * 0.5, h * 0.84)
        ..lineTo(w * 0.61, h * 0.76)
        ..lineTo(w * 0.76, h)
        ..close(),
      Paint()..color = const Color(0xFF7D6E54),
    );
  }

  @override
  bool shouldRepaint(_WarriorAvatarPainter oldDelegate) {
    return variant != oldDelegate.variant;
  }
}

class _NumberAvatarPainter extends CustomPainter {
  const _NumberAvatarPainter({required this.number});

  final int number;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final gradient = RadialGradient(
      center: const Alignment(-0.35, -0.55),
      radius: 0.9,
      colors: [
        const Color(0xFF0B3445),
        const Color(0xFF061018),
        Colors.black.withValues(alpha: 0.98),
      ],
    ).createShader(rect);

    canvas.drawRect(rect, Paint()..shader = gradient);
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.width * 0.43,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = const Color(0xFF1F2C34),
    );

    if (number == 5) {
      canvas.drawPath(
        Path()
          ..moveTo(size.width * 0.27, size.height * 0.63)
          ..cubicTo(
            size.width * 0.38,
            size.height * 0.35,
            size.width * 0.62,
            size.height * 0.36,
            size.width * 0.74,
            size.height * 0.63,
          )
          ..lineTo(size.width * 0.71, size.height * 0.68)
          ..lineTo(size.width * 0.3, size.height * 0.68)
          ..close(),
        Paint()..color = const Color(0xFF113B4A),
      );
    } else if (number == 6) {
      canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.54),
        size.width * 0.28,
        Paint()..color = const Color(0xFF22739A),
      );
      canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.54),
        size.width * 0.17,
        Paint()..color = const Color(0xFF07121A),
      );
    }

    final textPainter = TextPainter(
      text: TextSpan(
        text: '$number',
        style: TextStyle(
          fontSize: number >= 7 ? 14 : 17,
          fontWeight: FontWeight.w900,
          color: const Color(0xFF39A6DA).withValues(alpha: 0.84),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2 - 1,
      ),
    );
  }

  @override
  bool shouldRepaint(_NumberAvatarPainter oldDelegate) {
    return number != oldDelegate.number;
  }
}

class _RankRowData {
  const _RankRowData(
    this.rank,
    this.name,
    this.subtitleKey,
    this.xp,
    this.avatarNumber,
  );

  final String rank;
  final String name;
  final String subtitleKey;
  final String xp;
  final int avatarNumber;
}
