import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../config/app_assets.dart';
import '../config/app_theme.dart';
import '../hooks/use_splash_transition.dart';
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
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 2600),
    );

    useEffect(
      () {
        controller.repeat(reverse: true);
        return controller.stop;
      },
      [controller],
    );

    useSplashTransition(
      onCompleted,
      delay: const Duration(milliseconds: 2600),
    );

    final tick = useAnimation(controller);
    final wave = Curves.easeInOutSine.transform(tick);
    final scale = 0.96 + (0.06 * wave);
    final progress = 0.36 + (0.5 * wave);

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF061421),
              Color(0xFF0E2B40),
              Color(0xFF1CB6C3),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: Column(
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 280,
                      height: 280,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          _GlowOrb(
                            size: 280,
                            color: AppTheme.primary.withValues(alpha: 0.22),
                          ),
                          _GlowOrb(
                            size: 220,
                            color:
                                const Color(0xFFD8FF57).withValues(alpha: 0.16),
                          ),
                          Positioned(
                            top: 26 + (8 * math.sin(tick * math.pi * 2)),
                            right: 16,
                            child: const _FloatingTag(
                              icon: Icons.auto_awesome_rounded,
                              label: 'Quiz',
                            ),
                          ),
                          Positioned(
                            bottom: 30 + (6 * math.cos(tick * math.pi * 2)),
                            left: 10,
                            child: const _FloatingTag(
                              icon: Icons.bolt_rounded,
                              label: 'Fast',
                            ),
                          ),
                          Transform.scale(
                            scale: scale,
                            child: Container(
                              width: 178,
                              height: 178,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFFFFFFF),
                                    Color(0xFFE9FBFC),
                                  ],
                                ),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.14),
                                    blurRadius: 36,
                                    offset: const Offset(0, 20),
                                  ),
                                ],
                              ),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppTheme.primary,
                                      Color(0xFF7AD6DB),
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: ClipOval(
                                    child: Image.asset(
                                      AppAssets.logo,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      strings.appName,
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Colors.white,
                              ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      strings.splashTagline,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white.withValues(alpha: 0.96),
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      strings.splashCaption,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white.withValues(alpha: 0.72),
                          ),
                    ),
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.12),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                strings.text('splashLoading'),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                              const Spacer(),
                              Text(
                                '${(progress * 100).round()}%',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.white.withValues(alpha: 0.86),
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              minHeight: 9,
                              value: progress,
                              backgroundColor:
                                  Colors.white.withValues(alpha: 0.12),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFFD8FF57),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color,
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

class _FloatingTag extends StatelessWidget {
  const _FloatingTag({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
