import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../config/app_assets.dart';
import '../l10n/app_strings.dart';

class OnboardingScreen extends HookWidget {
  const OnboardingScreen({
    super.key,
    required this.onCompleted,
  });

  final VoidCallback onCompleted;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final controller = usePageController();
    final pageIndex = useState(0);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final pages = [
      _OnboardingData(
        title: strings.text('onboardingTitle1'),
        body: strings.text('onboardingBody1'),
        badge: strings.text('homeCategory'),
        icon: Icons.menu_book_rounded,
        start: const Color(0xFF1CB6C3),
        end: const Color(0xFF92E8EC),
      ),
      _OnboardingData(
        title: strings.text('onboardingTitle2'),
        body: strings.text('onboardingBody2'),
        badge: strings.text('progressTitle'),
        icon: Icons.bolt_rounded,
        start: const Color(0xFFD8FF57),
        end: const Color(0xFFFFC94A),
      ),
      _OnboardingData(
        title: strings.text('onboardingTitle3'),
        body: strings.text('onboardingBody3'),
        badge: strings.text('settingsTitle'),
        icon: Icons.tune_rounded,
        start: const Color(0xFF7AD6DB),
        end: const Color(0xFF21B573),
      ),
    ];

    Future<void> goNext() async {
      if (pageIndex.value == pages.length - 1) {
        onCompleted();
        return;
      }

      await controller.animateToPage(
        pageIndex.value + 1,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    }

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? const [
                    Color(0xFF07131F),
                    Color(0xFF0E2030),
                    Color(0xFF123850),
                  ]
                : const [
                    Color(0xFFF4FBFC),
                    Color(0xFFEAF9FB),
                    Color(0xFFF9FCEB),
                  ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: onCompleted,
                        child: Text(strings.text('onboardingSkip')),
                      ),
                    ),
                    Expanded(
                      child: NotificationListener<ScrollUpdateNotification>(
                        onNotification: (notification) {
                          final nextPage =
                              controller.page?.round() ?? pageIndex.value;
                          if (nextPage != pageIndex.value) {
                            pageIndex.value = nextPage;
                          }
                          return false;
                        },
                        child: PageView.builder(
                          controller: controller,
                          itemCount: pages.length,
                          itemBuilder: (context, index) {
                            final page = pages[index];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _OnboardingIllustration(page: page),
                                ),
                                const SizedBox(height: 28),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Colors.white.withValues(alpha: 0.08)
                                        : Colors.white.withValues(alpha: 0.88),
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(
                                      color: isDark
                                          ? Colors.white.withValues(alpha: 0.08)
                                          : Colors.white,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipOval(
                                        child: Image.asset(
                                          AppAssets.logo,
                                          width: 22,
                                          height: 22,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        page.badge,
                                        style: theme.textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 22),
                                Text(
                                  page.title,
                                  style: theme.textTheme.headlineMedium,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  page.body,
                                  style: theme.textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 24),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Row(
                      children: List.generate(
                        pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          margin: const EdgeInsets.only(right: 8),
                          width: pageIndex.value == index ? 28 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: pageIndex.value == index
                                ? const Color(0xFF1CB6C3)
                                : Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: onCompleted,
                            child: Text(strings.text('onboardingSkip')),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: goNext,
                            child: Text(
                              pageIndex.value == pages.length - 1
                                  ? strings.text('onboardingStart')
                                  : strings.text('onboardingNext'),
                            ),
                          ),
                        ),
                      ],
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

class _OnboardingData {
  const _OnboardingData({
    required this.title,
    required this.body,
    required this.badge,
    required this.icon,
    required this.start,
    required this.end,
  });

  final String title;
  final String body;
  final String badge;
  final IconData icon;
  final Color start;
  final Color end;
}

class _OnboardingIllustration extends StatelessWidget {
  const _OnboardingIllustration({
    required this.page,
  });

  final _OnboardingData page;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Positioned(
          top: 12,
          right: 12,
          child: _SoftOrb(
            size: 120,
            color: page.end.withValues(alpha: 0.34),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 0,
          child: _SoftOrb(
            size: 150,
            color: page.start.withValues(alpha: 0.22),
          ),
        ),
        Center(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(34),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  page.start.withValues(alpha: isDark ? 0.22 : 0.16),
                  page.end.withValues(alpha: isDark ? 0.2 : 0.12),
                  Theme.of(context).colorScheme.surface.withValues(alpha: 0.92),
                ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: isDark ? 0.08 : 0.8),
              ),
              boxShadow: [
                BoxShadow(
                  color: page.start.withValues(alpha: 0.14),
                  blurRadius: 36,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        page.start,
                        page.end,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: page.start.withValues(alpha: 0.24),
                        blurRadius: 28,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  child: Icon(
                    page.icon,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 26),
                const Row(
                  children: [
                    Expanded(child: _PreviewCard(label: 'XP', value: '+120')),
                    SizedBox(width: 12),
                    Expanded(child: _PreviewCard(label: 'WIN', value: '84%')),
                  ],
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Expanded(child: _PreviewCard(label: 'GOAL', value: '3/5')),
                    SizedBox(width: 12),
                    Expanded(child: _PreviewCard(label: 'MODE', value: 'Quiz')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withValues(alpha: isDark ? 0.08 : 0.92),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge,
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
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
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
      ),
    );
  }
}
