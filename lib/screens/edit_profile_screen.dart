import 'package:flutter/material.dart';

import '../components/edit_profile/edit_profile_screen_widgets.dart';
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
            const Positioned.fill(child: EditProfileBackground()),
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EditProfileBackCircle(onTap: () => Navigator.of(context).pop()),
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
                  const Center(child: EditProfileAvatar()),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.fromLTRB(14, 18, 14, 22),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7DDF9),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        EditProfileFieldLabel(label: strings.text('editProfileName')),
                        EditProfileInput(controller: _name),
                        const SizedBox(height: 14),
                        EditProfileFieldLabel(label: strings.text('editProfileBio')),
                        EditProfileInput(
                          controller: _bio,
                          hintText: strings.text('editProfileBioHint'),
                        ),
                        const SizedBox(height: 14),
                        EditProfileFieldLabel(label: strings.text('editProfileEmail')),
                        EditProfileInput(controller: _email, readOnly: true),
                        const SizedBox(height: 14),
                        EditProfileFieldLabel(
                          label: strings.text('editProfileCountry'),
                        ),
                        DropdownButtonFormField<String>(
                          initialValue: _country,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(18)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(18)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'us',
                              child: Text(
                                '\ud83c\uddfa\ud83c\uddf8  ${strings.text('countryUnitedStates')}',
                              ),
                            ),
                            const DropdownMenuItem(
                              value: 'tr',
                              child: Text('\ud83c\uddf9\ud83c\uddf7  Turkiye'),
                            ),
                            const DropdownMenuItem(
                              value: 'az',
                              child: Text('\ud83c\udde6\ud83c\uddff  Azerbaijan'),
                            ),
                          ],
                          onChanged: (value) => setState(() => _country = value ?? 'us'),
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
                              padding: const EdgeInsets.symmetric(vertical: 18),
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
