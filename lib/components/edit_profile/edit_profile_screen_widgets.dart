import 'package:flutter/material.dart';

class EditProfileBackground extends StatelessWidget {
  const EditProfileBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: const [
      Positioned.fill(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF8E45FE), Color(0xFF6E68F8)],
            ),
          ),
        ),
      ),
      _EditProfileGlow(top: -40, right: -52, size: 200),
      _EditProfileGlow(bottom: -24, left: -36, size: 140),
    ]);
  }
}

class EditProfileBackCircle extends StatelessWidget {
  const EditProfileBackCircle({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.14),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
        ),
      );
}

class EditProfileAvatar extends StatelessWidget {
  const EditProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) => Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 108,
            height: 108,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.face_3_rounded,
              size: 62,
              color: Color(0xFFFFD053),
            ),
          ),
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                size: 16,
                color: Color(0xFF8E45FE),
              ),
            ),
          ),
        ],
      );
}

class EditProfileFieldLabel extends StatelessWidget {
  const EditProfileFieldLabel({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: const TextStyle(fontSize: 15, color: Color(0xFF3B3553)),
          ),
        ),
      );
}

class EditProfileInput extends StatelessWidget {
  const EditProfileInput({
    super.key,
    required this.controller,
    this.hintText,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String? hintText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: readOnly ? const Color(0xFFE1E1E1) : Colors.white,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            borderSide: BorderSide.none,
          ),
        ),
      );
}

class _EditProfileGlow extends StatelessWidget {
  const _EditProfileGlow({
    this.top,
    this.right,
    this.bottom,
    this.left,
    required this.size,
  });

  final double? top;
  final double? right;
  final double? bottom;
  final double? left;
  final double size;

  @override
  Widget build(BuildContext context) => Positioned(
        top: top,
        right: right,
        bottom: bottom,
        left: left,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.white.withValues(alpha: 0.08),
                Colors.white.withValues(alpha: 0),
              ],
            ),
          ),
        ),
      );
}
