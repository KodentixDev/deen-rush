import 'package:flutter/material.dart';

import '../components/progress/progress_screen_widgets.dart';
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
                child: ProgressMetricCard(
                  title: strings.text('progressStreak'),
                  value: '07',
                  colors: const [AppTheme.primary, Color(0xFF7AD6DB)],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ProgressMetricCard(
                  title: strings.text('progressAccuracy'),
                  value: '84%',
                  colors: const [Color(0xFFD8FF57), Color(0xFFFFC94A)],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ProgressMetricCard(
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
                ProgressBarRow(
                  label: strings.categoryLabel('fiqh'),
                  progress: 0.88,
                  color: AppTheme.primary,
                ),
                const SizedBox(height: 14),
                ProgressBarRow(
                  label: strings.categoryLabel('quran'),
                  progress: 0.72,
                  color: const Color(0xFF4B91FF),
                ),
                const SizedBox(height: 14),
                ProgressBarRow(
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
                child: ProgressInsightCard(
                  title: strings.text('progressStrongArea'),
                  value: strings.categoryLabel('fiqh'),
                  accent: const Color(0xFFDBFF69),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ProgressInsightCard(
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
