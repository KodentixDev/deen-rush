import 'package:flutter/material.dart';

import '../components/profile/profile_screen_widgets.dart';
import '../l10n/app_strings.dart';
import 'edit_profile_screen.dart';
import 'friends_screen.dart';
import 'language_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.currentLocale,
    required this.onLocaleChanged,
    required this.onLogout,
    required this.onBackRequested,
  });

  final Locale currentLocale;
  final ValueChanged<Locale> onLocaleChanged;
  final VoidCallback onLogout;
  final VoidCallback onBackRequested;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _soundOn = true;
  bool _musicOn = false;
  final Set<String> _friendIds = {
    'mr_dat',
    'soham',
    'darlene',
    'gladys',
    'debra',
    'shane',
    'victoria',
    'aubrey',
  };

  String _displayText(String value, Locale locale) {
    final languageCode = locale.languageCode;
    final lower = (languageCode == 'tr' || languageCode == 'az')
        ? value
            .replaceAll('I', 'i')
            .replaceAll('I', 'i')
            .toLowerCase()
        : value.toLowerCase();

    return lower
        .split(RegExp(r'\s+'))
        .map((word) => _capitalizeWord(word, languageCode))
        .join(' ');
  }

  String _capitalizeWord(String value, String languageCode) {
    if (value.isEmpty) {
      return value;
    }

    final first = value[0];
    final rest = value.substring(1);
    String capitalizedFirst;

    if (languageCode == 'tr' || languageCode == 'az') {
      if (first == 'i') {
        capitalizedFirst = 'I';
      } else {
        capitalizedFirst = first.toUpperCase();
      }
    } else {
      capitalizedFirst = first.toUpperCase();
    }

    return '$capitalizedFirst$rest';
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    String display(String value) => _displayText(value, strings.locale);

    Future<void> openEdit() async {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => const EditProfileScreen()),
      );
    }

    Future<void> openLanguage() async {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => LanguageScreen(
            currentLocale: widget.currentLocale,
            onLocaleChanged: widget.onLocaleChanged,
          ),
        ),
      );
    }

    Future<void> openFriends() async {
      final updatedIds = await Navigator.of(context).push<Set<String>>(
        MaterialPageRoute<Set<String>>(
          builder: (_) => FriendsScreen(initialFriendIds: _friendIds),
        ),
      );

      if (updatedIds != null) {
        setState(() {
          _friendIds
            ..clear()
            ..addAll(updatedIds);
        });
      }
    }

    Future<void> confirmLogout() async {
      final shouldLogout = await showDialog<bool>(
        context: context,
        barrierColor: Colors.black.withValues(alpha: 0.46),
        builder: (context) => ProfileLogoutDialog(
          title: display(strings.text('settingsLogout')),
          message: strings.text('logoutMessage'),
          cancel: strings.text('dialogCancel'),
          ok: strings.text('dialogOk'),
        ),
      );
      if (shouldLogout == true) {
        widget.onLogout();
      }
    }

    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xFF8E45FE)),
      child: Stack(
        children: [
          const Positioned.fill(child: ProfileBackground()),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileBackCircle(onTap: widget.onBackRequested),
                const SizedBox(height: 14),
                const Center(child: ProfileAvatarCard()),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    strings.text('homeGreetingName'),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    strings.text('homePlayEnjoy'),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFF1E8FF),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                ProfilePanel(
                  child: ProfileActionTile(
                    icon: Icons.group_outlined,
                    title: display(strings.text('profileFriends')),
                    onTap: openFriends,
                    trailing: ProfileFriendStrip(friendIds: _friendIds),
                  ),
                ),
                const SizedBox(height: 10),
                ProfilePanel(
                  child: ProfileActionTile(
                    icon: Icons.mode_edit_outline_rounded,
                    title: display(strings.text('profileEditProfile')),
                    onTap: openEdit,
                  ),
                ),
                const SizedBox(height: 10),
                ProfilePanel(
                  child: Column(
                    children: [
                      ProfileActionTile(
                        icon: Icons.language_rounded,
                        title: display(strings.language),
                        value: strings.localeLabel(widget.currentLocale),
                        onTap: openLanguage,
                      ),
                      const Divider(height: 1),
                      ProfileSwitchTile(
                        icon: Icons.volume_up_outlined,
                        title: display(strings.text('profileEffectSound')),
                        value: _soundOn,
                        onChanged: () => setState(() => _soundOn = !_soundOn),
                      ),
                      const Divider(height: 1),
                      ProfileSwitchTile(
                        icon: Icons.music_note_rounded,
                        title: display(strings.text('settingsMusic')),
                        value: _musicOn,
                        onChanged: () => setState(() => _musicOn = !_musicOn),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ProfilePanel(
                  child: Column(
                    children: [
                      ProfileActionTile(
                        icon: Icons.description_outlined,
                        title: display(strings.terms),
                      ),
                      const Divider(height: 1),
                      ProfileActionTile(
                        icon: Icons.shield_outlined,
                        title: display(strings.privacy),
                      ),
                      const Divider(height: 1),
                      ProfileActionTile(
                        icon: Icons.logout_rounded,
                        title: display(strings.text('settingsLogout')),
                        onTap: confirmLogout,
                        trailing: const SizedBox.shrink(),
                      ),
                      const Divider(height: 1),
                      ProfileActionTile(
                        icon: Icons.delete_outline_rounded,
                        title: display(strings.text('profileCleanResource')),
                        titleColor: const Color(0xFFFF6B6B),
                        iconColor: const Color(0xFFFF6B6B),
                        trailing: const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
