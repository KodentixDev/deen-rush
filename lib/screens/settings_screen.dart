import 'package:flutter/material.dart';

import '../config/app_theme.dart';
import '../l10n/app_strings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.currentLocale,
    required this.themeMode,
    required this.onLocaleChanged,
    required this.onThemeModeChanged,
  });

  final Locale currentLocale;
  final ThemeMode themeMode;
  final ValueChanged<Locale> onLocaleChanged;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final theme = Theme.of(context);
    final isDark = themeMode == ThemeMode.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.text('settingsTitle'),
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            strings.text('settingsSubtitle'),
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 22),
          _SettingsSection(
            title: strings.text('appearanceTitle'),
            body: strings.text('appearanceBody'),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: isDark
                            ? const [Color(0xFF203447), Color(0xFF102132)]
                            : const [Color(0xFFFFD971), Color(0xFF7AD6DB)],
                      ),
                    ),
                    child: Icon(
                      isDark
                          ? Icons.nightlight_round
                          : Icons.light_mode_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          strings.text('darkMode'),
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          strings.text('darkModeBody'),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: isDark,
                    onChanged: (value) {
                      onThemeModeChanged(
                        value ? ThemeMode.dark : ThemeMode.light,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _SettingsSection(
            title: strings.text('languageTitle'),
            body: strings.text('languageBody'),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: AppStrings.supportedLocales.map(
                (locale) {
                  final isSelected =
                      currentLocale.languageCode == locale.languageCode;

                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => onLocaleChanged(locale),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primary.withValues(alpha: 0.16)
                            : theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.primary
                              : theme.colorScheme.outlineVariant,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.translate_rounded,
                            size: 18,
                            color: isSelected
                                ? AppTheme.primary
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            strings.localeLabel(locale),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: isSelected
                                  ? AppTheme.primary
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          const SizedBox(height: 16),
          _SettingsSection(
            title: strings.text('aboutTitle'),
            body: strings.text('aboutBody'),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1CB6C3),
                    Color(0xFF7AD6DB),
                  ],
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Deen Rush v0.1 redesigned',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.body,
    required this.child,
  });

  final String title;
  final String body;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}
