import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
      _ShellNavItem(
        icon: Icons.home_rounded,
        label: strings.text('navHome'),
      ),
      _ShellNavItem(
        icon: Icons.auto_awesome_mosaic_rounded,
        label: strings.text('navDuel'),
      ),
      _ShellNavItem(
        icon: Icons.workspace_premium_rounded,
        label: strings.text('navRanks'),
      ),
      _ShellNavItem(
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
          currentIndex.value == 0 ||
              currentIndex.value == 2 ||
              currentIndex.value == 3
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
                    child: _SketchBottomNav(
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
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xCC8B63FF),
        borderRadius: BorderRadius.circular(34),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40381678),
            blurRadius: 28,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Row(
        children: List.generate(
          items.length,
          (index) {
            final item = items[index];
            final isSelected = index == currentIndex;

            return Expanded(
              flex: isSelected ? 2 : 1,
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () => onTap(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 52,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFF6F2FF)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: isSelected
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              item.icon,
                              size: 20,
                              color: const Color(0xFF7A53F9),
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                item.label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF7A53F9),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Icon(
                          item.icon,
                          size: 22,
                          color: Colors.white.withValues(alpha: 0.88),
                        ),
                ),
              ),
            );
          },
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
