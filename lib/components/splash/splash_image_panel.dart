import 'package:flutter/material.dart';

import '../../config/app_assets.dart';

class SplashImagePanel extends StatelessWidget {
  const SplashImagePanel({
    super.key,
    required this.size,
    required this.pulse,
  });

  final double size;
  final double pulse;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size + 120,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: size * 1.08,
            height: size * 1.08,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Color(0x4DFFFFFF),
                  Color(0x00FFFFFF),
                ],
              ),
            ),
          ),
          Transform.rotate(
            angle: -0.08,
            child: Container(
              width: size * 1.02,
              height: size * 1.02,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size * 0.2),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.22),
                  width: 2,
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0x26FFFFFF),
                    Color(0x06FFFFFF),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            left: -8,
            top: 124,
            child: _GlowBubble(size: 62),
          ),
          const Positioned(
            left: 20,
            top: 42,
            child: _GlowBubble(size: 44, alpha: 0.14),
          ),
          const Positioned(
            right: -10,
            top: 100,
            child: _GlowBubble(size: 74),
          ),
          const Positioned(
            right: 28,
            top: 164,
            child: _GlowBubble(size: 56, alpha: 0.15),
          ),
          const Positioned(
            left: 6,
            top: 90,
            child: _StampDot(color: Color(0xFFD95D52), angle: -0.28),
          ),
          const Positioned(
            right: 4,
            top: 104,
            child: _StampDot(color: Color(0xFF27B7BA), angle: -0.22),
          ),
          const Positioned(
            right: 16,
            top: 202,
            child: _StampDot(color: Color(0xFFA55CDD), angle: -0.34),
          ),
          const Positioned(
            top: 22,
            child: _SparkleStar(size: 18),
          ),
          const Positioned(
            left: 48,
            top: 72,
            child: _SparkleStar(size: 12),
          ),
          const Positioned(
            right: 54,
            top: 66,
            child: _SparkleStar(size: 14),
          ),
          Transform.scale(
            scale: pulse,
            child: Container(
              width: size,
              height: size,
              padding: EdgeInsets.all(size * 0.1),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(size * 0.18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.14),
                    blurRadius: 42,
                    offset: const Offset(0, 24),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size * 0.14),
                  border: Border.all(
                    color: const Color(0xFF19B7C3).withValues(alpha: 0.14),
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x1419B7C3),
                      Color(0x141FC46B),
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(size * 0.08),
                  child: Image.asset(
                    AppAssets.logo,
                    fit: BoxFit.contain,
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

class _GlowBubble extends StatelessWidget {
  const _GlowBubble({
    required this.size,
    this.alpha = 0.12,
  });

  final double size;
  final double alpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: alpha),
      ),
    );
  }
}

class _StampDot extends StatelessWidget {
  const _StampDot({
    required this.color,
    required this.angle,
  });

  final Color color;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: 28,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.86),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ),
    );
  }
}

class _SparkleStar extends StatelessWidget {
  const _SparkleStar({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.auto_awesome_rounded,
      size: size,
      color: const Color(0xFFFCEB8A),
    );
  }
}
