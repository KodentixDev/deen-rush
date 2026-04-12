import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../l10n/app_strings.dart';

class LoginCardPanel extends StatelessWidget {
  const LoginCardPanel({
    super.key,
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
          _LoginFieldLabel(
            text: strings.usernameOrEmail,
            scaleFactor: scaleFactor,
          ),
          SizedBox(height: 10 * scaleFactor),
          _LoginInputShell(
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
          _LoginFieldLabel(
            text: strings.password,
            scaleFactor: scaleFactor,
          ),
          SizedBox(height: 10 * scaleFactor),
          _LoginInputShell(
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
                hintText: '********',
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
                color: const Color(0xFF6C50D8),
              ),
            ),
          ),
          SizedBox(height: 18 * scaleFactor),
          LoginPrimaryButton(
            label: strings.signIn,
            onTap: onContinue,
            scaleFactor: scaleFactor,
          ),
        ],
      ),
    );
  }
}

class LoginQuestBadge extends StatelessWidget {
  const LoginQuestBadge({
    super.key,
    required this.scaleFactor,
  });

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

class LoginPrimaryButton extends StatelessWidget {
  const LoginPrimaryButton({
    super.key,
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

class LoginAuthOptionButton extends StatelessWidget {
  const LoginAuthOptionButton({
    super.key,
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

class GoogleGlyph extends StatelessWidget {
  const GoogleGlyph({super.key});

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

class LoginBackdropGlow extends StatelessWidget {
  const LoginBackdropGlow({
    super.key,
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

class _LoginFieldLabel extends StatelessWidget {
  const _LoginFieldLabel({
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

class _LoginInputShell extends StatelessWidget {
  const _LoginInputShell({
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
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF9F5F1),
            ),
            child: Icon(icon, color: const Color(0xFF8B8887)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: DefaultTextStyle.merge(
              style: TextStyle(
                fontSize: 15.5 * scaleFactor,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF70798B),
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
