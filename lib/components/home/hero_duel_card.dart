import 'package:flutter/material.dart';

import '../../config/app_assets.dart';
import '../../l10n/app_strings.dart';

class HeroDuelCard extends StatelessWidget {
  const HeroDuelCard({
    super.key,
    required this.strings,
  });

  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF9C91C),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                strings.liveNow,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF5C4700),
                ),
              ),
            ),
          ),
          Container(
            width: 218,
            height: 218,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFD2FF58),
                  Color(0xFFAAFF35),
                ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.72),
                width: 6,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFA7FF33).withValues(alpha: 0.35),
                  blurRadius: 30,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 22,
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    size: 24,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 94,
                      height: 94,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.24),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          AppAssets.logo,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Text(
                        strings.duelTitle,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1F3117),
                          height: 1.02,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.26),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        strings.duelSubtitle,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF355021),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            strings.duelHint,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF98A1B1),
            ),
          ),
        ],
      ),
    );
  }
}
