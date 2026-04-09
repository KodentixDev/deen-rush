import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../data/quiz_catalog.dart';
import '../l10n/app_strings.dart';

class LevelQuizScreen extends HookWidget {
  const LevelQuizScreen({
    super.key,
    required this.category,
    required this.level,
  });

  final QuizCategory category;
  final QuizLevel level;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final theme = Theme.of(context);
    final questionIndex = useState(0);
    final selectedIndex = useState<int?>(null);
    final levelTitle = strings.quizLevelTitle(
      category.id,
      level.number,
      level.title,
    );
    final currentQuestion = level.questions[questionIndex.value];
    final isLastQuestion = questionIndex.value == level.questions.length - 1;

    Future<void> handleAdvance() async {
      if (selectedIndex.value == null) {
        return;
      }

      if (!isLastQuestion) {
        questionIndex.value += 1;
        selectedIndex.value = null;
        return;
      }

      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(strings.text('levelCompletedTitle')),
            content: Text(strings.text('levelCompletedBody')),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(strings.text('back')),
              ),
            ],
          );
        },
      );

      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.categoryLabel(category.labelKey)),
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
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: theme.colorScheme.outlineVariant),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${strings.text('categoryLevel')} ${level.number}',
                                style: theme.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                levelTitle,
                                style: theme.textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${questionIndex.value + 1}/${level.questions.length} ${strings.text('categoryQuestions')}',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFFFC94A),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFC94A)
                                    .withValues(alpha: 0.28),
                                blurRadius: 20,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '07',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF5F4500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: category.color.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: category.color.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        strings.categoryLabel(category.labelKey),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: category.color,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(34),
                      border: Border.all(color: theme.colorScheme.outlineVariant),
                      boxShadow: [
                        BoxShadow(
                          color: category.color.withValues(alpha: 0.16),
                          blurRadius: 28,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: Text(
                      currentQuestion.prompt,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 24,
                        height: 1.28,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  ...List.generate(
                    currentQuestion.options.length,
                    (index) {
                      final isSelected = selectedIndex.value == index;
                      final isCorrect = currentQuestion.correctIndex == index;
                      final showResult = selectedIndex.value != null;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _QuizOptionTile(
                          index: index,
                          label: currentQuestion.options[index],
                          isSelected: isSelected,
                          isCorrect: isCorrect,
                          showResult: showResult,
                          onTap: () {
                            if (selectedIndex.value == null) {
                              selectedIndex.value = index;
                            }
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: selectedIndex.value == null ? null : handleAdvance,
                      child: Text(
                        isLastQuestion
                            ? strings.text('finishLevel')
                            : strings.text('nextQuestion'),
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

class _QuizOptionTile extends StatelessWidget {
  const _QuizOptionTile({
    required this.index,
    required this.label,
    required this.isSelected,
    required this.isCorrect,
    required this.showResult,
    required this.onTap,
  });

  final int index;
  final String label;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isSelectedWrong = showResult && isSelected && !isCorrect;
    final backgroundColor = isCorrect && showResult
        ? (isDark ? const Color(0xFF2A3D18) : const Color(0xFFE6F9BF))
        : isSelectedWrong
            ? (isDark ? const Color(0xFF133542) : const Color(0xFFD7F5F7))
            : theme.colorScheme.surface;
    final borderColor = isCorrect && showResult
        ? const Color(0xFFB4DD37)
        : isSelectedWrong
            ? const Color(0xFF1CB6C3)
            : theme.colorScheme.outlineVariant;
    final badgeColor = isCorrect && showResult
        ? const Color(0xFFC8F24C)
        : isSelectedWrong
            ? const Color(0xFF1CB6C3).withValues(alpha: 0.22)
            : theme.colorScheme.surfaceContainerHighest;
    final badgeTextColor = isCorrect && showResult
        ? const Color(0xFF4C6400)
        : isSelectedWrong
            ? const Color(0xFF1CB6C3)
            : theme.colorScheme.onSurfaceVariant;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: borderColor,
              width: showResult && (isCorrect || isSelectedWrong) ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: badgeColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  String.fromCharCode(65 + index),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: badgeTextColor,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
