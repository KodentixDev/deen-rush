import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../l10n/app_strings.dart';

ValueNotifier<Locale> useAppLocale() {
  final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
  final initialLocale = AppStrings.resolveLocale(deviceLocale);
  return useState(initialLocale);
}
