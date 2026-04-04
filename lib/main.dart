import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/deen_rush_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();

  runApp(
    DeenRushApp(preferences: preferences),
  );
}
