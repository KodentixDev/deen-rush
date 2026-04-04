import 'package:flutter/material.dart';

import '../../l10n/app_strings.dart';

class SplashFooter extends StatelessWidget {
  const SplashFooter({
    super.key,
    required this.strings,
    required this.progress,
  });

  final AppStrings strings;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        children: [
          Text(
            strings.splashTagline,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            strings.splashCaption,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.84),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 18),
          _SplashProgressBar(progress: progress),
          const SizedBox(height: 18),
          Text(
            '\u00A9 DEENRUSH STUDIOS',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.72),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashProgressBar extends StatelessWidget {
  const _SplashProgressBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: Container(
          height: 9,
          color: Colors.white.withValues(alpha: 0.2),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final fillWidth = constraints.maxWidth * progress;
              final glowPosition =
                  (fillWidth - 10).clamp(2.0, constraints.maxWidth - 14.0);

              return Stack(
                children: [
                  Container(
                    width: fillWidth,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF54D0D4),
                          Color(0xFFFFD46F),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  Positioned(
                    left: glowPosition,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF2B2),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFFD46F).withValues(alpha: 0.68),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
