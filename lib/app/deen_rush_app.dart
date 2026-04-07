import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_theme.dart';
import '../l10n/app_strings.dart';
import '../screens/login_screen.dart';
import '../screens/main_shell_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/splash_screen.dart';

class DeenRushApp extends StatefulWidget {
  const DeenRushApp({super.key});

  @override
  State<DeenRushApp> createState() => _DeenRushAppState();
}

class _DeenRushAppState extends State<DeenRushApp> {
  static const _localeKey = 'app.locale';
  static const _themeKey = 'app.themeMode';
  static const _onboardingKey = 'app.hasCompletedOnboarding';
  static const _authKey = 'app.isAuthenticated';

  late Locale _locale;
  late ThemeMode _themeMode;
  late bool _hasCompletedOnboarding;
  late bool _isAuthenticated;
  SharedPreferences? _preferences;
  bool _isSplashVisible = true;

  @override
  void initState() {
    super.initState();
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;

    _locale = AppStrings.resolveLocale(systemLocale);
    _themeMode = ThemeMode.light;
    _hasCompletedOnboarding = false;
    _isAuthenticated = true;

    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    final savedLocaleCode = preferences.getString(_localeKey);
    final savedTheme = preferences.getString(_themeKey);

    if (!mounted) {
      return;
    }

    setState(() {
      _preferences = preferences;
      _locale = savedLocaleCode == null
          ? _locale
          : AppStrings.resolveLocale(Locale(savedLocaleCode));
      _themeMode = _themeModeFromString(savedTheme);
      _hasCompletedOnboarding =
          preferences.getBool(_onboardingKey) ?? false;
      _isAuthenticated = preferences.getBool(_authKey) ?? true;
    });
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
    await _preferences?.setString(
      _localeKey,
      resolvedLocale.languageCode,
    );
  }

  Future<void> _handleThemeModeChanged(ThemeMode nextThemeMode) async {
    setState(() {
      _themeMode = nextThemeMode;
    });
    await _preferences?.setString(
      _themeKey,
      nextThemeMode.name,
    );
  }

  Future<void> _handleOnboardingCompleted() async {
    setState(() {
      _hasCompletedOnboarding = true;
    });
    await _preferences?.setBool(_onboardingKey, true);
  }

  Future<void> _handleLoginCompleted() async {
    setState(() {
      _isAuthenticated = true;
    });
    await _preferences?.setBool(_authKey, true);
  }

  Future<void> _handleLogout() async {
    setState(() {
      _isAuthenticated = false;
    });
    await _preferences?.setBool(_authKey, false);
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

    if (!_isAuthenticated) {
      return LoginScreen(
        onContinue: _handleLoginCompleted,
      );
    }

    return MainShellScreen(
      currentLocale: _locale,
      themeMode: _themeMode,
      onLocaleChanged: _handleLocaleChanged,
      onThemeModeChanged: _handleThemeModeChanged,
      onLogout: _handleLogout,
    );
  }

  ThemeMode _themeModeFromString(String? value) {
    return switch (value) {
      'dark' => ThemeMode.dark,
      _ => ThemeMode.light,
    };
  }
}
