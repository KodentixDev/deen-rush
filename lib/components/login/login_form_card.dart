import 'package:flutter/material.dart';

import '../../l10n/app_strings.dart';

class LoginFormCard extends StatelessWidget {
  const LoginFormCard({
    super.key,
    required this.strings,
    required this.usernameController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onToggleObscurePassword,
    required this.onContinue,
  });

  final AppStrings strings;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onToggleObscurePassword;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF006E69).withValues(alpha: 0.05),
            blurRadius: 32,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -8,
            right: -18,
            child: Container(
              width: 128,
              height: 128,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0x33FFE79C),
                    Color(0x12FFE79C),
                  ],
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FieldLabel(text: strings.usernameOrEmail),
              const SizedBox(height: 12),
              _InputShell(
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: strings.usernameHint,
                    prefixIcon: const Icon(
                      Icons.person_rounded,
                      color: Color(0xFFACB2BC),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _FieldLabel(text: strings.password),
              const SizedBox(height: 12),
              _InputShell(
                child: TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    prefixIcon: const Icon(
                      Icons.lock_rounded,
                      color: Color(0xFFACB2BC),
                    ),
                    suffixIcon: IconButton(
                      onPressed: onToggleObscurePassword,
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        color: const Color(0xFF9FA5AF),
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  strings.forgotPassword,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF006E69),
                  ),
                ),
              ),
              const SizedBox(height: 26),
              _PrimaryCtaButton(
                label: strings.signIn,
                onTap: onContinue,
              ),
              const SizedBox(height: 28),
              _SectionDivider(label: strings.continueWith),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _SocialButton(
                      icon: Icons.g_mobiledata_rounded,
                      label: strings.google,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _SocialButton(
                      icon: Icons.apple_rounded,
                      label: strings.apple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _GuestButton(
                label: strings.guestPlay,
                onTap: onContinue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: Color(0xFF4B4F57),
      ),
    );
  }
}

class _InputShell extends StatelessWidget {
  const _InputShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F3F7),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DefaultTextStyle.merge(
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Color(0xFF55606F),
        ),
        child: child,
      ),
    );
  }
}

class _PrimaryCtaButton extends StatelessWidget {
  const _PrimaryCtaButton({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF477F00),
              Color(0xFFADFF32),
            ],
          ),
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA5FF31).withValues(alpha: 0.35),
              blurRadius: 22,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF284700),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.play_arrow_rounded,
              size: 28,
              color: Color(0xFF284700),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Color(0xFFE4E7EC),
            thickness: 1.4,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFFA6ACB5),
              letterSpacing: 1,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Color(0xFFE4E7EC),
            thickness: 1.4,
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F3F7),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: const Color(0xFF3F4955)),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Color(0xFF4E5563),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GuestButton extends StatelessWidget {
  const _GuestButton({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFFFF4C6),
              Color(0xFFFFECA3),
            ],
          ),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person_pin_circle_rounded,
              size: 28,
              color: Color(0xFF856A00),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF856A00),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
