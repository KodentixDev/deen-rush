import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.onOpenSettings,
  });

  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final masteryCards = [
      _MasteryCardData(
        title: strings.text('history'),
        score: '92',
        icon: Icons.menu_book_rounded,
        background: const Color(0xFFF8D6CC),
        accent: const Color(0xFFB7462F),
      ),
      _MasteryCardData(
        title: strings.text('general'),
        score: '84',
        icon: Icons.mosque_rounded,
        background: const Color(0xFFDDF5E8),
        accent: const Color(0xFF0A7A63),
      ),
      _MasteryCardData(
        title: strings.text('culture'),
        score: '68',
        icon: Icons.castle_rounded,
        background: const Color(0xFFE4DBFA),
        accent: const Color(0xFF6C50D8),
      ),
      _MasteryCardData(
        title: strings.text('travel'),
        score: '45',
        icon: Icons.public_rounded,
        background: const Color(0xFFECE8E1),
        accent: const Color(0xFF6F6A62),
      ),
    ];

    final activities = [
      _ActivityData(
        title: strings.text('profileWonDuelVsOmar'),
        time: strings.text('profileTwoMinutesAgo'),
        xp: '+45 XP',
        xpColor: const Color(0xFF0A7A63),
        icon: Icons.trending_up_rounded,
        iconColor: const Color(0xFF0A7A63),
        iconBackground: const Color(0xFF93F0CB),
      ),
      _ActivityData(
        title: strings.text('profileHistoryQuizPerfected'),
        time: strings.text('profileOneHourAgo'),
        xp: '+120 XP',
        xpColor: const Color(0xFF0A7A63),
        icon: Icons.quiz_rounded,
        iconColor: const Color(0xFF6C50D8),
        iconBackground: const Color(0xFFD9CCFF),
      ),
      _ActivityData(
        title: strings.text('profileReachedLevel24'),
        time: strings.text('profileThreeHoursAgo'),
        xp: '+500 XP',
        xpColor: const Color(0xFFB7462F),
        icon: Icons.emoji_events_rounded,
        iconColor: const Color(0xFFB7462F),
        iconBackground: const Color(0xFFFFB7A7),
      ),
      _ActivityData(
        title: strings.text('profileJoinedScholarlyTribe'),
        time: strings.text('profileYesterday'),
        xp: '+10 XP',
        xpColor: const Color(0xFF242121),
        icon: Icons.groups_rounded,
        iconColor: const Color(0xFF5F5954),
        iconBackground: const Color(0xFFF0ECE6),
      ),
      _ActivityData(
        title: strings.text('profileLostDuelVsSara'),
        time: strings.text('profileTwoDaysAgo'),
        xp: '-15 XP',
        xpColor: const Color(0xFFD34F71),
        icon: Icons.close_rounded,
        iconColor: const Color(0xFFBD446D),
        iconBackground: const Color(0xFFF68BA5),
      ),
    ];

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0xFFF9F4EF),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  size: 30,
                  color: Color(0xFFFF7A67),
                ),
                const Spacer(),
                const Text(
                  'DEENRUSH',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.3,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onOpenSettings,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF6E9399),
                    ),
                    child: const Icon(
                      Icons.settings_rounded,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 132,
                    height: 132,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF83EBD5),
                          Color(0xFFF78FA0),
                          Color(0xFF9A8FFF),
                        ],
                      ),
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF284C4E),
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        size: 82,
                        color: Color(0xFFB9E5E1),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -4,
                    bottom: -2,
                    child: GestureDetector(
                      onTap: onOpenSettings,
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF86F8C8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.10),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.edit_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Center(
              child: Text(
                'Zubair Ahmad',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF242121),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                '${strings.text('profileLevel24')} • ${strings.text('profileMasterScholar')}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF787373),
                ),
              ),
            ),
            const SizedBox(height: 26),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    value: '12.4k',
                    label: strings.text('profileTotalXp'),
                    valueColor: const Color(0xFFB7462F),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    value: '842',
                    label: strings.text('profileCorrect'),
                    valueColor: const Color(0xFF0A7A63),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    value: '76%',
                    label: strings.text('profileWinRate'),
                    valueColor: const Color(0xFF6C50D8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: Text(
                    strings.text('profileCategoryMastery'),
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF242121),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    strings.seeAll,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFB7462F),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = (constraints.maxWidth - 14) / 2;

                return Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: masteryCards
                      .map(
                        (item) => SizedBox(
                          width: itemWidth,
                          child: _MasteryCard(item: item),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            const SizedBox(height: 28),
            Text(
              strings.text('profileRecentActivity'),
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w900,
                color: Color(0xFF242121),
              ),
            ),
            const SizedBox(height: 14),
            ...activities.map(
              (activity) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ActivityCard(activity: activity),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onOpenSettings,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF86F8C8),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.black,
                  elevation: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.settings_rounded, size: 24),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        strings.text('profileEditSettings'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.valueColor,
  });

  final String value;
  final String label;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1AC0B8B0),
            blurRadius: 14,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Color(0xFF7E7774),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MasteryCard extends StatelessWidget {
  const _MasteryCard({required this.item});

  final _MasteryCardData item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: item.background,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: item.accent.withValues(alpha: 0.18),
            ),
            child: Icon(item.icon, color: item.accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    item.title.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: item.accent,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.score,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF242121),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({required this.activity});

  final _ActivityData activity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: activity.iconBackground,
            ),
            child: Icon(
              activity.icon,
              size: 20,
              color: activity.iconColor,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF242121),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  activity.time,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF7E7774),
                  ),
                ),
              ],
            ),
          ),
          Text(
            activity.xp,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: activity.xpColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _MasteryCardData {
  const _MasteryCardData({
    required this.title,
    required this.score,
    required this.icon,
    required this.background,
    required this.accent,
  });

  final String title;
  final String score;
  final IconData icon;
  final Color background;
  final Color accent;
}

class _ActivityData {
  const _ActivityData({
    required this.title,
    required this.time,
    required this.xp,
    required this.xpColor,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
  });

  final String title;
  final String time;
  final String xp;
  final Color xpColor;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
}
