import 'package:flutter/material.dart';

import '../config/app_assets.dart';
import '../data/quiz_catalog.dart';
import '../l10n/app_strings.dart';
import 'category_levels_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopSummary(strings: strings),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: theme.colorScheme.outlineVariant),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 22,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.welcomeBack,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        strings.scholarName,
                        style: theme.textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const _InlineStat(
                      icon: Icons.monetization_on_rounded,
                      value: '1,250',
                    ),
                    const SizedBox(height: 8),
                    const _InlineStat(
                      icon: Icons.favorite_rounded,
                      value: '5',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: theme.colorScheme.outlineVariant),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD8FF57).withValues(alpha: 0.2),
                  blurRadius: 28,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC94A),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      strings.liveNow,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF5F4500),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFD8FF57),
                        Color(0xFFAEFF35),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD8FF57).withValues(alpha: 0.36),
                        blurRadius: 32,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flash_on_rounded,
                        size: 46,
                        color: Color(0xFF274400),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Bilgi\nDuellosu',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          height: 1.02,
                          color: Color(0xFF274400),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  strings.duelHint,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        strings.dailyTaskTitle,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC94A),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        '+50 XP',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF5F4500),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    strings.dailyTaskDescription,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 8,
                    value: 0.66,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    color: const Color(0xFFFFC94A),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '2/3',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: Text(
                  strings.categoriesTitle,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              Text(
                strings.seeAll,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF1CB6C3),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: quizCatalog.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              final category = quizCatalog[index];

              return InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => CategoryLevelsScreen(
                        category: category,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: theme.colorScheme.outlineVariant),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 16,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: category.color.withValues(alpha: 0.14),
                        ),
                        child: Icon(
                          category.icon,
                          color: category.color,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        strings.categoryLabel(category.labelKey),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TopSummary extends StatelessWidget {
  const _TopSummary({
    required this.strings,
  });

  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    AppAssets.logo,
                    width: 34,
                    height: 34,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    strings.appName,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        const _SummaryPill(
          icon: Icons.monetization_on_rounded,
          value: '500',
          color: Color(0xFFFFC94A),
        ),
        const SizedBox(width: 8),
        const _SummaryPill(
          icon: Icons.favorite_rounded,
          value: '5',
          color: Color(0xFFFF6E7C),
        ),
      ],
    );
  }
}

class _SummaryPill extends StatelessWidget {
  const _SummaryPill({
    required this.icon,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(width: 6),
          Icon(icon, size: 16, color: color),
        ],
      ),
    );
  }
}

class _InlineStat extends StatelessWidget {
  const _InlineStat({
    required this.icon,
    required this.value,
  });

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFFA17A0A),
              ),
        ),
        const SizedBox(width: 6),
        Icon(
          icon,
          color: icon == Icons.favorite_rounded
              ? const Color(0xFFFF6E7C)
              : const Color(0xFFFFC94A),
          size: 18,
        ),
      ],
    );
  }
}
