import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../l10n/app_strings.dart';
import 'duel_selection_models.dart';

class DuelBackground extends StatelessWidget {
  const DuelBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: 92,
            right: -148,
            child: Container(
              width: 380,
              height: 460,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFBDF3D5).withValues(alpha: 0.42),
                    const Color(0xFFBDF3D5).withValues(alpha: 0.05),
                    const Color(0x00BDF3D5),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: -120,
            bottom: -110,
            child: Container(
              width: 300,
              height: 300,
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

class DuelHeader extends StatelessWidget {
  const DuelHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);

    return SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const PositionedDirectional(
            start: 0,
            child: Icon(
              Icons.star_rounded,
              size: 30,
              color: Color(0xFFFF7A67),
            ),
          ),
          Text(
            strings.appName.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 29,
              height: 1,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.6,
              color: Colors.black,
            ),
          ),
          PositionedDirectional(
            end: 0,
            child: Container(
              width: 46,
              height: 46,
              padding: const EdgeInsets.all(2.2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
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

class DuelHero extends StatelessWidget {
  const DuelHero({
    super.key,
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
            fontSize: 34,
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
        const SizedBox(height: 6),
        Text(
          strings.text('duelAdventure'),
          style: const TextStyle(
            fontSize: 36,
            height: 0.96,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.1,
            color: Color(0xFFB33B2E),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          strings.text('duelLevelUp'),
          style: const TextStyle(
            fontSize: 18,
            height: 1,
            fontWeight: FontWeight.w700,
            color: Color(0xFF6D6762),
            fontFamily: 'serif',
          ),
        ),
      ],
    );
  }
}

class DuelHintChip extends StatelessWidget {
  const DuelHintChip({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF0E9E2).withValues(alpha: 0.7),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.touch_app_rounded,
            size: 18,
            color: Color(0xFFB7462F),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF5A5552),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DuelAdventureCard extends StatefulWidget {
  const DuelAdventureCard({
    super.key,
    required this.item,
    required this.title,
    required this.levelLabel,
    required this.onTap,
  });

  final DuelAdventureItem item;
  final String title;
  final String levelLabel;
  final VoidCallback onTap;

  @override
  State<DuelAdventureCard> createState() => _DuelAdventureCardState();
}

class _DuelAdventureCardState extends State<DuelAdventureCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.968 : 1,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,
        child: Transform.rotate(
          angle: widget.item.tilt,
          child: SizedBox(
            height: 218,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  top: 26,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 140),
                    curve: Curves.easeOutCubic,
                    transform: Matrix4.translationValues(0, _pressed ? 4 : 0, 0),
                    decoration: BoxDecoration(
                      color: widget.item.color,
                      borderRadius: BorderRadius.circular(42),
                      boxShadow: [
                        BoxShadow(
                          color: widget.item.color.withValues(alpha: 0.22),
                          blurRadius: 24,
                          offset: const Offset(0, 18),
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
                  top: 26,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 54, 14, 18),
                    child: Column(
                      children: [
                        Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 19,
                            height: 1.04,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            color: widget.item.titleColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        DuelLevelBadge(
                          label: widget.levelLabel,
                          level: widget.item.level,
                          color: widget.item.accent,
                        ),
                        const Spacer(),
                        DuelSketchProgress(
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
                  child: _DuelAdventureIconBadge(
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

class DuelMixedQuizCard extends StatefulWidget {
  const DuelMixedQuizCard({
    super.key,
    required this.item,
    required this.title,
    required this.levelLabel,
    required this.onTap,
  });

  final DuelAdventureItem item;
  final String title;
  final String levelLabel;
  final VoidCallback onTap;

  @override
  State<DuelMixedQuizCard> createState() => _DuelMixedQuizCardState();
}

class _DuelMixedQuizCardState extends State<DuelMixedQuizCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.986 : 1,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOutCubic,
          height: 118,
          transform: Matrix4.translationValues(0, _pressed ? 4 : 0, 0),
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
          decoration: BoxDecoration(
            color: widget.item.color,
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFBDB6AD).withValues(alpha: 0.22),
                blurRadius: 28,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Row(
            children: [
              _DuelMixedIconBadge(
                color: widget.item.accent,
                pressed: _pressed,
              ),
              const SizedBox(width: 18),
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
                        fontSize: 18,
                        height: 1.14,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.4,
                        color: widget.item.titleColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 112,
                      child: DuelSketchProgress(
                        value: widget.item.progress,
                        color: widget.item.accent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${_capitalize(widget.levelLabel)} ${widget.item.level}',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 24,
                    height: 1,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
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

class DuelLevelBadge extends StatelessWidget {
  const DuelLevelBadge({
    super.key,
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
      height: 29,
      constraints: const BoxConstraints(minWidth: 86),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.16),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          '$label $level',
          maxLines: 1,
          style: const TextStyle(
            fontSize: 11,
            height: 1,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class DuelSketchProgress extends StatelessWidget {
  const DuelSketchProgress({
    super.key,
    required this.value,
    required this.color,
  });

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 14,
      decoration: BoxDecoration(
        color: const Color(0xFFF2EEE8),
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
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

class DuelReveal extends StatelessWidget {
  const DuelReveal({
    super.key,
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
              scale: 0.97 + (0.03 * eased),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class _DuelAdventureIconBadge extends StatelessWidget {
  const _DuelAdventureIconBadge({
    required this.item,
    required this.pressed,
  });

  final DuelAdventureItem item;
  final bool pressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,
        width: 72,
        height: 78,
        transform: Matrix4.translationValues(0, pressed ? 3 : 0, 0),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FFF6),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: item.accent.withValues(alpha: 0.18),
              blurRadius: 14,
              offset: Offset(0, pressed ? 3 : 8),
            ),
          ],
        ),
        child: Icon(
          item.icon,
          size: 34,
          color: item.accent,
        ),
      ),
    );
  }
}

class _DuelMixedIconBadge extends StatelessWidget {
  const _DuelMixedIconBadge({
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
      width: 64,
      height: 64,
      transform: Matrix4.translationValues(0, pressed ? 3 : 0, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.16),
            blurRadius: 12,
            offset: Offset(0, pressed ? 3 : 7),
          ),
        ],
      ),
      child: Icon(
        Icons.star_rounded,
        color: color.withValues(alpha: 0.55),
        size: 34,
      ),
    );
  }
}

class _CardPatternPainter extends CustomPainter {
  const _CardPatternPainter({
    required this.pattern,
    required this.color,
  });

  final DuelCardPattern pattern;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (pattern == DuelCardPattern.none) {
      return;
    }

    final paint = Paint()
      ..color = color.withValues(alpha: 0.10)
      ..strokeWidth = 1;

    if (pattern == DuelCardPattern.dots) {
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
    canvas.drawLine(
      Offset(w * 0.40, h * 0.22),
      Offset(w * 0.33, h * 0.66),
      stripePaint,
    );
    canvas.drawLine(
      Offset(w * 0.60, h * 0.22),
      Offset(w * 0.67, h * 0.66),
      stripePaint,
    );
    canvas.drawLine(
      Offset(w * 0.50, h * 0.25),
      Offset(w * 0.50, h * 0.69),
      stripePaint,
    );

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
