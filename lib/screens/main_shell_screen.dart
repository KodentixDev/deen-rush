import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../config/app_theme.dart';
import '../l10n/app_strings.dart';
import 'community_screen.dart';
import 'home_screen.dart';
import 'progress_screen.dart';
import 'settings_screen.dart';

class MainShellScreen extends HookWidget {
  const MainShellScreen({
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
    final currentIndex = useState(0);
    final pages = [
      const HomeScreen(),
      const ProgressScreen(),
      const CommunityScreen(),
      SettingsScreen(
        currentLocale: currentLocale,
        themeMode: themeMode,
        onLocaleChanged: onLocaleChanged,
        onThemeModeChanged: onThemeModeChanged,
      ),
    ];

    final items = [
      _ShellNavItem(
        icon: Icons.home_rounded,
        label: strings.text('navHome'),
      ),
      _ShellNavItem(
        icon: Icons.bar_chart_rounded,
        label: strings.text('navProgress'),
      ),
      _ShellNavItem(
        icon: Icons.groups_rounded,
        label: strings.text('navCommunity'),
      ),
      _ShellNavItem(
        icon: Icons.tune_rounded,
        label: strings.text('navSettings'),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              children: [
                Expanded(
                  child: IndexedStack(
                    index: currentIndex.value,
                    children: pages,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .outlineVariant
                            .withValues(alpha: 0.8),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 30,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: Row(
                        children: List.generate(
                          items.length,
                          (index) {
                            final item = items[index];
                            final isSelected = currentIndex.value == index;

                            return Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(22),
                                onTap: () => currentIndex.value = index,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 220),
                                  curve: Curves.easeOutCubic,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    gradient: isSelected
                                        ? const LinearGradient(
                                            colors: [
                                              AppTheme.primary,
                                              Color(0xFF7AD6DB),
                                            ],
                                          )
                                        : null,
                                    color: isSelected
                                        ? null
                                        : Colors.transparent,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        item.icon,
                                        size: 22,
                                        color: isSelected
                                            ? Colors.white
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        item.label,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w800,
                                          color: isSelected
                                              ? Colors.white
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShellNavItem {
  const _ShellNavItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}
