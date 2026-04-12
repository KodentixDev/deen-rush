import 'package:flutter/material.dart';

import '../components/ranks/ranks_screen_widgets.dart';
import '../l10n/app_strings.dart';

class RanksScreen extends StatefulWidget {
  const RanksScreen({super.key});

  @override
  State<RanksScreen> createState() => _RanksScreenState();
}

class _RanksScreenState extends State<RanksScreen> {
  int _selectedPeriod = 0;

  static const _weeklyTopThree = [
    WinnerEntry(
      rank: 2,
      name: 'Donin',
      score: '11200',
      accent: Color(0xFF8D73FF),
      medal: Color(0xFFD8D8E6),
      avatarColor: Color(0xFFF16FD9),
      icon: Icons.face_3_rounded,
    ),
    WinnerEntry(
      rank: 1,
      name: 'Calzoni',
      score: '12400',
      accent: Color(0xFFFFD83D),
      medal: Color(0xFFFFD83D),
      avatarColor: Color(0xFFFFE8AE),
      icon: Icons.elderly_rounded,
    ),
    WinnerEntry(
      rank: 3,
      name: 'Baptista',
      score: '10500',
      accent: Color(0xFFFFB45B),
      medal: Color(0xFFFFB45B),
      avatarColor: Color(0xFF82A9FF),
      icon: Icons.face_4_rounded,
    ),
  ];

  static const _weeklyRankings = [
    RankingEntry(
      rank: 4,
      name: 'Brandon Siphron',
      points: '9888',
      avatarColor: Color(0xFFF9C498),
      icon: Icons.person_rounded,
    ),
    RankingEntry(
      rank: 5,
      name: 'Roger Donin',
      points: '9888',
      avatarColor: Color(0xFFF0B36A),
      icon: Icons.face_4_rounded,
    ),
    RankingEntry(
      rank: 6,
      name: 'Allison Vaccaro',
      points: '9888',
      avatarColor: Color(0xFFD9D7FF),
      icon: Icons.face_3_rounded,
    ),
    RankingEntry(
      rank: 7,
      name: 'Sana Noura',
      points: '9750',
      avatarColor: Color(0xFFFC9CC2),
      icon: Icons.face_5_rounded,
    ),
    RankingEntry(
      rank: 8,
      name: 'Yusuf Kareem',
      points: '9540',
      avatarColor: Color(0xFF9FCEFF),
      icon: Icons.person_2_rounded,
    ),
    RankingEntry(
      rank: 9,
      name: 'Aubrey Khan',
      points: '9415',
      avatarColor: Color(0xFFF7CD7A),
      icon: Icons.face_6_rounded,
    ),
  ];

  static const _allTimeRankings = [
    RankingEntry(
      rank: 1,
      name: 'Brandon Siphron',
      points: '9888',
      avatarColor: Color(0xFFF7B290),
      icon: Icons.person_rounded,
    ),
    RankingEntry(
      rank: 2,
      name: 'Roger Donin',
      points: '9888',
      avatarColor: Color(0xFFF0B36A),
      icon: Icons.face_4_rounded,
    ),
    RankingEntry(
      rank: 3,
      name: 'Allison Vaccaro',
      points: '9888',
      avatarColor: Color(0xFFD9D7FF),
      icon: Icons.face_5_rounded,
    ),
    RankingEntry(
      rank: 4,
      name: 'Jordyn Mango',
      points: '9888',
      avatarColor: Color(0xFFD6DEF8),
      icon: Icons.emoji_people_rounded,
    ),
    RankingEntry(
      rank: 5,
      name: 'Haylie Herwitz',
      points: '9888',
      avatarColor: Color(0xFFEFEFFF),
      icon: Icons.person_2_rounded,
    ),
    RankingEntry(
      rank: 6,
      name: 'Allison Donin',
      points: '9888',
      avatarColor: Color(0xFF97E3D8),
      icon: Icons.accessibility_new_rounded,
    ),
    RankingEntry(
      rank: 7,
      name: 'Anika Geidt',
      points: '9888',
      avatarColor: Color(0xFFF1F1FF),
      icon: Icons.face_6_rounded,
    ),
    RankingEntry(
      rank: 8,
      name: 'Aubrey Khan',
      points: '9888',
      avatarColor: Color(0xFFF7CD7A),
      icon: Icons.face_2_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final isAllTime = _selectedPeriod == 1;
    final rankings = isAllTime ? _allTimeRankings : _weeklyRankings;

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF8E45FE),
            Color(0xFF7F45FC),
            Color(0xFF5A71FF),
          ],
        ),
      ),
      child: Stack(
        children: [
          const Positioned.fill(child: RanksBackground()),
          LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
                child: SizedBox(
                  height: constraints.maxHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.text('homeLeaderboard'),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 18),
                      PeriodSwitcher(
                        weeklyLabel: strings.text('rankPeriodWeekly'),
                        allTimeLabel: strings.text('rankPeriodAllTime'),
                        selectedIndex: _selectedPeriod,
                        onChanged: (index) => setState(() => _selectedPeriod = index),
                      ),
                      if (!isAllTime) ...[
                        const SizedBox(height: 14),
                        RanksInsightCard(
                          rankLabel: '#4',
                          message: _insightMessage(strings.locale.languageCode),
                        ),
                        const SizedBox(height: 18),
                        const PodiumSection(players: _weeklyTopThree),
                        const SizedBox(height: 14),
                      ] else
                        const SizedBox(height: 20),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.only(bottom: 8),
                          itemCount: rankings.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final entry = rankings[index];
                            return RankTile(
                              entry: entry,
                              allTimeMode: isAllTime,
                              pointsLabel: _pointsLabel(strings.locale.languageCode),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _insightMessage(String languageCode) {
    if (_selectedPeriod == 0) {
      switch (languageCode) {
        case 'az':
          return 'Oyunçuların 60%-dən daha yaxşı gedirsən!';
        case 'tr':
          return 'Oyuncuların %60\'ından daha iyi gidiyorsun!';
        case 'ru':
          return 'Ты играешь лучше, чем 60% игроков!';
        case 'ar':
          return 'أنت أفضل من 60٪ من اللاعبين!';
        default:
          return 'You are doing better than 60% of other players!';
      }
    }

    switch (languageCode) {
      case 'az':
        return 'Bütün oyunçuların 82%-dən daha yaxşı gedirsən!';
      case 'tr':
        return 'Tüm oyuncuların %82\'sinden daha iyi gidiyorsun!';
      case 'ru':
        return 'Ты играешь лучше, чем 82% всех игроков!';
      case 'ar':
        return 'أنت أفضل من 82٪ من جميع اللاعبين!';
      default:
        return 'You are doing better than 82% of all players!';
    }
  }

  String _pointsLabel(String languageCode) {
    switch (languageCode) {
      case 'az':
        return 'xal';
      case 'tr':
        return 'puan';
      case 'ru':
        return 'очков';
      case 'ar':
        return 'نقطة';
      default:
        return 'points';
    }
  }
}
