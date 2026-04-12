import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../components/main_shell/main_shell_widgets.dart';
import '../l10n/app_strings.dart';
import 'duel_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'ranks_screen.dart';

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

    final items = [
      ShellNavItem(
        icon: Icons.home_rounded,
        label: strings.text('navHome'),
      ),
      ShellNavItem(
        icon: Icons.auto_awesome_mosaic_rounded,
        label: strings.text('navDuel'),
      ),
      ShellNavItem(
        icon: Icons.workspace_premium_rounded,
        label: strings.text('navRanks'),
      ),
      ShellNavItem(
        icon: Icons.person_rounded,
        label: strings.text('navMe'),
      ),
    ];

    final page = switch (currentIndex.value) {
      0 => const HomeScreen(),
      1 => const DuelScreen(),
      2 => const RanksScreen(),
      _ => ProfileScreen(
          currentLocale: currentLocale,
          onLocaleChanged: onLocaleChanged,
          onLogout: onLogout,
          onBackRequested: () => currentIndex.value = 0,
        ),
    };
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final showNav = currentIndex.value != 3;

    return Scaffold(
      backgroundColor:
          currentIndex.value == 0 || currentIndex.value == 2 || currentIndex.value == 3
          ? const Color(0xFF8E45FE)
          : const Color(0xFFF9F4EF),
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Stack(
              children: [
                Positioned.fill(
                  child: currentIndex.value == 0 || !showNav
                      ? page
                      : Padding(
                          padding: EdgeInsets.only(bottom: 96 + bottomInset),
                          child: page,
                        ),
                ),
                if (showNav)
                  Positioned(
                    left: 18,
                    right: 18,
                    bottom: 12 + bottomInset,
                    child: SketchBottomNav(
                      items: items,
                      currentIndex: currentIndex.value,
                      onTap: (index) => currentIndex.value = index,
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
