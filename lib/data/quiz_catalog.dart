import 'package:flutter/material.dart';

class QuizQuestion {
  const QuizQuestion({
    required this.prompt,
    required this.options,
    required this.correctIndex,
  });

  final String prompt;
  final List<String> options;
  final int correctIndex;
}

class QuizLevel {
  const QuizLevel({
    required this.number,
    required this.title,
    required this.summary,
    required this.questions,
  });

  final int number;
  final String title;
  final String summary;
  final List<QuizQuestion> questions;
}

class QuizCategory {
  const QuizCategory({
    required this.id,
    required this.labelKey,
    required this.icon,
    required this.color,
    required this.levels,
  });

  final String id;
  final String labelKey;
  final IconData icon;
  final Color color;
  final List<QuizLevel> levels;
}

const quizCatalog = [
  QuizCategory(
    id: 'fiqh',
    labelKey: 'fiqh',
    icon: Icons.balance_rounded,
    color: Color(0xFF1CB6C3),
    levels: [
      QuizLevel(
        number: 1,
        title: 'Purification Basics',
        summary: 'Foundations of wudu and personal cleanliness.',
        questions: [
          QuizQuestion(
            prompt: 'Which act breaks wudu according to the common fiqh ruling?',
            options: [
              'Reading Qur\'an silently',
              'Sleeping deeply',
              'Washing the hands',
              'Saying salam',
            ],
            correctIndex: 1,
          ),
        ],
      ),
      QuizLevel(
        number: 2,
        title: 'Prayer Conditions',
        summary: 'What must be in place before salah begins.',
        questions: [
          QuizQuestion(
            prompt: 'Which of the following is a condition before prayer, not a pillar inside prayer?',
            options: [
              'Facing the qiblah',
              'Reciting al-Fatihah',
              'Ruku',
              'Final tashahhud',
            ],
            correctIndex: 0,
          ),
        ],
      ),
      QuizLevel(
        number: 3,
        title: 'Intention and Timing',
        summary: 'Recognise intention and the correct prayer windows.',
        questions: [
          QuizQuestion(
            prompt: 'The intention for salah is primarily located in the:',
            options: [
              'Tongue only',
              'Heart',
              'Hands',
              'Eyes',
            ],
            correctIndex: 1,
          ),
        ],
      ),
    ],
  ),
  QuizCategory(
    id: 'quran',
    labelKey: 'quran',
    icon: Icons.menu_book_rounded,
    color: Color(0xFF4A90FF),
    levels: [
      QuizLevel(
        number: 1,
        title: 'Revelation Basics',
        summary: 'Early Makkan revelation and first verses.',
        questions: [
          QuizQuestion(
            prompt: 'What was the first word revealed in Surah Al-\'Alaq?',
            options: [
              'Qul',
              'Iqra',
              'Nur',
              'Rahmah',
            ],
            correctIndex: 1,
          ),
        ],
      ),
      QuizLevel(
        number: 2,
        title: 'Surah Recognition',
        summary: 'Identify the themes of short surahs.',
        questions: [
          QuizQuestion(
            prompt: 'Which surah is famously known for sincerity in tawhid?',
            options: [
              'Al-Ikhlas',
              'An-Nasr',
              'Al-Fil',
              'Al-Kawthar',
            ],
            correctIndex: 0,
          ),
        ],
      ),
      QuizLevel(
        number: 3,
        title: 'Quran Themes',
        summary: 'Match key themes with their surahs.',
        questions: [
          QuizQuestion(
            prompt: 'Surah Al-Ma\'un warns against neglecting which social virtue?',
            options: [
              'Trade',
              'Hospitality',
              'Care for the needy',
              'Travel',
            ],
            correctIndex: 2,
          ),
        ],
      ),
    ],
  ),
  QuizCategory(
    id: 'history',
    labelKey: 'history',
    icon: Icons.account_balance_rounded,
    color: Color(0xFFFF9E4F),
    levels: [
      QuizLevel(
        number: 1,
        title: 'Seerah Timeline',
        summary: 'Major moments from the Prophet\'s life.',
        questions: [
          QuizQuestion(
            prompt: 'The Hijrah refers to the migration from Makkah to:',
            options: [
              'Taif',
              'Jerusalem',
              'Madinah',
              'Kufa',
            ],
            correctIndex: 2,
          ),
        ],
      ),
      QuizLevel(
        number: 2,
        title: 'Key Battles',
        summary: 'Recognise turning points in early Islamic history.',
        questions: [
          QuizQuestion(
            prompt: 'Which battle is remembered as the first major battle in Islam?',
            options: [
              'Uhud',
              'Badr',
              'Hunayn',
              'Khandaq',
            ],
            correctIndex: 1,
          ),
        ],
      ),
      QuizLevel(
        number: 3,
        title: 'Companions',
        summary: 'Build familiarity with notable companions.',
        questions: [
          QuizQuestion(
            prompt: 'Who was known by the title Al-Faruq?',
            options: [
              'Umar ibn al-Khattab',
              'Ali ibn Abi Talib',
              'Zayd ibn Thabit',
              'Bilal ibn Rabah',
            ],
            correctIndex: 0,
          ),
        ],
      ),
    ],
  ),
  QuizCategory(
    id: 'culture',
    labelKey: 'culture',
    icon: Icons.palette_rounded,
    color: Color(0xFF9A64FF),
    levels: [
      QuizLevel(
        number: 1,
        title: 'Islamic Manners',
        summary: 'Daily etiquettes and beautiful habits.',
        questions: [
          QuizQuestion(
            prompt: 'Which phrase is commonly said before eating?',
            options: [
              'SubhanAllah',
              'Bismillah',
              'Alhamdulillah',
              'Astaghfirullah',
            ],
            correctIndex: 1,
          ),
        ],
      ),
      QuizLevel(
        number: 2,
        title: 'Sacred Months',
        summary: 'Learn the rhythm of the Islamic calendar.',
        questions: [
          QuizQuestion(
            prompt: 'Ramadan is the month especially associated with:',
            options: [
              'Hajj rituals',
              'Daily trade',
              'Fasting',
              'Eid prayer only',
            ],
            correctIndex: 2,
          ),
        ],
      ),
      QuizLevel(
        number: 3,
        title: 'Community Life',
        summary: 'Values that strengthen the ummah.',
        questions: [
          QuizQuestion(
            prompt: 'Giving charity voluntarily beyond zakah is called:',
            options: [
              'Sadaqah',
              'Qasas',
              'Talaq',
              'Witr',
            ],
            correctIndex: 0,
          ),
        ],
      ),
    ],
  ),
  QuizCategory(
    id: 'geography',
    labelKey: 'geography',
    icon: Icons.public_rounded,
    color: Color(0xFF29B7C8),
    levels: [
      QuizLevel(
        number: 1,
        title: 'Holy Cities',
        summary: 'Connect places with their significance.',
        questions: [
          QuizQuestion(
            prompt: 'The Ka\'bah is located in:',
            options: [
              'Makkah',
              'Madinah',
              'Cairo',
              'Damascus',
            ],
            correctIndex: 0,
          ),
        ],
      ),
      QuizLevel(
        number: 2,
        title: 'Routes of Seerah',
        summary: 'Trace journeys from the Prophetic era.',
        questions: [
          QuizQuestion(
            prompt: 'The migration destination during Hijrah became known as:',
            options: [
              'Basra',
              'Madinah',
              'Baghdad',
              'Najaf',
            ],
            correctIndex: 1,
          ),
        ],
      ),
      QuizLevel(
        number: 3,
        title: 'Landmarks',
        summary: 'Recognise important sites in Islamic history.',
        questions: [
          QuizQuestion(
            prompt: 'Masjid an-Nabawi is located in which city?',
            options: [
              'Jerusalem',
              'Makkah',
              'Madinah',
              'Istanbul',
            ],
            correctIndex: 2,
          ),
        ],
      ),
    ],
  ),
  QuizCategory(
    id: 'mixed',
    labelKey: 'mixed',
    icon: Icons.grid_view_rounded,
    color: Color(0xFFFF6464),
    levels: [
      QuizLevel(
        number: 1,
        title: 'Starter Mix',
        summary: 'A balanced warm-up from every section.',
        questions: [
          QuizQuestion(
            prompt: 'Which pillar of Islam is observed in the month of Ramadan?',
            options: [
              'Fasting',
              'Pilgrimage',
              'Testimony',
              'Charity only',
            ],
            correctIndex: 0,
          ),
        ],
      ),
      QuizLevel(
        number: 2,
        title: 'Steady Mix',
        summary: 'Blend fiqh, seerah, and Qur\'an recall.',
        questions: [
          QuizQuestion(
            prompt: 'Before salah begins, a Muslim should be in a state of:',
            options: [
              'Trade',
              'Purity',
              'Travel',
              'Debate',
            ],
            correctIndex: 1,
          ),
        ],
      ),
      QuizLevel(
        number: 3,
        title: 'Challenge Mix',
        summary: 'A faster mixed review across topics.',
        questions: [
          QuizQuestion(
            prompt: 'Which city became the center of the first Muslim community?',
            options: [
              'Madinah',
              'Alexandria',
              'Cordoba',
              'Sana\'a',
            ],
            correctIndex: 0,
          ),
        ],
      ),
    ],
  ),
];
