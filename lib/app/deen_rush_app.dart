import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_theme.dart';
import '../l10n/app_strings.dart';
import '../screens/main_shell_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/splash_screen.dart';

class DeenRushApp extends StatefulWidget {
  const DeenRushApp({
    super.key,
    required this.preferences,
  });

  final SharedPreferences preferences;

  @override
  State<DeenRushApp> createState() => _DeenRushAppState();
}

class _DeenRushAppState extends State<DeenRushApp> {
  static const _localeKey = 'app.locale';
  static const _themeKey = 'app.themeMode';
  static const _onboardingKey = 'app.hasCompletedOnboarding';

  late Locale _locale;
  late ThemeMode _themeMode;
  late bool _hasCompletedOnboarding;
  bool _isSplashVisible = true;

  @override
  void initState() {
    super.initState();
    final savedLocaleCode = widget.preferences.getString(_localeKey);
    final savedTheme = widget.preferences.getString(_themeKey);
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;

    _locale = savedLocaleCode == null
        ? AppStrings.resolveLocale(systemLocale)
        : AppStrings.resolveLocale(Locale(savedLocaleCode));
    _themeMode = _themeModeFromString(savedTheme);
    _hasCompletedOnboarding =
        widget.preferences.getBool(_onboardingKey) ?? false;
  }

  void _handleSplashCompleted() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isSplashVisible = false;
    });
  }

  Future<void> _handleLocaleChanged(Locale nextLocale) async {
    final resolvedLocale = AppStrings.resolveLocale(nextLocale);
    setState(() {
      _locale = resolvedLocale;
    });
    await widget.preferences.setString(
      _localeKey,
      resolvedLocale.languageCode,
    );
  }

  Future<void> _handleThemeModeChanged(ThemeMode nextThemeMode) async {
    setState(() {
      _themeMode = nextThemeMode;
    });
    await widget.preferences.setString(
      _themeKey,
      nextThemeMode.name,
    );
  }

  Future<void> _handleOnboardingCompleted() async {
    setState(() {
      _hasCompletedOnboarding = true;
    });
    await widget.preferences.setBool(_onboardingKey, true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deen Rush',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: AppStrings.supportedLocales,
      localizationsDelegates: const [
        AppStrings.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _themeMode,
      home: _resolveHome(),
    );
  }

  Widget _resolveHome() {
    if (_isSplashVisible) {
      return SplashScreen(
        onCompleted: _handleSplashCompleted,
      );
    }

    if (!_hasCompletedOnboarding) {
      return OnboardingScreen(
        onCompleted: _handleOnboardingCompleted,
      );
    }

    return MainShellScreen(
      currentLocale: _locale,
      themeMode: _themeMode,
      onLocaleChanged: _handleLocaleChanged,
      onThemeModeChanged: _handleThemeModeChanged,
    );
  }

  ThemeMode _themeModeFromString(String? value) {
    return switch (value) {
      'dark' => ThemeMode.dark,
      _ => ThemeMode.light,
    };
  }
}
