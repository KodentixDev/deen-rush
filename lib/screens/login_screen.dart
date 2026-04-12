import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../components/login/login_screen_widgets.dart';
import '../l10n/app_strings.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({
    super.key,
    required this.onContinue,
  });

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscurePassword = useState(true);
    final showEmailForm = useState(false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: const BoxDecoration(color: Color(0xFFF9F4EF)),
        child: Stack(
          children: [
            const Positioned(
              left: -110,
              top: -40,
              child: LoginBackdropGlow(
                width: 300,
                height: 340,
                colors: [
                  Color(0x26D6CBFF),
                  Color(0x10F1EBFF),
                  Colors.transparent,
                ],
              ),
            ),
            const Positioned(
              right: -120,
              bottom: -20,
              child: LoginBackdropGlow(
                width: 320,
                height: 360,
                colors: [
                  Color(0x22FFB89E),
                  Color(0x0FFFE7D7),
                  Colors.transparent,
                ],
              ),
            ),
            Positioned(
              left: 72,
              top: 92,
              child: Text(
                '_Rk',
                style: TextStyle(
                  fontSize: 62,
                  height: 1,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFFFF9F93).withValues(alpha: 0.8),
                ),
              ),
            ),
            Positioned(
              left: 56,
              top: 88,
              child: Transform.rotate(
                angle: -0.2,
                child: const Icon(
                  Icons.water_drop_outlined,
                  color: Color(0xFFFF9F93),
                  size: 16,
                ),
              ),
            ),
            const Positioned(
              left: 42,
              top: 102,
              child: Icon(
                Icons.change_history_rounded,
                color: Color(0xFFFF9F93),
                size: 22,
              ),
            ),
            const Positioned(
              left: 160,
              top: 96,
              child: Icon(
                Icons.local_florist_rounded,
                color: Color(0xFFFFC3B7),
                size: 46,
              ),
            ),
            const Positioned(
              left: 222,
              top: 92,
              child: Icon(
                Icons.auto_awesome_rounded,
                color: Color(0xFFFFC3B7),
                size: 18,
              ),
            ),
            const Positioned(
              right: 58,
              top: 388,
              child: Icon(
                Icons.star_rounded,
                color: Color(0xFFF1CFC7),
                size: 76,
              ),
            ),
            const Positioned(
              left: 34,
              bottom: 92,
              child: Icon(
                Icons.school_rounded,
                color: Color(0xFFB7D4CB),
                size: 54,
              ),
            ),
            SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final keyboardVisible = viewInsets.bottom > 0;
                      final compact = constraints.maxHeight < 760;
                      final veryCompact = constraints.maxHeight < 700;
                      final scale = ((constraints.maxHeight -
                                  (keyboardVisible ? 120 : 0)) /
                              860)
                          .clamp(0.68, 1.0);
                      final heroGap = keyboardVisible
                          ? 12.0 * scale
                          : compact
                              ? 16.0 * scale
                              : 28.0 * scale;
                      final topGap = keyboardVisible
                          ? 8.0 * scale
                          : veryCompact
                              ? 18.0 * scale
                              : compact
                                  ? 28.0 * scale
                                  : 54.0 * scale;

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(24, 14, 24, 18),
                        child: Column(
                          children: [
                            SizedBox(height: topGap),
                            LoginQuestBadge(
                              scaleFactor: keyboardVisible ? scale * 0.86 : scale,
                            ),
                            SizedBox(height: heroGap),
                            Text(
                              strings.text('loginHeroTitle'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: keyboardVisible
                                    ? 32 * scale
                                    : compact
                                        ? 36 * scale
                                        : 44 * scale,
                                height: 0.98,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -2,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10 * scale),
                            Text(
                              strings.text('loginHeroBody'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: keyboardVisible
                                    ? 14 * scale
                                    : compact
                                        ? 16 * scale
                                        : 19 * scale,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF666260),
                              ),
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 220),
                              switchInCurve: Curves.easeOutCubic,
                              switchOutCurve: Curves.easeInCubic,
                              child: showEmailForm.value
                                  ? Column(
                                      key: const ValueKey('email-form'),
                                      children: [
                                        SizedBox(
                                          height: keyboardVisible
                                              ? 10 * scale
                                              : compact
                                                  ? 14 * scale
                                                  : 22 * scale,
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: IconButton(
                                            onPressed: () {
                                              showEmailForm.value = false;
                                            },
                                            icon: const Icon(
                                              Icons.arrow_back_rounded,
                                              size: 28,
                                              color: Colors.black,
                                            ),
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(
                                              minWidth: 28,
                                              minHeight: 28,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 4 * scale),
                                        LoginCardPanel(
                                          strings: strings,
                                          usernameController: usernameController,
                                          passwordController: passwordController,
                                          obscurePassword: obscurePassword.value,
                                          onToggleObscurePassword: () {
                                            obscurePassword.value =
                                                !obscurePassword.value;
                                          },
                                          onContinue: onContinue,
                                          scaleFactor: scale,
                                        ),
                                        SizedBox(
                                          height: keyboardVisible
                                              ? 8 * scale
                                              : compact
                                                  ? 12 * scale
                                                  : 20 * scale,
                                        ),
                                      ],
                                    )
                                  : Column(
                                      key: const ValueKey('auth-options'),
                                      children: [
                                        SizedBox(
                                          height: compact ? 20 * scale : 28 * scale,
                                        ),
                                        LoginAuthOptionButton(
                                          label: strings.text('continueWithEmail'),
                                          icon: const Icon(
                                            Icons.mail_outline_rounded,
                                            size: 24,
                                            color: Color(0xFF5A5553),
                                          ),
                                          onTap: () {
                                            showEmailForm.value = true;
                                          },
                                          scaleFactor: scale,
                                        ),
                                        SizedBox(height: 12 * scale),
                                        LoginAuthOptionButton(
                                          label: strings.text('continueWithGoogle'),
                                          icon: const GoogleGlyph(),
                                          onTap: onContinue,
                                          scaleFactor: scale,
                                        ),
                                        SizedBox(height: 12 * scale),
                                        LoginAuthOptionButton(
                                          label: strings.text('continueWithIos'),
                                          icon: const Icon(
                                            Icons.apple_rounded,
                                            size: 24,
                                            color: Color(0xFF5A5553),
                                          ),
                                          onTap: onContinue,
                                          scaleFactor: scale,
                                        ),
                                        SizedBox(
                                          height: compact ? 16 * scale : 22 * scale,
                                        ),
                                      ],
                                    ),
                            ),
                            if (!keyboardVisible)
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${strings.noAccount} ',
                                      style: TextStyle(
                                        fontSize: compact ? 15.5 * scale : 17 * scale,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF615E5D),
                                      ),
                                    ),
                                    TextSpan(
                                      text: strings.register,
                                      style: TextStyle(
                                        fontSize: compact ? 15.5 * scale : 17 * scale,
                                        fontWeight: FontWeight.w900,
                                        color: const Color(0xFF6C50D8),
                                        decoration: TextDecoration.underline,
                                        decorationColor: const Color(0xFFBE9EFF),
                                        decorationThickness: 2.5,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            if (!keyboardVisible) SizedBox(height: 8 * scale),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
