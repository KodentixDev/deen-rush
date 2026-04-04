import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppStrings {
  AppStrings(this.locale);

  final Locale locale;

  static const supportedLocales = [
    Locale('tr'),
    Locale('az'),
    Locale('en'),
  ];

  static const delegate = _AppStringsDelegate();

  static const Map<String, Map<String, String>> _localizedValues = {
    'tr': {
      'appName': 'Deen Rush',
      'splashTagline': 'Ruhunu tazeleyen bilgi yolculuğu',
      'splashCaption': 'Hızlı turlar, güçlü tasarım ve huzurlu bir deneyim seni bekliyor.',
      'splashLoading': 'Hazırlanıyor',
      'welcomeBack': 'Tekrar hoş geldin,',
      'scholarName': 'Scholar Ahmed',
      'loginTitle': 'DeenRush',
      'loginSubtitle': 'Maceraya katılmaya hazır mısın?',
      'usernameOrEmail': 'Kullanıcı Adı veya E-posta',
      'usernameHint': 'Adını buraya yaz...',
      'password': 'Şifre',
      'forgotPassword': 'Şifremi Unuttum',
      'signIn': 'Giriş Yap',
      'continueWith': 'VEYA BUNLARLA DEVAM ET',
      'google': 'Google',
      'apple': 'Apple',
      'guestPlay': 'Misafir Olarak Oyna',
      'noAccount': 'Hesabın yok mu?',
      'register': 'Kayıt Ol',
      'terms': 'KULLANIM KOŞULLARI',
      'privacy': 'GİZLİLİK POLİTİKASI',
      'liveNow': 'ŞİMDİ CANLI',
      'duelTitle': 'Hikmet Arenası',
      'duelSubtitle': 'Hızlı cevap, parlak zafer',
      'duelHint': 'Bir rakip bulmak için dokun',
      'dailyTaskTitle': 'Günlük Görev',
      'dailyTaskDescription': '3 düello kazan',
      'categoriesTitle': 'Kategoriler',
      'seeAll': 'Tümünü Gör',
      'fiqh': 'Fıkıh',
      'quran': 'Kur\'an',
      'history': 'Tarih',
      'culture': 'Kültür',
      'geography': 'Coğrafya',
      'mixed': 'Karışık',
      'language': 'Dil',
      'localeEnglish': 'English',
      'localeTurkish': 'Türkçe',
      'localeAzerbaijani': 'Azərbaycan dili',
      'onboardingTitle1': 'Ders gibi değil, canlı bir yarış gibi öğren',
      'onboardingBody1': 'Her turda seçilmiş sorular, güçlü görsel akış ve rahat okunur ekranlarla ilerle.',
      'onboardingTitle2': 'Kategori seç, serini koru, hızını artır',
      'onboardingBody2': 'Fıkıh, Kur\'an ve tarih başlıklarında ilerlemeni takip et, zayıf alanlarını güçlendir.',
      'onboardingTitle3': 'Ayarlar senden yana olsun',
      'onboardingBody3': 'Dili değiştir, dark mode aç ve deneyimi sana en rahat gelen hale getir.',
      'onboardingNext': 'İleri',
      'onboardingSkip': 'Geç',
      'onboardingStart': 'Ana Sayfaya Geç',
      'homeGreeting': 'Bugünün bilgi turu hazır',
      'homeRound': 'ROUND 4/7',
      'homeCategory': 'Fıkıh',
      'homeQuestion': '“Salah” kelimesinin Arapça asıl anlamı en doğru şekilde hangisidir?',
      'homeOptionA': 'Secde etmek',
      'homeOptionB': 'Dua etmek',
      'homeOptionC': 'Arınmak',
      'homeOptionD': 'Hatırlamak',
      'homeInsight': 'Bir soruda hem seçimin hem doğru cevap aynı anda gösterilir.',
      'playerYou': 'SEN',
      'playerOpponent': 'SARAH',
      'playerLevel': 'Seviye 10',
      'timerLabel': 'Kalan süre',
      'boosterPlus': '+1',
      'boosterFreeze': 'Freeze',
      'boosterAudience': 'Topluluk',
      'navHome': 'Home',
      'navProgress': 'İlerleme',
      'navCommunity': 'Topluluk',
      'navSettings': 'Ayarlar',
      'navLeagues': 'Leagues',
      'navShop': 'Shop',
      'progressTitle': 'İlerlemen',
      'progressSubtitle': 'Bu hafta ritmini koruyorsun.',
      'progressStreak': '7 günlük seri',
      'progressAccuracy': '%84 doğruluk',
      'progressMastery': '12 konu tamamlandı',
      'progressSectionTitle': 'Kategori dengesi',
      'progressSectionBody': 'Fıkıh ve Kur\'an alanında güçlü gidiyorsun, tarih tarafı biraz daha tekrar istiyor.',
      'progressWeakArea': 'Tekrar önerisi',
      'progressStrongArea': 'En güçlü alan',
      'communityTitle': 'Topluluk',
      'communitySubtitle': 'Birlikte öğrenen oyuncularla aynı ritimde kal.',
      'communityMissionTitle': 'Canlı meydan okuma',
      'communityMissionBody': 'Bu gece 20:00\'de 15 soruluk hızlı tur başlıyor.',
      'communityLeaderboardTitle': 'Haftanın öne çıkanları',
      'settingsTitle': 'Settings',
      'settingsSubtitle': 'Görünüm ve dili buradan yönet.',
      'appearanceTitle': 'Görünüm',
      'appearanceBody': 'Uygulamanın tema yapısını daha sakin veya daha parlak hale getir.',
      'darkMode': 'Dark mode',
      'darkModeBody': 'Gece kullanımında daha rahat bir görünüm sağlar.',
      'languageTitle': 'Dil seçimi',
      'languageBody': 'Tətbiq mətnlərini istədiyin dildə göstər.',
      'aboutTitle': 'Hakkında',
      'aboutBody': 'Deen Rush artık onboarding, yeni quiz ekranı ve kalıcı ayarlarla çalışıyor.',
    },
    'az': {
      'appName': 'Deen Rush',
      'splashTagline': 'Ruhunu yeniləyən bilik səyahəti',
      'splashCaption': 'Sürətli turlar, güclü dizayn və rahat bir təcrübə səni gözləyir.',
      'splashLoading': 'Hazırlanır',
      'welcomeBack': 'Yenidən xoş gəldin,',
      'scholarName': 'Scholar Ahmed',
      'loginTitle': 'DeenRush',
      'loginSubtitle': 'Macəraya qoşulmağa hazırsan?',
      'usernameOrEmail': 'İstifadəçi adı və ya E-poçt',
      'usernameHint': 'Adını bura yaz...',
      'password': 'Şifrə',
      'forgotPassword': 'Şifrəmi unutdum',
      'signIn': 'Daxil Ol',
      'continueWith': 'VƏ YA BUNLARLA DAVAM ET',
      'google': 'Google',
      'apple': 'Apple',
      'guestPlay': 'Qonaq kimi oyna',
      'noAccount': 'Hesabın yoxdur?',
      'register': 'Qeydiyyatdan Keç',
      'terms': 'İSTİFADƏ ŞƏRTLƏRİ',
      'privacy': 'MƏXFİLİK SİYASƏTİ',
      'liveNow': 'İNDİ CANLI',
      'duelTitle': 'Hikmət Arenası',
      'duelSubtitle': 'Sürətli cavab, parlaq qələbə',
      'duelHint': 'Rəqib tapmaq üçün toxun',
      'dailyTaskTitle': 'Gündəlik Tapşırıq',
      'dailyTaskDescription': '3 duel qazan',
      'categoriesTitle': 'Kateqoriyalar',
      'seeAll': 'Hamısına Bax',
      'fiqh': 'Fiqh',
      'quran': 'Quran',
      'history': 'Tarix',
      'culture': 'Mədəniyyət',
      'geography': 'Coğrafiya',
      'mixed': 'Qarışıq',
      'language': 'Dil',
      'localeEnglish': 'English',
      'localeTurkish': 'Türkçe',
      'localeAzerbaijani': 'Azərbaycan dili',
      'onboardingTitle1': 'Dərs kimi yox, canlı yarış kimi öyrən',
      'onboardingBody1': 'Hər turda seçilmiş suallar, güclü vizual axın və rahat oxunan ekranlarla irəlilə.',
      'onboardingTitle2': 'Kateqoriya seç, seriyanı qoru, sürətini artır',
      'onboardingBody2': 'Fiqh, Quran və tarix başlıqlarında inkişafını izlə, zəif sahələrini gücləndir.',
      'onboardingTitle3': 'Ayarlar sənə uyğun olsun',
      'onboardingBody3': 'Dili dəyiş, dark mode aç və təcrübəni özünə ən rahat formaya gətir.',
      'onboardingNext': 'Next',
      'onboardingSkip': 'Keç',
      'onboardingStart': 'Ana Səhifəyə Keç',
      'homeGreeting': 'Bugünün bilik turu hazırdır',
      'homeRound': 'ROUND 4/7',
      'homeCategory': 'Fiqh',
      'homeQuestion': '“Salah” sözünün ərəb dilində əsas mənası ən doğru şəkildə hansıdır?',
      'homeOptionA': 'Səcdə etmək',
      'homeOptionB': 'Dua etmək',
      'homeOptionC': 'Təmizlənmək',
      'homeOptionD': 'Xatırlamaq',
      'homeInsight': 'Bir sualda həm seçimin, həm də doğru cavab eyni anda göstərilir.',
      'playerYou': 'SƏN',
      'playerOpponent': 'SARAH',
      'playerLevel': 'Səviyyə 10',
      'timerLabel': 'Qalan vaxt',
      'boosterPlus': '+1',
      'boosterFreeze': 'Freeze',
      'boosterAudience': 'Topluluq',
      'navHome': 'Ana',
      'navProgress': 'İrəliləyiş',
      'navCommunity': 'İcma',
      'navSettings': 'Ayarlar',
      'navLeagues': 'Leagues',
      'navShop': 'Shop',
      'progressTitle': 'İrəliləyişin',
      'progressSubtitle': 'Bu həftə ritmini yaxşı qoruyursan.',
      'progressStreak': '7 günlük seriya',
      'progressAccuracy': '%84 dəqiqlik',
      'progressMastery': '12 mövzu tamamlandı',
      'progressSectionTitle': 'Kateqoriya balansı',
      'progressSectionBody': 'Fiqh və Quran tərəfi güclüdür, tarix hissəsi isə bir az daha təkrar istəyir.',
      'progressWeakArea': 'Təkrar tövsiyəsi',
      'progressStrongArea': 'Ən güclü sahə',
      'communityTitle': 'İcma',
      'communitySubtitle': 'Birlikdə öyrənən oyunçularla eyni ritmdə qal.',
      'communityMissionTitle': 'Canlı çağırış',
      'communityMissionBody': 'Bu axşam 20:00-da 15 suallıq sürətli tur başlayır.',
      'communityLeaderboardTitle': 'Həftənin seçilənləri',
      'settingsTitle': 'Settings',
      'settingsSubtitle': 'Görünüşü və dili buradan idarə et.',
      'appearanceTitle': 'Görünüş',
      'appearanceBody': 'Tətbiqin tema quruluşunu daha sakit və ya daha parlaq hala gətir.',
      'darkMode': 'Dark mode',
      'darkModeBody': 'Gecə istifadəsində daha rahat bir görünüş yaradır.',
      'languageTitle': 'Dil seçimi',
      'languageBody': 'Tətbiq mətnlərini istədiyin dildə göstər.',
      'aboutTitle': 'Haqqında',
      'aboutBody': 'Deen Rush indi onboarding, yeni quiz ekranı və qalıcı ayarlarla işləyir.',
    },
    'en': {
      'appName': 'Deen Rush',
      'splashTagline': 'A calmer and sharper way to revise faith knowledge',
      'splashCaption': 'Beautiful rounds, clear pacing, and a polished quiz flow are ready for you.',
      'splashLoading': 'Loading',
      'welcomeBack': 'Welcome back,',
      'scholarName': 'Scholar Ahmed',
      'loginTitle': 'DeenRush',
      'loginSubtitle': 'Are you ready to join the adventure?',
      'usernameOrEmail': 'Username or E-mail',
      'usernameHint': 'Write your name here...',
      'password': 'Password',
      'forgotPassword': 'Forgot Password',
      'signIn': 'Sign In',
      'continueWith': 'OR CONTINUE WITH',
      'google': 'Google',
      'apple': 'Apple',
      'guestPlay': 'Play as Guest',
      'noAccount': 'Don\'t have an account?',
      'register': 'Register',
      'terms': 'TERMS OF USE',
      'privacy': 'PRIVACY POLICY',
      'liveNow': 'LIVE NOW',
      'duelTitle': 'Wisdom Arena',
      'duelSubtitle': 'Swift answers, bright victories',
      'duelHint': 'Tap to find an opponent',
      'dailyTaskTitle': 'Daily Mission',
      'dailyTaskDescription': 'Win 3 duels',
      'categoriesTitle': 'Categories',
      'seeAll': 'See all',
      'fiqh': 'Fiqh',
      'quran': 'Qur\'an',
      'history': 'History',
      'culture': 'Culture',
      'geography': 'Geography',
      'mixed': 'Mixed',
      'language': 'Language',
      'localeEnglish': 'English',
      'localeTurkish': 'Türkçe',
      'localeAzerbaijani': 'Azərbaycan dili',
      'onboardingTitle1': 'Learn like a live challenge, not a static lesson',
      'onboardingBody1': 'Move through curated questions, clearer hierarchy, and a smoother visual rhythm on every round.',
      'onboardingTitle2': 'Pick a category, hold your streak, sharpen your speed',
      'onboardingBody2': 'Track your growth in fiqh, Qur\'an, and history while focusing on the topics that still need repetition.',
      'onboardingTitle3': 'Keep settings aligned with you',
      'onboardingBody3': 'Switch language, enable dark mode, and make the experience feel right from the first tap.',
      'onboardingNext': 'Next',
      'onboardingSkip': 'Skip',
      'onboardingStart': 'Enter Home',
      'homeGreeting': 'Today\'s knowledge round is ready',
      'homeRound': 'ROUND 4/7',
      'homeCategory': 'Fiqh',
      'homeQuestion': 'What is the most accurate literal meaning of the Arabic word “Salah”?',
      'homeOptionA': 'To prostrate',
      'homeOptionB': 'To supplicate',
      'homeOptionC': 'To purify',
      'homeOptionD': 'To remember',
      'homeInsight': 'The screen can show both your selection and the correct answer at the same time.',
      'playerYou': 'YOU',
      'playerOpponent': 'SARAH',
      'playerLevel': 'Level 10',
      'timerLabel': 'Time left',
      'boosterPlus': '+1',
      'boosterFreeze': 'Freeze',
      'boosterAudience': 'Audience',
      'navHome': 'Home',
      'navProgress': 'Progress',
      'navCommunity': 'Community',
      'navSettings': 'Settings',
      'navLeagues': 'Leagues',
      'navShop': 'Shop',
      'progressTitle': 'Your progress',
      'progressSubtitle': 'Your rhythm this week looks strong.',
      'progressStreak': '7 day streak',
      'progressAccuracy': '84% accuracy',
      'progressMastery': '12 topics mastered',
      'progressSectionTitle': 'Category balance',
      'progressSectionBody': 'Fiqh and Qur\'an are ahead right now, while history still needs a little more revision.',
      'progressWeakArea': 'Needs review',
      'progressStrongArea': 'Strongest area',
      'communityTitle': 'Community',
      'communitySubtitle': 'Stay in the same rhythm with players who are learning together.',
      'communityMissionTitle': 'Live challenge',
      'communityMissionBody': 'A 15-question fast round starts tonight at 20:00.',
      'communityLeaderboardTitle': 'This week\'s highlights',
      'settingsTitle': 'Settings',
      'settingsSubtitle': 'Control language and appearance here.',
      'appearanceTitle': 'Appearance',
      'appearanceBody': 'Shape the app with a calmer dark palette or a brighter daylight look.',
      'darkMode': 'Dark mode',
      'darkModeBody': 'Makes the interface easier on the eyes at night.',
      'languageTitle': 'Language',
      'languageBody': 'Show the app in the language you prefer.',
      'aboutTitle': 'About',
      'aboutBody': 'Deen Rush now includes onboarding, a redesigned quiz home, and persistent settings.',
    },
  };

  static Locale resolveLocale(Locale locale) {
    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }
    return const Locale('tr');
  }

  static AppStrings of(BuildContext context) {
    final strings = Localizations.of<AppStrings>(context, AppStrings);
    assert(strings != null, 'AppStrings not found in widget tree.');
    return strings!;
  }

  String _text(String key) {
    final values =
        _localizedValues[locale.languageCode] ?? _localizedValues['en']!;
    return values[key] ?? _localizedValues['en']![key] ?? key;
  }

  String text(String key) => _text(key);

  String localeLabel(Locale value) {
    return switch (value.languageCode) {
      'tr' => _text('localeTurkish'),
      'az' => _text('localeAzerbaijani'),
      _ => _text('localeEnglish'),
    };
  }

  String get appName => _text('appName');
  String get splashTagline => _text('splashTagline');
  String get splashCaption => _text('splashCaption');
  String get welcomeBack => _text('welcomeBack');
  String get scholarName => _text('scholarName');
  String get loginTitle => _text('loginTitle');
  String get loginSubtitle => _text('loginSubtitle');
  String get usernameOrEmail => _text('usernameOrEmail');
  String get usernameHint => _text('usernameHint');
  String get password => _text('password');
  String get forgotPassword => _text('forgotPassword');
  String get signIn => _text('signIn');
  String get continueWith => _text('continueWith');
  String get google => _text('google');
  String get apple => _text('apple');
  String get guestPlay => _text('guestPlay');
  String get noAccount => _text('noAccount');
  String get register => _text('register');
  String get terms => _text('terms');
  String get privacy => _text('privacy');
  String get liveNow => _text('liveNow');
  String get duelTitle => _text('duelTitle');
  String get duelSubtitle => _text('duelSubtitle');
  String get duelHint => _text('duelHint');
  String get dailyTaskTitle => _text('dailyTaskTitle');
  String get dailyTaskDescription => _text('dailyTaskDescription');
  String get categoriesTitle => _text('categoriesTitle');
  String get seeAll => _text('seeAll');
  String get navHome => _text('navHome');
  String get navLeagues => _text('navLeagues');
  String get navShop => _text('navShop');
  String get navSettings => _text('navSettings');
  String get language => _text('language');

  String categoryLabel(String key) => _text(key);
}

class _AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const _AppStringsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppStrings.supportedLocales.any(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
    );
  }

  @override
  Future<AppStrings> load(Locale locale) {
    return SynchronousFuture(AppStrings(AppStrings.resolveLocale(locale)));
  }

  @override
  bool shouldReload(_AppStringsDelegate old) => false;
}
