import 'package:flutter/material.dart';

import '../../config/app_assets.dart';
import '../../l10n/app_strings.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.strings,
    required this.currentLocale,
    required this.onLocaleChanged,
  });

  final AppStrings strings;
  final Locale currentLocale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 14,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: const Color(0xFFF3F7FC),
                child: ClipOval(
                  child: Image.asset(
                    AppAssets.logo,
                    width: 42,
                    height: 42,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Spacer(),
            const _StatPill(
              value: '500',
              icon: Icons.monetization_on_rounded,
              color: Color(0xFFFABF2F),
            ),
            const SizedBox(width: 8),
            const _StatPill(
              value: '5',
              icon: Icons.favorite_rounded,
              color: Color(0xFFFF6B77),
            ),
            const SizedBox(width: 8),
            _LanguageMenu(
              strings: strings,
              currentLocale: currentLocale,
              onLocaleChanged: onLocaleChanged,
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 24,
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
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF98A1B1),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      strings.scholarName,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF233145),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _ScoreBadge(
                    value: '1,250',
                    icon: Icons.monetization_on_rounded,
                    color: Color(0xFFFABF2F),
                  ),
                  SizedBox(height: 8),
                  _ScoreBadge(
                    value: '5',
                    icon: Icons.favorite_rounded,
                    color: Color(0xFFFF6B77),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({
    required this.value,
    required this.icon,
    required this.color,
  });

  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Color(0xFF33415A),
            ),
          ),
          const SizedBox(width: 5),
          Icon(icon, size: 14, color: color),
        ],
      ),
    );
  }
}

class _ScoreBadge extends StatelessWidget {
  const _ScoreBadge({
    required this.value,
    required this.icon,
    required this.color,
  });

  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Color(0xFFA17A0A),
          ),
        ),
        const SizedBox(width: 6),
        Icon(icon, size: 18, color: color),
      ],
    );
  }
}

class _LanguageMenu extends StatelessWidget {
  const _LanguageMenu({
    required this.strings,
    required this.currentLocale,
    required this.onLocaleChanged,
  });

  final AppStrings strings;
  final Locale currentLocale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      tooltip: strings.language,
      onSelected: onLocaleChanged,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      itemBuilder: (context) {
        return AppStrings.supportedLocales.map(
          (locale) {
            return PopupMenuItem<Locale>(
              value: locale,
              child: Text(_languageLabel(locale)),
            );
          },
        ).toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.translate_rounded,
              size: 16,
              color: Color(0xFF20A8B2),
            ),
            const SizedBox(width: 5),
            Text(
              currentLocale.languageCode.toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF33415A),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _languageLabel(Locale locale) {
    switch (locale.languageCode) {
      case 'tr':
        return 'T\u00fcrk\u00e7e';
      case 'az':
        return 'Az\u0259rbaycan';
      default:
        return 'English';
    }
  }
}
