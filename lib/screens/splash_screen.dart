import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../l10n/app_strings.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({
    super.key,
    required this.onCompleted,
  });

  final VoidCallback onCompleted;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final ambienceController = useAnimationController(
      duration: const Duration(milliseconds: 2300),
    );
    final loadingController = useAnimationController(
      duration: const Duration(milliseconds: 3200),
    );

    useEffect(
      () {
        ambienceController.repeat(reverse: true);
        loadingController.forward(from: 0);

        return () {
          ambienceController.stop();
          loadingController.stop();
        };
      },
      [ambienceController, loadingController],
    );

    useEffect(
      () {
        void handleStatus(AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            onCompleted();
          }
        }

        loadingController.addStatusListener(handleStatus);
        return () => loadingController.removeStatusListener(handleStatus);
      },
      [loadingController, onCompleted],
    );

    final ambienceTick = useAnimation(ambienceController);
    final loadingTick = useAnimation(loadingController);
    final pulse = Curves.easeInOut.transform(ambienceTick);
    final drift = math.sin(ambienceTick * math.pi * 2);
    final progress = Curves.easeInOutCubic.transform(loadingTick);
    final reveal = Curves.easeOutBack.transform(
      (loadingTick / 0.32).clamp(0.0, 1.0),
    );
    final titleDrift = math.sin((ambienceTick * math.pi * 2) + 0.8);
    final subtitleDrift = math.cos((ambienceTick * math.pi * 2) + 1.2);

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color(0xFFF9F3EF),
        ),
        child: Stack(
          children: [
            Positioned(
              left: -160 + (20 * drift),
              top: -40,
              child: const _BackdropGlow(
                width: 430,
                height: 520,
                colors: [
                  Color(0x33FF8D79),
                  Color(0x11FFCFC6),
                  Colors.transparent,
                ],
              ),
            ),
            Positioned(
              right: -150 - (14 * drift),
              top: 220,
              child: const _BackdropGlow(
                width: 440,
                height: 860,
                colors: [
                  Color(0x33B7A7FF),
                  Color(0x1ADFD7FF),
                  Colors.transparent,
                ],
              ),
            ),
            Positioned(
              left: -120 + (10 * drift),
              bottom: -120 - (8 * drift),
              child: Transform.rotate(
                angle: -0.22 + (0.03 * drift),
                child: Container(
                  width: 320,
                  height: 260,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDF4E8),
                    borderRadius: BorderRadius.circular(92),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      final badgeSize =
                          (width * 0.31).clamp(138.0, 164.0).toDouble();
                      final titleSize =
                          (width * 0.15).clamp(46.0, 60.0).toDouble();

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(28, 18, 28, 28),
                        child: Column(
                          children: [
                            SizedBox(
                              height:
                                  (constraints.maxHeight * 0.13) + (10 * (1 - reveal)),
                            ),
                            Transform.translate(
                              offset: Offset(0, (-8 * pulse) + ((1 - reveal) * 18)),
                              child: Transform.rotate(
                                angle: 0.015 * drift,
                                child: _SplashBadge(
                                  size: badgeSize,
                                  pulse: pulse,
                                  drift: drift,
                                ),
                              ),
                            ),
                            const SizedBox(height: 26),
                            Opacity(
                              opacity: (0.35 + (0.65 * reveal)).clamp(0.0, 1.0),
                              child: Transform.translate(
                                offset: Offset(0, (20 * (1 - reveal)) - (3 * titleDrift)),
                                child: Transform.scale(
                                  scale: 0.95 + (0.05 * reveal),
                                  child: Text(
                                    'DEENRUSH',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: titleSize,
                                      height: 0.92,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -2.4,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Opacity(
                              opacity: (0.2 + (0.8 * reveal)).clamp(0.0, 1.0),
                              child: Transform.translate(
                                offset: Offset(0, (14 * (1 - reveal)) - (2 * subtitleDrift)),
                                child: Text(
                                  strings.text('splashHeadline'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 3,
                                    color: Color(0xFF8E8890),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Transform.translate(
                              offset: Offset(0, -2 * pulse),
                              child: _SplashProgressBar(
                                progress: progress,
                                pulse: pulse,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _LoadingCaption(
                              pulse: pulse,
                              drift: drift,
                              message: strings.text('splashLoading'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackdropGlow extends StatelessWidget {
  const _BackdropGlow({
    required this.width,
    required this.height,
    required this.colors,
  });

  final double width;
  final double height;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: colors,
            radius: 0.82,
          ),
        ),
      ),
    );
  }
}

class _SplashBadge extends StatelessWidget {
  const _SplashBadge({
    required this.size,
    required this.pulse,
    required this.drift,
  });

  final double size;
  final double pulse;
  final double drift;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 1.9,
      height: size * 1.55,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            left: size * 0.02,
            top: (size * 0.78) + (4 * drift),
            child: const _GearBloom(),
          ),
          Positioned(
            right: (size * 0.22) - (5 * drift),
            top: (size * 0.12) - (3 * drift),
            child: Transform.rotate(
              angle: 0.08 * drift,
              child: const _SparkleCluster(),
            ),
          ),
          Transform.rotate(
            angle: -0.03 + (0.03 * pulse),
            child: Transform.scale(
              scale: 0.985 + (0.018 * pulse),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF7A67),
                  borderRadius: BorderRadius.circular(size * 0.34),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x22FF7A67),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.star_rounded,
                    size: size * 0.56,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GearBloom extends StatelessWidget {
  const _GearBloom();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipPath(
            clipper: const _BurstClipper(points: 8, innerRadiusFactor: 0.73),
            child: Container(
              width: 48,
              height: 48,
              color: const Color(0xFF0A7A63),
            ),
          ),
          Container(
            width: 21,
            height: 21,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0A7A63),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SparkleCluster extends StatelessWidget {
  const _SparkleCluster();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46,
      height: 38,
      child: Stack(
        clipBehavior: Clip.none,
        children: const [
          Positioned(
            left: 0,
            top: 6,
            child: _Sparkle(size: 20),
          ),
          Positioned(
            left: 20,
            top: 0,
            child: _Sparkle(size: 10),
          ),
          Positioned(
            left: 22,
            top: 18,
            child: _Sparkle(size: 12),
          ),
        ],
      ),
    );
  }
}

class _Sparkle extends StatelessWidget {
  const _Sparkle({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const _BurstClipper(points: 4, innerRadiusFactor: 0.32),
      child: Container(
        width: size,
        height: size,
        color: const Color(0xFF6C50D8),
      ),
    );
  }
}

class _SplashProgressBar extends StatelessWidget {
  const _SplashProgressBar({
    required this.progress,
    required this.pulse,
  });

  final double progress;
  final double pulse;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              const knobSize = 48.0;
              final trackWidth = constraints.maxWidth;
              final activeWidth = trackWidth * progress;
              final knobLeft = (activeWidth - (knobSize / 2))
                  .clamp(0.0, trackWidth - knobSize)
                  .toDouble();

              return SizedBox(
                height: 64,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D5CE),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 9,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: activeWidth.clamp(0.0, trackWidth - 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFAA3F2C),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: knobLeft,
                      child: Transform.translate(
                        offset: Offset(0, -2 * pulse),
                        child: Container(
                          width: knobSize,
                          height: knobSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.14),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.star_rounded,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LoadingCaption extends StatelessWidget {
  const _LoadingCaption({
    required this.pulse,
    required this.drift,
    required this.message,
  });

  final double pulse;
  final double drift;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _StatusDot(
          color: const Color(0xFF0A7A63),
          scale: 0.92 + (0.18 * pulse),
        ),
        const SizedBox(width: 16),
        Text(
          message,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: Color(0xFF5B5B5B),
          ),
        ),
        const SizedBox(width: 16),
        _StatusDot(
          color: const Color(0xFFB7462F),
          scale: 0.92 + (0.18 * ((drift + 1) / 2)),
        ),
      ],
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({
    required this.color,
    required this.scale,
  });

  final Color color;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}

class _BurstClipper extends CustomClipper<Path> {
  const _BurstClipper({
    required this.points,
    required this.innerRadiusFactor,
  });

  final int points;
  final double innerRadiusFactor;

  @override
  Path getClip(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = math.min(size.width, size.height) / 2;
    final innerRadius = outerRadius * innerRadiusFactor;
    final path = Path();

    for (var i = 0; i < points * 2; i++) {
      final radius = i.isEven ? outerRadius : innerRadius;
      final angle = (-math.pi / 2) + ((math.pi / points) * i);
      final point = Offset(
        center.dx + (radius * math.cos(angle)),
        center.dy + (radius * math.sin(angle)),
      );

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(_BurstClipper oldClipper) {
    return points != oldClipper.points ||
        innerRadiusFactor != oldClipper.innerRadiusFactor;
  }
}
