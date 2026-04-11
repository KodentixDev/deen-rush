import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';
import '../data/friends_catalog.dart';
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
            .replaceAll('İ', 'i')
            .replaceAll('I', 'ı')
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
        capitalizedFirst = 'İ';
      } else if (first == 'ı') {
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
    final display = (String value) => _displayText(value, strings.locale);

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
        builder: (context) => _LogoutDialog(
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
          const Positioned.fill(child: _ProfileBackground()),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BackCircle(onTap: widget.onBackRequested),
                const SizedBox(height: 14),
                const Center(child: _AvatarCard()),
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
                _Panel(
                  child: _ActionTile(
                    icon: Icons.group_outlined,
                    title: display(strings.text('profileFriends')),
                    onTap: openFriends,
                    trailing: _FriendStrip(friendIds: _friendIds),
                  ),
                ),
                const SizedBox(height: 10),
                _Panel(
                  child: _ActionTile(
                    icon: Icons.mode_edit_outline_rounded,
                    title: display(strings.text('profileEditProfile')),
                    onTap: openEdit,
                  ),
                ),
                const SizedBox(height: 10),
                _Panel(
                  child: Column(
                    children: [
                      _ActionTile(
                        icon: Icons.language_rounded,
                        title: display(strings.language),
                        value: strings.localeLabel(widget.currentLocale),
                        onTap: openLanguage,
                      ),
                      const Divider(height: 1),
                      _SwitchTile(
                        icon: Icons.volume_up_outlined,
                        title: display(strings.text('profileEffectSound')),
                        value: _soundOn,
                        onChanged: () => setState(() => _soundOn = !_soundOn),
                      ),
                      const Divider(height: 1),
                      _SwitchTile(
                        icon: Icons.music_note_rounded,
                        title: display(strings.text('settingsMusic')),
                        value: _musicOn,
                        onChanged: () => setState(() => _musicOn = !_musicOn),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _Panel(
                  child: Column(
                    children: [
                      _ActionTile(
                        icon: Icons.description_outlined,
                        title: display(strings.terms),
                      ),
                      const Divider(height: 1),
                      _ActionTile(
                        icon: Icons.shield_outlined,
                        title: display(strings.privacy),
                      ),
                      const Divider(height: 1),
                      _ActionTile(
                        icon: Icons.logout_rounded,
                        title: display(strings.text('settingsLogout')),
                        onTap: confirmLogout,
                        trailing: const SizedBox.shrink(),
                      ),
                      const Divider(height: 1),
                      _ActionTile(
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

class _ProfileBackground extends StatelessWidget {
  const _ProfileBackground();

  @override
  Widget build(BuildContext context) => Stack(children: const [
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
        _Glow(top: -40, right: -54, size: 200),
        _Glow(bottom: -30, left: -32, size: 150),
      ]);
}

class _Glow extends StatelessWidget {
  const _Glow({this.top, this.right, this.bottom, this.left, required this.size});
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

class _AvatarCard extends StatelessWidget {
  const _AvatarCard();

  @override
  Widget build(BuildContext context) => Container(
        width: 106,
        height: 106,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(Icons.face_3_rounded, size: 60, color: Color(0xFFFFD053)),
      );
}

class _Panel extends StatelessWidget {
  const _Panel({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE7DDF9),
          borderRadius: BorderRadius.circular(22),
        ),
        child: child,
      );
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    this.onTap,
    this.value,
    this.trailing,
    this.titleColor = const Color(0xFF3D2A67),
    this.iconColor = const Color(0xFF3D2A67),
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final String? value;
  final Widget? trailing;
  final Color titleColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Row(
            children: [
              Icon(icon, size: 22, color: iconColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                  ),
                ),
              ),
              if (value != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    value!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7A699F),
                    ),
                  ),
                ),
              trailing ?? const Icon(Icons.chevron_right_rounded, color: Color(0xFF8B8897)),
            ],
          ),
        ),
      );
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({required this.icon, required this.title, required this.value, required this.onChanged});
  final IconData icon;
  final String title;
  final bool value;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 22, color: const Color(0xFF3D2A67)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3D2A67),
                ),
              ),
            ),
            GestureDetector(
              onTap: onChanged,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 40,
                height: 24,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: value ? const Color(0xFF6F36F4) : const Color(0xFFC9C9C9),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 180),
                  alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: SizedBox(width: 18, height: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class _FriendStrip extends StatelessWidget {
  const _FriendStrip({
    required this.friendIds,
  });

  final Set<String> friendIds;

  @override
  Widget build(BuildContext context) {
    final visibleFriends = friendsCatalog
        .where((friend) => friendIds.contains(friend.id))
        .take(4)
        .toList();
    final remainingCount = friendIds.length - visibleFriends.length;

    return SizedBox(
      width: 128,
      height: 28,
      child: Stack(
        children: [
          if (remainingCount > 0)
            Positioned(
              right: 0,
              child: _FriendBubble(label: '+$remainingCount'),
            ),
          ...List.generate(
            visibleFriends.length,
            (index) {
              final friend = visibleFriends[index];
              final right = remainingCount > 0
                  ? 24.0 * (index + 1)
                  : 24.0 * index;
              return Positioned(
                right: right,
                child: _FriendBubble(
                  icon: friend.icon,
                  color: friend.avatarColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FriendBubble extends StatelessWidget {
  const _FriendBubble({this.icon, this.label, this.color = Colors.white});
  final IconData? icon;
  final String? label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle, border: Border.all(color: const Color(0xFF8E45FE), width: 2)),
        alignment: Alignment.center,
        child: label != null
            ? Text(label!, style: const TextStyle(fontSize: 10, color: Color(0xFF6F36F4), fontWeight: FontWeight.w700))
            : Icon(icon, size: 16, color: const Color(0xFF6F36F4)),
      );
}

class _LogoutDialog extends StatelessWidget {
  const _LogoutDialog({required this.title, required this.message, required this.cancel, required this.ok});
  final String title;
  final String message;
  final String cancel;
  final String ok;

  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 24, 18, 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF8E45FE), Color(0xFF6E68F8)],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
            const SizedBox(height: 14),
            Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, color: Color(0xE8FFFFFF))),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF2EA0FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: Text(cancel),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFDF3F),
                    foregroundColor: const Color(0xFF8D5A00),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: Text(ok),
                ),
              ),
            ]),
          ]),
        ),
      );
}
