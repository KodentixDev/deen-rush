import 'package:flutter/material.dart';

import '../components/language/language_screen_widgets.dart';
import '../l10n/app_strings.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({
    super.key,
    required this.currentLocale,
    required this.onLocaleChanged,
  });

  final Locale currentLocale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late Locale _selected = widget.currentLocale;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF8E45FE),
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(child: LanguageBackground()),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LanguageBackCircle(onTap: () => Navigator.of(context).pop()),
                  const SizedBox(height: 22),
                  Text(
                    strings.language,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 26),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7DDF9),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      children: AppStrings.supportedLocales.map((locale) {
                        final selected = locale.languageCode == _selected.languageCode;
                        return InkWell(
                          onTap: () {
                            setState(() => _selected = locale);
                            widget.onLocaleChanged(locale);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 18,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: locale == AppStrings.supportedLocales.last
                                    ? BorderSide.none
                                    : BorderSide(
                                        color: Colors.black.withValues(alpha: 0.08),
                                      ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(_flag(locale), style: const TextStyle(fontSize: 20)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    strings.localeLabel(locale),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2D2A39),
                                    ),
                                  ),
                                ),
                                if (selected)
                                  Container(
                                    width: 26,
                                    height: 26,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF2ED573),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check_rounded,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _flag(Locale locale) {
    switch (locale.languageCode) {
      case 'az':
        return '\ud83c\udde6\ud83c\uddff';
      case 'tr':
        return '\ud83c\uddf9\ud83c\uddf7';
      case 'ru':
        return '\ud83c\uddf7\ud83c\uddfa';
      case 'ar':
        return '\ud83c\uddf8\ud83c\udde6';
      default:
        return '\ud83c\uddfa\ud83c\uddf8';
    }
  }
}
