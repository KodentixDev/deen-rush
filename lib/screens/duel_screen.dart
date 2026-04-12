import 'package:flutter/material.dart';

import '../components/duel/duel_selection_models.dart';
import '../components/duel/duel_selection_widgets.dart';
import '../data/quiz_catalog.dart';
import '../l10n/app_strings.dart';
import 'duel_match_screen.dart';

class DuelScreen extends StatefulWidget {
  const DuelScreen({super.key});

  @override
  State<DuelScreen> createState() => _DuelScreenState();
}

class _DuelScreenState extends State<DuelScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final items = _duelItems();
    final featured = _mixedItem();

    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xFFF9F4EF)),
      child: Stack(
        children: [
          const Positioned.fill(child: DuelBackground()),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DuelReveal(
                  controller: _controller,
                  begin: 0,
                  end: 0.18,
                  offset: const Offset(0, -12),
                  child: const DuelHeader(),
                ),
                const SizedBox(height: 38),
                DuelReveal(
                  controller: _controller,
                  begin: 0.08,
                  end: 0.28,
                  offset: const Offset(-16, 0),
                  child: DuelHero(strings: strings),
                ),
                const SizedBox(height: 14),
                DuelReveal(
                  controller: _controller,
                  begin: 0.18,
                  end: 0.34,
                  offset: const Offset(0, 14),
                  child: DuelHintChip(label: strings.text('duelModeHint')),
                ),
                const SizedBox(height: 22),
                LayoutBuilder(
                  builder: (context, constraints) {
                    const spacing = 16.0;
                    final cardWidth = (constraints.maxWidth - spacing) / 2;

                    return Wrap(
                      spacing: spacing,
                      runSpacing: 18,
                      children: List.generate(items.length, (index) {
                        final item = items[index];

                        return SizedBox(
                          width: cardWidth,
                          child: DuelReveal(
                            controller: _controller,
                            begin: 0.24 + (index * 0.05),
                            end: 0.58 + (index * 0.04),
                            offset: Offset(0, 22 + (index * 2)),
                            child: DuelAdventureCard(
                              item: item,
                              title: strings.categoryLabel(
                                item.category.labelKey,
                              ),
                              levelLabel: strings.text('duelLevelLabel'),
                              onTap: () => _openMatch(item),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
                const SizedBox(height: 24),
                DuelReveal(
                  controller: _controller,
                  begin: 0.72,
                  end: 1,
                  offset: const Offset(0, 20),
                  child: DuelMixedQuizCard(
                    item: featured,
                    title: strings.text('mixedQuiz'),
                    levelLabel: strings.text('duelLevelLabel'),
                    onTap: () => _openMatch(featured),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openMatch(DuelAdventureItem item) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => DuelMatchScreen(
          category: item.category,
          levelLabel: item.level,
          accentColor: item.accent,
        ),
      ),
    );
  }

  List<DuelAdventureItem> _duelItems() {
    final fiqh = _categoryById('fiqh');
    final quran = _categoryById('quran');
    final history = _categoryById('history');
    final culture = _categoryById('culture');
    final geography = _categoryById('geography');
    final mixed = _categoryById('mixed');

    return [
      DuelAdventureItem(
        category: fiqh.copyAs(
          icon: Icons.balance_rounded,
          color: const Color(0xFF75EEC1),
        ),
        level: '12',
        progress: 0.64,
        color: const Color(0xFF75EEC1),
        accent: const Color(0xFF007B5F),
        titleColor: const Color(0xFF05745E),
        icon: Icons.balance_rounded,
        pattern: DuelCardPattern.none,
        tilt: -0.012,
      ),
      DuelAdventureItem(
        category: quran.copyAs(
          icon: Icons.menu_book_rounded,
          color: const Color(0xFFFFEFA8),
        ),
        level: '24',
        progress: 0.86,
        color: const Color(0xFFFFEFA8),
        accent: const Color(0xFFD4A900),
        titleColor: const Color(0xFF7A6900),
        icon: Icons.menu_book_rounded,
        pattern: DuelCardPattern.stripes,
        tilt: 0.012,
      ),
      DuelAdventureItem(
        category: mixed.copyAs(
          id: 'hadith',
          labelKey: 'hadith',
          icon: Icons.chat_bubble_rounded,
          color: const Color(0xFFDFF5F5),
        ),
        level: '08',
        progress: 0.38,
        color: const Color(0xFFDFF5F5),
        accent: const Color(0xFF008B7D),
        titleColor: const Color(0xFF046F68),
        icon: Icons.chat_bubble_rounded,
        pattern: DuelCardPattern.none,
        tilt: 0.006,
      ),
      DuelAdventureItem(
        category: history.copyAs(
          icon: Icons.history_edu_rounded,
          color: const Color(0xFFFFE6EC),
        ),
        level: '15',
        progress: 0.54,
        color: const Color(0xFFFFE6EC),
        accent: const Color(0xFFFF3F38),
        titleColor: const Color(0xFFD8232B),
        icon: Icons.history_edu_rounded,
        pattern: DuelCardPattern.none,
        tilt: -0.008,
      ),
      DuelAdventureItem(
        category: geography.copyAs(
          icon: Icons.public_rounded,
          color: const Color(0xFFA88AF4),
        ),
        level: '05',
        progress: 0.24,
        color: const Color(0xFFA88AF4),
        accent: const Color(0xFF6A31D4),
        titleColor: const Color(0xFF4A169E),
        icon: Icons.public_rounded,
        pattern: DuelCardPattern.dots,
        tilt: -0.014,
      ),
      DuelAdventureItem(
        category: culture.copyAs(
          icon: Icons.theater_comedy_rounded,
          color: const Color(0xFFFF7565),
        ),
        level: '30',
        progress: 0.95,
        color: const Color(0xFFFF7565),
        accent: const Color(0xFFB74734),
        titleColor: const Color(0xFF2E1811),
        icon: Icons.theater_comedy_rounded,
        pattern: DuelCardPattern.none,
        tilt: 0.008,
      ),
      DuelAdventureItem(
        category: culture.copyAs(
          id: 'ethics',
          labelKey: 'ethics',
          icon: Icons.favorite_rounded,
          color: const Color(0xFFE8E3DD),
        ),
        level: '09',
        progress: 0.46,
        color: const Color(0xFFE8E3DD),
        accent: const Color(0xFF5C5751),
        titleColor: const Color(0xFF3A3531),
        icon: Icons.favorite_rounded,
        pattern: DuelCardPattern.none,
        tilt: -0.004,
      ),
    ];
  }

  DuelAdventureItem _mixedItem() {
    final mixed = _categoryById('mixed');

    return DuelAdventureItem(
      category: mixed.copyAs(
        icon: Icons.star_rounded,
        color: const Color(0xFFE2E0DA),
      ),
      level: '01',
      progress: 0.16,
      color: const Color(0xFFE2E0DA),
      accent: const Color(0xFF222222),
      titleColor: const Color(0xFF24211F),
      icon: Icons.star_rounded,
      pattern: DuelCardPattern.none,
      tilt: 0,
    );
  }

  QuizCategory _categoryById(String id) {
    return quizCatalog.firstWhere((category) => category.id == id);
  }
}
