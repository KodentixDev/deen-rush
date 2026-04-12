import 'package:flutter/material.dart';

import '../components/community/community_screen_widgets.dart';
import '../config/app_theme.dart';
import '../l10n/app_strings.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.text('communityTitle'),
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            strings.text('communitySubtitle'),
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 22),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primary,
                  Color(0xFFDBFF69),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withValues(alpha: 0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.text('communityMissionTitle'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF153041),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  strings.text('communityMissionBody'),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF214459),
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.84),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.play_circle_fill_rounded, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        strings.text('communityJoinRoom'),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.text('communityLeaderboardTitle'),
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                const CommunityLeaderTile(
                  rank: 1,
                  name: 'Amina',
                  score: '1240 XP',
                  accent: AppTheme.primary,
                ),
                const SizedBox(height: 12),
                const CommunityLeaderTile(
                  rank: 2,
                  name: 'Sarah',
                  score: '1170 XP',
                  accent: Color(0xFFFFA95D),
                ),
                const SizedBox(height: 12),
                const CommunityLeaderTile(
                  rank: 3,
                  name: 'Yusuf',
                  score: '1105 XP',
                  accent: Color(0xFFD8FF57),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
