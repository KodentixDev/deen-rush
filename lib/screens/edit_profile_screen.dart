import 'package:flutter/material.dart';
import '../l10n/app_strings.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _name = TextEditingController(text: 'Mr Dat');
  late final TextEditingController _bio = TextEditingController();
  late final TextEditingController _email =
      TextEditingController(text: 'abc@domain.com');
  String _country = 'us';

  @override
  void dispose() {
    _name.dispose();
    _bio.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF8E45FE),
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(child: _PurpleBackground()),
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BackCircle(onTap: () => Navigator.of(context).pop()),
                  const SizedBox(height: 18),
                  Text(
                    strings.text('editProfileTitle'),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Center(child: _EditAvatar()),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.fromLTRB(14, 18, 14, 22),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7DDF9),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        _FieldLabel(label: strings.text('editProfileName')),
                        _Input(controller: _name),
                        const SizedBox(height: 14),
                        _FieldLabel(label: strings.text('editProfileBio')),
                        _Input(
                          controller: _bio,
                          hintText: strings.text('editProfileBioHint'),
                        ),
                        const SizedBox(height: 14),
                        _FieldLabel(label: strings.text('editProfileEmail')),
                        _Input(controller: _email, readOnly: true),
                        const SizedBox(height: 14),
                        _FieldLabel(label: strings.text('editProfileCountry')),
                        DropdownButtonFormField<String>(
                          initialValue: _country,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'us',
                              child: Text(
                                '🇺🇸  ${strings.text('countryUnitedStates')}',
                              ),
                            ),
                            const DropdownMenuItem(
                              value: 'tr',
                              child: Text('🇹🇷  Turkiye'),
                            ),
                            const DropdownMenuItem(
                              value: 'az',
                              child: Text('🇦🇿  Azerbaijan'),
                            ),
                          ],
                          onChanged: (value) =>
                              setState(() => _country = value ?? 'us'),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFDF3F),
                              foregroundColor: const Color(0xFF8D5A00),
                              elevation: 8,
                              shadowColor: const Color(0x55FFD83D),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text(strings.text('editProfileSave')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PurpleBackground extends StatelessWidget {
  const _PurpleBackground();

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
      _BgGlow(top: -40, right: -52, size: 200),
      _BgGlow(bottom: -24, left: -36, size: 140),
    ]);
  }
}

class _BgGlow extends StatelessWidget {
  const _BgGlow({this.top, this.right, this.bottom, this.left, required this.size});
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

class _BackCircle extends StatelessWidget {
  const _BackCircle({required this.onTap});
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

class _EditAvatar extends StatelessWidget {
  const _EditAvatar();

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
            child: const Icon(Icons.face_3_rounded, size: 62, color: Color(0xFFFFD053)),
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
              child: const Icon(Icons.camera_alt_outlined, size: 16, color: Color(0xFF8E45FE)),
            ),
          ),
        ],
      );
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label});
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

class _Input extends StatelessWidget {
  const _Input({required this.controller, this.hintText, this.readOnly = false});
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
