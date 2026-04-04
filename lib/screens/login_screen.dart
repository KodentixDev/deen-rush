import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../components/login/login_form_card.dart';
import '../components/login/login_intro.dart';
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
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscurePassword = useState(true);

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: ColoredBox(color: Color(0xFFF7FAFD)),
          ),
          const Positioned.fill(child: _LoginDotsOverlay()),
          Positioned(
            top: -120,
            left: -80,
            child: _BlurBlob(
              size: 240,
              colors: const [
                Color(0x4D9BE7E8),
                Color(0x009BE7E8),
              ],
            ),
          ),
          Positioned(
            bottom: -120,
            right: -90,
            child: _BlurBlob(
              size: 260,
              colors: const [
                Color(0x4DE6F79C),
                Color(0x00E6F79C),
              ],
            ),
          ),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
                  child: Column(
                    children: [
                      LoginIntro(strings: strings),
                      const SizedBox(height: 26),
                      LoginFormCard(
                        strings: strings,
                        usernameController: usernameController,
                        passwordController: passwordController,
                        obscurePassword: obscurePassword.value,
                        onToggleObscurePassword: () {
                          obscurePassword.value = !obscurePassword.value;
                        },
                        onContinue: onContinue,
                      ),
                      const SizedBox(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            strings.noAccount,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF5A6270),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            strings.register,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF006E69),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            strings.terms,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFA9AFB8),
                              letterSpacing: 1,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              '•',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFFC7CCD4),
                              ),
                            ),
                          ),
                          Text(
                            strings.privacy,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFA9AFB8),
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginDotsOverlay extends StatelessWidget {
  const _LoginDotsOverlay();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LoginDotsPainter(),
    );
  }
}

class _LoginDotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final tealPaint = Paint()..color = const Color(0xFF8ED9E0).withValues(alpha: 0.42);
    final limePaint = Paint()..color = const Color(0xFFC8E97B).withValues(alpha: 0.36);

    const spacing = 36.0;
    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        final useTeal = ((x / spacing).round() + (y / spacing).round()).isEven;
        canvas.drawCircle(
          Offset(x + 6, y + 6),
          1.1,
          useTeal ? tealPaint : limePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BlurBlob extends StatelessWidget {
  const _BlurBlob({
    required this.size,
    required this.colors,
  });

  final double size;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: colors),
      ),
    );
  }
}
