import 'package:flutter/material.dart';

import '../../l10n/app_strings.dart';

class LoginIntro extends StatelessWidget {
  const LoginIntro({
    super.key,
    required this.strings,
  });

  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          strings.loginTitle,
          style: const TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.w900,
            color: Color(0xFF006E69),
            letterSpacing: -1.4,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          strings.loginSubtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            color: Color(0xFF59606D),
          ),
        ),
      ],
    );
  }
}
