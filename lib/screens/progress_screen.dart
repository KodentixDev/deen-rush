import 'package:flutter/material.dart';

import '../config/app_theme.dart';
import '../l10n/app_strings.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.text('progressTitle'),
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            strings.text('progressSubtitle'),
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  title: strings.text('progressStreak'),
                  value: '07',
                  colors: const [AppTheme.primary, Color(0xFF7AD6DB)],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  title: strings.text('progressAccuracy'),
                  value: '84%',
                  colors: const [Color(0xFFD8FF57), Color(0xFFFFC94A)],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _MetricCard(
            title: strings.text('progressMastery'),
            value: '12',
            wide: true,
            colors: isDark
                ? const [Color(0xFF152A3C), Color(0xFF1C4E62)]
                : const [Color(0xFFFFFFFF), Color(0xFFE9F8FA)],
          ),
          const SizedBox(height: 22),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: theme.colorScheme.outlineVariant),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 26,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.text('progressSectionTitle'),
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  strings.text('progressSectionBody'),
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 18),
                _ProgressBarRow(
                  label: strings.categoryLabel('fiqh'),
                  progress: 0.88,
                  color: AppTheme.primary,
                ),
                const SizedBox(height: 14),
                _ProgressBarRow(
                  label: strings.categoryLabel('quran'),
                  progress: 0.72,
                  color: const Color(0xFF4B91FF),
                ),
                const SizedBox(height: 14),
                _ProgressBarRow(
                  label: strings.categoryLabel('history'),
                  progress: 0.44,
                  color: const Color(0xFFFFA559),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _InsightCard(
                  title: strings.text('progressStrongArea'),
                  value: strings.categoryLabel('fiqh'),
                  accent: const Color(0xFFDBFF69),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _InsightCard(
                  title: strings.text('progressWeakArea'),
                  value: strings.categoryLabel('history'),
                  accent: const Color(0xFFFFD8B3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.colors,
    this.wide = false,
  });

  final String title;
  final String value;
  final List<Color> colors;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(wide ? 20 : 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.first.withValues(alpha: 0.18),
            blurRadius: 28,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment:
            wide ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF173041),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Color(0xFF173041),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBarRow extends StatelessWidget {
  const _ProgressBarRow({
    required this.label,
    required this.progress,
    required this.color,
  });

  final String label;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(
              '${(progress * 100).round()}%',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            minHeight: 10,
            value: progress,
            backgroundColor:
                Theme.of(context).colorScheme.surfaceContainerHighest,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({
    required this.title,
    required this.value,
    required this.accent,
  });

  final String title;
  final String value;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
