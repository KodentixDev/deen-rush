import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/quiz_catalog.dart';
import '../l10n/app_strings.dart';
import 'category_levels_screen.dart';

class DuelScreen extends StatefulWidget {
  const DuelScreen({super.key});

  @override
  State<DuelScreen> createState() => _DuelScreenState();
}

class _DuelScreenState extends State<DuelScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final items = _duelItems();
    final mixed = _mixedItem();

    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xFFF9F4EF)),
      child: Stack(
        children: [
          const Positioned.fill(child: _DuelBackground()),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(32, 18, 32, 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Reveal(
                  controller: _controller,
                  begin: 0,
                  end: 0.18,
                  offset: const Offset(0, -12),
                  child: const _DuelHeader(),
                ),
                const SizedBox(height: 60),
                _Reveal(
                  controller: _controller,
                  begin: 0.08,
                  end: 0.32,
                  offset: const Offset(-16, 0),
                  child: _DuelHero(strings: strings),
                ),
                const SizedBox(height: 36),
                LayoutBuilder(
                  builder: (context, constraints) {
                    const spacing = 22.0;
                    final cardWidth = (constraints.maxWidth - spacing) / 2;

                    return Wrap(
                      spacing: spacing,
                      runSpacing: 20,
                      children: List.generate(items.length, (index) {
                        final item = items[index];

                        return SizedBox(
                          width: cardWidth,
                          child: _Reveal(
                            controller: _controller,
                            begin: 0.26 + (index * 0.05),
                            end: 0.58 + (index * 0.045),
                            offset: Offset(0, 28 + (index * 3)),
                            child: _AdventureCard(
                              item: item,
                              title: strings.categoryLabel(
                                item.category.labelKey,
                              ),
                              levelLabel: strings.text('duelLevelLabel'),
                              onTap: () => _openCategory(item.category),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
                const SizedBox(height: 88),
                _Reveal(
                  controller: _controller,
                  begin: 0.78,
                  end: 1,
                  offset: const Offset(0, 28),
                  child: _MixedQuizCard(
                    item: mixed,
                    title: strings.text('mixedQuiz'),
                    levelLabel: strings.text('duelLevelLabel'),
                    onTap: () => _openCategory(mixed.category),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openCategory(QuizCategory category) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => CategoryLevelsScreen(category: category),
      ),
    );
  }

  List<_AdventureItem> _duelItems() {
    final fiqh = _categoryById('fiqh');
    final quran = _categoryById('quran');
    final history = _categoryById('history');
    final culture = _categoryById('culture');
    final geography = _categoryById('geography');
    final mixed = _categoryById('mixed');

    return [
      _AdventureItem(
        category: fiqh.copyAs(
          icon: Icons.balance_rounded,
          color: const Color(0xFF75EEC1),
        ),
        level: '12',
        progress: 0.64,
        color: const Color(0xFF75EEC1),
        accent: const Color(0xFF007B5F),
        titleColor: const Color(0xFF05745E),
        icon: Icons.balance_rounded,
        pattern: _CardPattern.none,
        tilt: -0.012,
      ),
      _AdventureItem(
        category: quran.copyAs(
          icon: Icons.menu_book_rounded,
          color: const Color(0xFFFFEFA8),
        ),
        level: '24',
        progress: 0.86,
        color: const Color(0xFFFFEFA8),
        accent: const Color(0xFFD4A900),
        titleColor: const Color(0xFF7A6900),
        icon: Icons.menu_book_rounded,
        pattern: _CardPattern.stripes,
        tilt: 0.012,
      ),
      _AdventureItem(
        category: mixed.copyAs(
          id: 'hadith',
          labelKey: 'hadith',
          icon: Icons.chat_rounded,
          color: const Color(0xFFE3F8F6),
        ),
        level: '08',
        progress: 0.40,
        color: const Color(0xFFE3F8F6),
        accent: const Color(0xFF008B7D),
        titleColor: const Color(0xFF047568),
        icon: Icons.chat_rounded,
        pattern: _CardPattern.none,
        tilt: 0.006,
      ),
      _AdventureItem(
        category: history.copyAs(
          icon: Icons.history_edu_rounded,
          color: const Color(0xFFFFE6EC),
        ),
        level: '15',
        progress: 0.54,
        color: const Color(0xFFFFE6EC),
        accent: const Color(0xFFFF3F38),
        titleColor: const Color(0xFFD8232B),
        icon: Icons.history_edu_rounded,
        pattern: _CardPattern.none,
        tilt: -0.006,
      ),
      _AdventureItem(
        category: geography.copyAs(
          icon: Icons.public_rounded,
          color: const Color(0xFFA88AF4),
        ),
        level: '05',
        progress: 0.24,
        color: const Color(0xFFA88AF4),
        accent: const Color(0xFF6A31D4),
        titleColor: const Color(0xFF4A169E),
        icon: Icons.public_rounded,
        pattern: _CardPattern.dots,
        tilt: -0.014,
      ),
      _AdventureItem(
        category: culture.copyAs(
          icon: Icons.theater_comedy_rounded,
          color: const Color(0xFFFF7565),
        ),
        level: '30',
        progress: 0.95,
        color: const Color(0xFFFF7565),
        accent: const Color(0xFFB74734),
        titleColor: const Color(0xFF1F120F),
        icon: Icons.theater_comedy_rounded,
        pattern: _CardPattern.none,
        tilt: 0.008,
      ),
    ];
  }

  _AdventureItem _mixedItem() {
    final mixed = _categoryById('mixed');

    return _AdventureItem(
      category: mixed.copyAs(
        icon: Icons.star_rounded,
        color: const Color(0xFFE2E0DA),
      ),
      level: '01',
      progress: 0.12,
      color: const Color(0xFFE2E0DA),
      accent: const Color(0xFF222222),
      titleColor: const Color(0xFF24211F),
      icon: Icons.star_rounded,
      pattern: _CardPattern.none,
      tilt: 0,
    );
  }

  QuizCategory _categoryById(String id) {
    return quizCatalog.firstWhere((category) => category.id == id);
  }
}

class _DuelBackground extends StatelessWidget {
  const _DuelBackground();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: 76,
            right: -160,
            child: Container(
              width: 430,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFBDF3D5).withValues(alpha: 0.48),
                    const Color(0xFFBDF3D5).withValues(alpha: 0.04),
                    const Color(0x00BDF3D5),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: -160,
            bottom: -110,
            child: Container(
              width: 360,
              height: 360,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFFDACF).withValues(alpha: 0.30),
                    const Color(0x00FFDACF),
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

class _DuelHeader extends StatelessWidget {
  const _DuelHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const PositionedDirectional(
            start: 0,
            child: Icon(
              Icons.star_rounded,
              size: 33,
              color: Color(0xFFFF7A67),
            ),
          ),
          const Text(
            'DEENRUSH',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 31,
              height: 1,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.6,
              color: Colors.black,
            ),
          ),
          PositionedDirectional(
            end: 0,
            child: Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(2.2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: const ClipOval(
                child: CustomPaint(
                  painter: _BlueAvatarPainter(),
                  child: SizedBox.expand(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DuelHero extends StatelessWidget {
  const _DuelHero({
    required this.strings,
  });

  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          strings.text('duelChooseYour'),
          style: const TextStyle(
            fontSize: 38,
            height: 1,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.2,
            color: Color(0xFF2B2928),
            shadows: [
              Shadow(
                color: Color(0xFFE4DFD9),
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          strings.text('duelAdventure'),
          style: const TextStyle(
            fontSize: 40,
            height: 0.95,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.2,
            color: Color(0xFFB33B2E),
          ),
        ),
        const SizedBox(height: 23),
        Text(
          strings.text('duelLevelUp'),
          style: const TextStyle(
            fontSize: 20,
            height: 1,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
            color: Color(0xFF6D6762),
            fontFamily: 'serif',
          ),
        ),
      ],
    );
  }
}

class _AdventureCard extends StatefulWidget {
  const _AdventureCard({
    required this.item,
    required this.title,
    required this.levelLabel,
    required this.onTap,
  });

  final _AdventureItem item;
  final String title;
  final String levelLabel;
  final VoidCallback onTap;

  @override
  State<_AdventureCard> createState() => _AdventureCardState();
}

class _AdventureCardState extends State<_AdventureCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.965 : 1,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,
        child: Transform.rotate(
          angle: widget.item.tilt,
          child: SizedBox(
            height: 250,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  top: 34,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 140),
                    curve: Curves.easeOutCubic,
                    transform: Matrix4.translationValues(0, _pressed ? 4 : 0, 0),
                    decoration: BoxDecoration(
                      color: widget.item.color,
                      borderRadius: BorderRadius.circular(58),
                      boxShadow: [
                        BoxShadow(
                          color: widget.item.color.withValues(alpha: 0.24),
                          blurRadius: 28,
                          offset: const Offset(0, 22),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CustomPaint(
                      painter: _CardPatternPainter(
                        pattern: widget.item.pattern,
                        color: widget.item.titleColor,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 34,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 74, 18, 24),
                    child: Column(
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            widget.title,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              height: 1,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.6,
                              color: widget.item.titleColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _LevelBadge(
                          label: widget.levelLabel,
                          level: widget.item.level,
                          color: widget.item.accent,
                        ),
                        const Spacer(),
                        _SketchProgress(
                          value: widget.item.progress,
                          color: widget.item.accent,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: _AdventureIconBadge(
                    item: widget.item,
                    pressed: _pressed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AdventureIconBadge extends StatelessWidget {
  const _AdventureIconBadge({
    required this.item,
    required this.pressed,
  });

  final _AdventureItem item;
  final bool pressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,
        width: 86,
        height: 92,
        transform: Matrix4.translationValues(0, pressed ? 4 : 0, 0),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FFF6),
          borderRadius: BorderRadius.circular(44),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(7, pressed ? 5 : 9),
            ),
          ],
        ),
        child: Icon(
          item.icon,
          size: 40,
          color: item.accent,
        ),
      ),
    );
  }
}

class _MixedQuizCard extends StatefulWidget {
  const _MixedQuizCard({
    required this.item,
    required this.title,
    required this.levelLabel,
    required this.onTap,
  });

  final _AdventureItem item;
  final String title;
  final String levelLabel;
  final VoidCallback onTap;

  @override
  State<_MixedQuizCard> createState() => _MixedQuizCardState();
}

class _MixedQuizCardState extends State<_MixedQuizCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOutCubic,
          height: 150,
          transform: Matrix4.translationValues(0, _pressed ? 5 : 0, 0),
          padding: const EdgeInsets.fromLTRB(31, 22, 27, 22),
          decoration: BoxDecoration(
            color: widget.item.color,
            borderRadius: BorderRadius.circular(72),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFBDB6AD).withValues(alpha: 0.22),
                blurRadius: 36,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: Row(
            children: [
              _MixedIconBadge(
                color: widget.item.accent,
                pressed: _pressed,
              ),
              const SizedBox(width: 28),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _breakAtFirstSpace(widget.title),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 26,
                        height: 1.18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                        color: widget.item.titleColor,
                      ),
                    ),
                    const SizedBox(height: 17),
                    SizedBox(
                      width: 132,
                      child: _SketchProgress(
                        value: widget.item.progress,
                        color: widget.item.accent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${_capitalize(widget.levelLabel)} ${widget.item.level}',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 30,
                    height: 1,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.1,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _breakAtFirstSpace(String value) {
    final spaceIndex = value.indexOf(' ');
    if (spaceIndex <= 0 || spaceIndex == value.length - 1) {
      return value;
    }

    return '${value.substring(0, spaceIndex)}\n${value.substring(spaceIndex + 1)}';
  }

  String _capitalize(String value) {
    if (value.isEmpty) {
      return value;
    }

    return value.substring(0, 1).toUpperCase() + value.substring(1).toLowerCase();
  }
}

class _MixedIconBadge extends StatelessWidget {
  const _MixedIconBadge({
    required this.color,
    required this.pressed,
  });

  final Color color;
  final bool pressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOutCubic,
      width: 82,
      height: 82,
      transform: Matrix4.translationValues(0, pressed ? 4 : 0, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(6, pressed ? 4 : 8),
          ),
        ],
      ),
      child: Icon(
        Icons.star_rounded,
        color: color.withValues(alpha: 0.55),
        size: 43,
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  const _LevelBadge({
    required this.label,
    required this.level,
    required this.color,
  });

  final String label;
  final String level;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31,
      constraints: const BoxConstraints(minWidth: 92),
      padding: const EdgeInsets.symmetric(horizontal: 13),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.black, width: 2.8),
      ),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          '$label $level',
          maxLines: 1,
          style: const TextStyle(
            fontSize: 12,
            height: 1,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _SketchProgress extends StatelessWidget {
  const _SketchProgress({
    required this.value,
    required this.color,
  });

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 17,
      decoration: BoxDecoration(
        color: const Color(0xFFE6E1DB),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.black, width: 2.6),
      ),
      clipBehavior: Clip.antiAlias,
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: FractionallySizedBox(
          widthFactor: value.clamp(0.0, 1.0).toDouble(),
          heightFactor: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(color: color),
          ),
        ),
      ),
    );
  }
}

class _Reveal extends StatelessWidget {
  const _Reveal({
    required this.controller,
    required this.begin,
    required this.end,
    required this.offset,
    required this.child,
  });

  final AnimationController controller;
  final double begin;
  final double end;
  final Offset offset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: child,
      builder: (context, child) {
        final progress =
            ((controller.value - begin) / (end - begin)).clamp(0.0, 1.0);
        final eased = Curves.easeOutCubic.transform(progress.toDouble());

        return Opacity(
          opacity: eased,
          child: Transform.translate(
            offset: Offset(
              offset.dx * (1 - eased),
              offset.dy * (1 - eased),
            ),
            child: Transform.scale(
              scale: 0.965 + (0.035 * eased),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class _CardPatternPainter extends CustomPainter {
  const _CardPatternPainter({
    required this.pattern,
    required this.color,
  });

  final _CardPattern pattern;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (pattern == _CardPattern.none) {
      return;
    }

    final paint = Paint()
      ..color = color.withValues(alpha: 0.10)
      ..strokeWidth = 1;

    if (pattern == _CardPattern.dots) {
      for (var y = 18.0; y < size.height; y += 17) {
        for (var x = 18.0; x < size.width; x += 17) {
          canvas.drawCircle(Offset(x, y), 1.1, paint);
        }
      }
      return;
    }

    for (var i = -size.height; i < size.width + size.height; i += 8) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_CardPatternPainter oldDelegate) {
    return pattern != oldDelegate.pattern || color != oldDelegate.color;
  }
}

class _BlueAvatarPainter extends CustomPainter {
  const _BlueAvatarPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFF0A1E25),
    );
    canvas.drawCircle(
      Offset(w * 0.5, h * 0.58),
      w * 0.43,
      Paint()..color = const Color(0xFF163640),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.48),
        width: w * 0.56,
        height: h * 0.72,
      ),
      Paint()..color = const Color(0xFF2A8CA0),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.17, h * 0.20)
        ..quadraticBezierTo(w * 0.50, h * 0.02, w * 0.83, h * 0.20)
        ..lineTo(w * 0.72, h * 0.62)
        ..quadraticBezierTo(w * 0.50, h * 0.75, w * 0.28, h * 0.62)
        ..close(),
      Paint()..color = const Color(0xFF11151B).withValues(alpha: 0.72),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.12, h * 0.44)
        ..lineTo(w * 0.28, h * 0.35)
        ..lineTo(w * 0.25, h * 0.57)
        ..close(),
      Paint()..color = const Color(0xFF4AA5B6),
    );
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.88, h * 0.44)
        ..lineTo(w * 0.72, h * 0.35)
        ..lineTo(w * 0.75, h * 0.57)
        ..close(),
      Paint()..color = const Color(0xFF4AA5B6),
    );

    final stripePaint = Paint()
      ..color = const Color(0xFF73D1DB).withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawLine(Offset(w * 0.40, h * 0.22), Offset(w * 0.33, h * 0.66), stripePaint);
    canvas.drawLine(Offset(w * 0.60, h * 0.22), Offset(w * 0.67, h * 0.66), stripePaint);
    canvas.drawLine(Offset(w * 0.50, h * 0.25), Offset(w * 0.50, h * 0.69), stripePaint);

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.39, h * 0.48),
        width: w * 0.08,
        height: h * 0.045,
      ),
      Paint()..color = const Color(0xFFFFD45C),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.61, h * 0.48),
        width: w * 0.08,
        height: h * 0.045,
      ),
      Paint()..color = const Color(0xFFFFD45C),
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.61),
        width: w * 0.20,
        height: h * 0.10,
      ),
      0.15,
      math.pi - 0.30,
      false,
      Paint()
        ..color = const Color(0xFF06262B)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4,
    );
  }

  @override
  bool shouldRepaint(_BlueAvatarPainter oldDelegate) => false;
}

class _AdventureItem {
  const _AdventureItem({
    required this.category,
    required this.level,
    required this.progress,
    required this.color,
    required this.accent,
    required this.titleColor,
    required this.icon,
    required this.pattern,
    required this.tilt,
  });

  final QuizCategory category;
  final String level;
  final double progress;
  final Color color;
  final Color accent;
  final Color titleColor;
  final IconData icon;
  final _CardPattern pattern;
  final double tilt;
}

enum _CardPattern {
  none,
  dots,
  stripes,
}

extension _QuizCategoryCopy on QuizCategory {
  QuizCategory copyAs({
    String? id,
    String? labelKey,
    IconData? icon,
    Color? color,
  }) {
    return QuizCategory(
      id: id ?? this.id,
      labelKey: labelKey ?? this.labelKey,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      levels: levels,
    );
  }
}
