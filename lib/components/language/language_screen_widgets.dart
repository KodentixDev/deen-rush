import 'package:flutter/material.dart';

class LanguageBackground extends StatelessWidget {
  const LanguageBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: const [
      Positioned.fill(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF8E45FE), Color(0xFF6E68F8)],
            ),
          ),
        ),
      ),
      _LanguageSoftGlow(top: -40, right: -52, size: 200),
      _LanguageSoftGlow(bottom: -30, left: -30, size: 160),
    ]);
  }
}

class LanguageBackCircle extends StatelessWidget {
  const LanguageBackCircle({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.14),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
        ),
      );
}

class _LanguageSoftGlow extends StatelessWidget {
  const _LanguageSoftGlow({
    this.top,
    this.right,
    this.bottom,
    this.left,
    required this.size,
  });

  final double? top;
  final double? right;
  final double? bottom;
  final double? left;
  final double size;

  @override
  Widget build(BuildContext context) => Positioned(
        top: top,
        right: right,
        bottom: bottom,
        left: left,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.white.withValues(alpha: 0.08),
                Colors.white.withValues(alpha: 0),
              ],
            ),
          ),
        ),
      );
}
