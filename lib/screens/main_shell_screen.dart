import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../l10n/app_strings.dart';
import 'duel_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'ranks_screen.dart';
import 'settings_screen.dart';

class MainShellScreen extends HookWidget {
  const MainShellScreen({
    super.key,
    required this.currentLocale,
    required this.themeMode,
    required this.onLocaleChanged,
    required this.onThemeModeChanged,
    required this.onLogout,
  });

  final Locale currentLocale;
  final ThemeMode themeMode;
  final ValueChanged<Locale> onLocaleChanged;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final currentIndex = useState(0);
    final isSettingsOpen = useState(false);

    final pages = [
      const HomeScreen(),
      const DuelScreen(),
      const RanksScreen(),
      ProfileScreen(
        onOpenSettings: () => isSettingsOpen.value = true,
      ),
    ];

    final items = [
      _ShellNavItem(
        icon: Icons.home_rounded,
        label: strings.text('navHome'),
      ),
      _ShellNavItem(
        icon: Icons.sports_martial_arts_rounded,
        label: strings.text('navDuel'),
      ),
      _ShellNavItem(
        icon: Icons.bar_chart_rounded,
        label: strings.text('navRanks'),
      ),
      _ShellNavItem(
        icon: Icons.person_rounded,
        label: strings.text('navMe'),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F4EF),
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              children: [
                Expanded(
                  child: currentIndex.value == 3 && isSettingsOpen.value
                      ? SettingsScreen(
                          currentLocale: currentLocale,
                          themeMode: themeMode,
                          onLocaleChanged: onLocaleChanged,
                          onThemeModeChanged: onThemeModeChanged,
                          onBackRequested: () => isSettingsOpen.value = false,
                          onLogout: onLogout,
                        )
                      : IndexedStack(
                          index: currentIndex.value,
                          children: pages,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
                  child: _SketchBottomNav(
                    items: items,
                    currentIndex: currentIndex.value,
                    onTap: (index) {
                      currentIndex.value = index;
                      if (index != 3) {
                        isSettingsOpen.value = false;
                      }
                    },
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

class _SketchBottomNav extends StatelessWidget {
  const _SketchBottomNav({
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<_ShellNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(
        items.length,
        (index) {
          final item = items[index];
          final isSelected = index == currentIndex;

          if (isSelected) {
            return GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 78,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF7A67),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22FF7A67),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.icon,
                      color: Colors.white,
                      size: 22,
                    ),
                    const SizedBox(height: 1),
                    SizedBox(
                      width: 54,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          item.label,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => onTap(index),
            child: SizedBox(
              width: 68,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item.icon,
                    size: 25,
                    color: const Color(0xFF4F4B4B),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 68,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        item.label,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4F4B4B),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
