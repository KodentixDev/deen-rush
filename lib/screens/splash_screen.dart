import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final introController = useAnimationController(
      duration: const Duration(milliseconds: 900),
    );
    final pulseController = useAnimationController(
      duration: const Duration(milliseconds: 1800),
    );
    final loadingController = useAnimationController(
      duration: const Duration(milliseconds: 3400),
    );

    useEffect(
      () {
        introController.forward(from: 0);
        pulseController.repeat(reverse: true);
        loadingController.forward(from: 0);

        _playQuizIntroSound();

        return () {
          pulseController.stop();
          loadingController.stop();
        };
      },
      [introController, pulseController, loadingController],
    );

    useEffect(
      () {
        void listener(AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            onCompleted();
          }
        }

        loadingController.addStatusListener(listener);
        return () => loadingController.removeStatusListener(listener);
      },
      [loadingController, onCompleted],
    );

    final intro = Curves.easeOutCubic.transform(useAnimation(introController));
    final pulse = Curves.easeInOut.transform(useAnimation(pulseController));
    final progress = Curves.easeInOutCubic.transform(useAnimation(loadingController));

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8E45FE),
              Color(0xFF7E46FB),
              Color(0xFF5F6DF6),
            ],
          ),
        ),
        child: Stack(
          children: [
            const Positioned.fill(child: _SplashBackground()),
            SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(28, 18, 28, 26),
                    child: Column(
                      children: [
                        const Spacer(flex: 2),
                        Transform.translate(
                          offset: Offset(0, 24 * (1 - intro)),
                          child: Opacity(
                            opacity: intro,
                            child: Transform.scale(
                              scale: 0.92 + (0.08 * intro) + (0.01 * pulse),
                              child: Text(
                                strings.text('splashBrandWord'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 48,
                                  height: 1,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFFFFD83D),
                                  shadows: [
                                    Shadow(
                                      color: const Color(0xAA7A2C00),
                                      offset: const Offset(0, 5),
                                      blurRadius: 10 + (8 * pulse),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Transform.translate(
                          offset: Offset(0, 18 * (1 - intro)),
                          child: Opacity(
                            opacity: intro,
                            child: Text(
                              strings.text('splashMainTitle'),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 26,
                                height: 1.08,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Opacity(
                          opacity: 0.7 + (0.3 * intro),
                          child: Text(
                            strings.text('splashDescription'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.35,
                              fontWeight: FontWeight.w500,
                              color: Color(0xD9FFFFFF),
                            ),
                          ),
                        ),
                        const SizedBox(height: 34),
                        Transform.translate(
                          offset: Offset(0, -2 * pulse),
                          child: _PlayNowButton(
                            label: strings.text('splashPlayNow'),
                            onTap: onCompleted,
                          ),
                        ),
                        const Spacer(flex: 3),
                        Text(
                          strings.text('splashLoginWithText'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xCCFFFFFF),
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _LoginBubble(
                              child: Text(
                                'G',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF35A1FF),
                                ),
                              ),
                            ),
                            SizedBox(width: 18),
                            _LoginBubble(
                              child: Icon(
                                Icons.apple_rounded,
                                size: 28,
                                color: Color(0xFF35A1FF),
                              ),
                            ),
                            SizedBox(width: 18),
                            _LoginBubble(
                              child: Icon(
                                Icons.facebook_rounded,
                                size: 28,
                                color: Color(0xFF35A1FF),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(flex: 2),
                        _LoadingFooter(
                          progress: progress,
                          label: strings.text('splashLoadingNow'),
                        ),
                      ],
                    ),
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

class _SplashBackground extends StatelessWidget {
  const _SplashBackground();

  @override
  Widget build(BuildContext context) => Stack(
        children: const [
          _Ring(top: -84, right: -74, size: 280),
          _Ring(top: 48, left: -210, size: 360),
          _Glow(top: -10, right: -20, size: 200),
          _Glow(bottom: -40, left: -28, size: 130),
        ],
      );
}

class _Ring extends StatelessWidget {
  const _Ring({
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
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.12),
              width: 1,
            ),
          ),
        ),
      );
}

class _Glow extends StatelessWidget {
  const _Glow({
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
                Colors.white.withValues(alpha: 0.10),
                Colors.white.withValues(alpha: 0),
              ],
            ),
          ),
        ),
      );
}

class _PlayNowButton extends StatelessWidget {
  const _PlayNowButton({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(26),
          child: Ink(
            width: 170,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFFFDF3F),
              borderRadius: BorderRadius.circular(26),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x558B5A00),
                  blurRadius: 14,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.play_arrow_rounded,
                  color: Color(0xFF9A6100),
                  size: 26,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF9A6100),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _LoginBubble extends StatelessWidget {
  const _LoginBubble({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Color(0x3329C5F6),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: child,
      );
}

class _LoadingFooter extends StatelessWidget {
  const _LoadingFooter({
    required this.progress,
    required this.label,
  });

  final double progress;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Container(
              width: double.infinity,
              height: 10,
              color: Colors.white.withValues(alpha: 0.18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFFDF3F),
                          Color(0xFFFFC92E),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Dot(active: progress > 0.2),
              const SizedBox(width: 6),
              _Dot(active: progress > 0.55),
              const SizedBox(width: 6),
              _Dot(active: progress > 0.85),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      );
}

class _Dot extends StatelessWidget {
  const _Dot({
    required this.active,
  });

  final bool active;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 7,
        height: 7,
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFFFFDF3F)
              : Colors.white.withValues(alpha: 0.35),
          shape: BoxShape.circle,
        ),
      );
}

void _playQuizIntroSound() {
  Future<void>(() async {
    try {
      SystemSound.play(SystemSoundType.click);
      await Future<void>.delayed(const Duration(milliseconds: 140));
      SystemSound.play(SystemSoundType.click);
      await Future<void>.delayed(const Duration(milliseconds: 180));
      SystemSound.play(SystemSoundType.alert);
    } catch (_) {
      // System sounds are best-effort and can be unavailable on some devices.
    }
  });
}
