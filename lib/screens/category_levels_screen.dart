import 'package:flutter/material.dart';

import '../data/quiz_catalog.dart';
import '../l10n/app_strings.dart';
import 'level_quiz_screen.dart';

class CategoryLevelsScreen extends StatelessWidget {
  const CategoryLevelsScreen({
    super.key,
    required this.category,
  });

  final QuizCategory category;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final theme = Theme.of(context);
    final title = strings.categoryLabel(category.labelKey);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          category.color,
                          category.color.withValues(alpha: 0.62),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: category.color.withValues(alpha: 0.22),
                          blurRadius: 30,
                          offset: const Offset(0, 18),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            category.icon,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          title,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Choose a level and open the questions prepared for that stage.',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'Levels',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  ...category.levels.map(
                    (level) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(26),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => LevelQuizScreen(
                                category: category,
                                level: level,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(
                              color: theme.colorScheme.outlineVariant,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 20,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: category.color.withValues(alpha: 0.16),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${level.number}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    color: category.color,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Level ${level.number}',
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      level.title,
                                      style: theme.textTheme.titleLarge,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      level.summary,
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                children: [
                                  Text(
                                    '${level.questions.length}',
                                    style: theme.textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'question',
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ],
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
      ),
    );
  }
}
