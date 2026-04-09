import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
        decoration: const BoxDecoration(
          color: Color(0xFFF9F4EF),
        ),
        child: Stack(
          children: [
            const Positioned(
              left: -110,
              top: -40,
              child: _BackdropGlow(
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
              child: _BackdropGlow(
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
                            _QuestBadge(
                              scaleFactor:
                                  keyboardVisible ? scale * 0.86 : scale,
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
                                        _LoginCard(
                                          strings: strings,
                                          usernameController:
                                              usernameController,
                                          passwordController:
                                              passwordController,
                                          obscurePassword:
                                              obscurePassword.value,
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
                                          height: compact
                                              ? 20 * scale
                                              : 28 * scale,
                                        ),
                                        _AuthOptionButton(
                                          label:
                                              strings.text('continueWithEmail'),
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
                                        _AuthOptionButton(
                                          label: strings
                                              .text('continueWithGoogle'),
                                          icon: const _GoogleGlyph(),
                                          onTap: onContinue,
                                          scaleFactor: scale,
                                        ),
                                        SizedBox(height: 12 * scale),
                                        _AuthOptionButton(
                                          label:
                                              strings.text('continueWithIos'),
                                          icon: const Icon(
                                            Icons.apple_rounded,
                                            size: 24,
                                            color: Color(0xFF5A5553),
                                          ),
                                          onTap: onContinue,
                                          scaleFactor: scale,
                                        ),
                                        SizedBox(
                                          height: compact
                                              ? 16 * scale
                                              : 22 * scale,
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
                                        fontSize: compact
                                            ? 15.5 * scale
                                            : 17 * scale,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF615E5D),
                                      ),
                                    ),
                                    TextSpan(
                                      text: strings.register,
                                      style: TextStyle(
                                        fontSize: compact
                                            ? 15.5 * scale
                                            : 17 * scale,
                                        fontWeight: FontWeight.w900,
                                        color: const Color(0xFF6C50D8),
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            const Color(0xFFBE9EFF),
                                        decorationThickness: 2.5,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            if (!keyboardVisible)
                              SizedBox(height: 8 * scale),
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

class _LoginCard extends StatelessWidget {
  const _LoginCard({
    required this.strings,
    required this.usernameController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onToggleObscurePassword,
    required this.onContinue,
    required this.scaleFactor,
  });

  final AppStrings strings;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onToggleObscurePassword;
  final VoidCallback onContinue;
  final double scaleFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        18 * scaleFactor,
        18 * scaleFactor,
        18 * scaleFactor,
        18 * scaleFactor,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1FBBB3AC),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FieldLabel(
            text: strings.usernameOrEmail,
            scaleFactor: scaleFactor,
          ),
          SizedBox(height: 10 * scaleFactor),
          _InputShell(
            icon: Icons.person_rounded,
            scaleFactor: scaleFactor,
            child: TextField(
              controller: usernameController,
              style: TextStyle(
                fontSize: 16 * scaleFactor,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF697281),
              ),
              decoration: const InputDecoration(
                hintText: 'explorer@deenrush.com',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                isDense: true,
              ),
            ),
          ),
          SizedBox(height: 16 * scaleFactor),
          _FieldLabel(
            text: strings.password,
            scaleFactor: scaleFactor,
          ),
          SizedBox(height: 10 * scaleFactor),
          _InputShell(
            icon: Icons.lock_rounded,
            scaleFactor: scaleFactor,
            trailing: IconButton(
              onPressed: onToggleObscurePassword,
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: const Color(0xFFB2AEAA),
              ),
            ),
            child: TextField(
              controller: passwordController,
              obscureText: obscurePassword,
              style: TextStyle(
                fontSize: 16 * scaleFactor,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF697281),
              ),
              decoration: const InputDecoration(
                hintText: '••••••••',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                isDense: true,
              ),
            ),
          ),
          SizedBox(height: 8 * scaleFactor),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              strings.forgotPassword,
              style: TextStyle(
                fontSize: 14 * scaleFactor,
                fontWeight: FontWeight.w800,
                color: Color(0xFF6C50D8),
              ),
            ),
          ),
          SizedBox(height: 18 * scaleFactor),
          _PrimaryButton(
            label: strings.signIn,
            onTap: onContinue,
            scaleFactor: scaleFactor,
          ),
        ],
      ),
    );
  }
}

class _QuestBadge extends StatelessWidget {
  const _QuestBadge({required this.scaleFactor});

  final double scaleFactor;

  @override
  Widget build(BuildContext context) {
    final size = 138.0 * scaleFactor;

    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF86F8C8),
        boxShadow: [
          BoxShadow(
            color: Color(0x2600A774),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: ClipPath(
          clipper: const _StarClipper(),
          child: Container(
            width: 52 * scaleFactor,
            height: 52 * scaleFactor,
            color: const Color(0xFF005447),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({
    required this.text,
    required this.scaleFactor,
  });

  final String text;
  final double scaleFactor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 17 * scaleFactor,
        fontWeight: FontWeight.w800,
        color: Colors.black,
      ),
    );
  }
}

class _InputShell extends StatelessWidget {
  const _InputShell({
    required this.icon,
    required this.child,
    required this.scaleFactor,
    this.trailing,
  });

  final IconData icon;
  final Widget child;
  final double scaleFactor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10 * scaleFactor,
        vertical: 4.5 * scaleFactor,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F5F1),
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE7DED7).withValues(alpha: 0.9),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36 * scaleFactor,
            height: 36 * scaleFactor,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF9F5F1),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF8B8887),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: DefaultTextStyle.merge(
              style: TextStyle(
                fontSize: 15.5 * scaleFactor,
                fontWeight: FontWeight.w700,
                color: Color(0xFF70798B),
              ),
              child: child,
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 6),
            trailing!,
          ],
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.onTap,
    required this.scaleFactor,
  });

  final String label;
  final VoidCallback onTap;
  final double scaleFactor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 11.5 * scaleFactor),
        decoration: BoxDecoration(
          color: const Color(0xFFFF7A67),
          borderRadius: BorderRadius.circular(999),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26FF7A67),
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 23 * scaleFactor,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class _AuthOptionButton extends StatelessWidget {
  const _AuthOptionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.scaleFactor,
  });

  final String label;
  final Widget icon;
  final VoidCallback onTap;
  final double scaleFactor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 18 * scaleFactor,
          vertical: 14 * scaleFactor,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.82),
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.8),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16 * scaleFactor,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF4F4B49),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoogleGlyph extends StatelessWidget {
  const _GoogleGlyph();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.72),
      ),
      child: const Text(
        'G',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w900,
          color: Color(0xFF8D8885),
        ),
      ),
    );
  }
}

class _BackdropGlow extends StatelessWidget {
  const _BackdropGlow({
    required this.width,
    required this.height,
    required this.colors,
  });

  final double width;
  final double height;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: colors,
            radius: 0.82,
          ),
        ),
      ),
    );
  }
}

class _StarClipper extends CustomClipper<Path> {
  const _StarClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * 0.42;

    for (var index = 0; index < 10; index++) {
      final radius = index.isEven ? outerRadius : innerRadius;
      final angle = (-math.pi / 2) + (math.pi / 5 * index);
      final point = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );

      if (index == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
