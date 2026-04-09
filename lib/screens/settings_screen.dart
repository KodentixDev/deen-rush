import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../l10n/app_strings.dart';

class SettingsScreen extends HookWidget {
  const SettingsScreen({
    super.key,
    required this.currentLocale,
    required this.themeMode,
    required this.onLocaleChanged,
    required this.onThemeModeChanged,
    required this.onLogout,
    this.onBackRequested,
  });

  final Locale currentLocale;
  final ThemeMode themeMode;
  final ValueChanged<Locale> onLocaleChanged;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final VoidCallback onLogout;
  final VoidCallback? onBackRequested;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final soundEnabled = useState(true);
    final musicEnabled = useState(true);
    final hapticEnabled = useState(false);
    final notificationsEnabled = useState(true);
    final isDarkMode = themeMode == ThemeMode.dark;

    Future<void> openLanguagePicker() async {
      final selectedLocale = await showModalBottomSheet<Locale>(
        context: context,
        backgroundColor: const Color(0xFFFFFBF8),
        showDragHandle: true,
        builder: (context) {
          return SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.72,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
                child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strings.text('language'),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...AppStrings.supportedLocales.map(
                    (locale) {
                      final isSelected =
                          locale.languageCode == currentLocale.languageCode;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () => Navigator.of(context).pop(locale),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFFFEEE9)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: (isSelected
                                          ? const Color(0xFFFF7A67)
                                          : const Color(0xFFE7E1DB))
                                      .withValues(alpha: 0.28),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    strings.localeLabel(locale),
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(
                                    Icons.check_rounded,
                                    color: Color(0xFFFF7A67),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              ),
            ),
          );
        },
      );

      if (selectedLocale != null) {
        onLocaleChanged(selectedLocale);
      }
    }

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0xFFF9F4EF),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: 56,
            right: -80,
            child: _BackdropGlow(
              width: 250,
              height: 320,
              colors: [
                Color(0x26D7CBFF),
                Color(0x12EFE9FF),
                Colors.transparent,
              ],
            ),
          ),
          const Positioned(
            left: -70,
            top: 360,
            child: _BackdropGlow(
              width: 220,
              height: 220,
              colors: [
                Color(0x1AB9F6DC),
                Colors.transparent,
              ],
            ),
          ),
          Positioned(
            left: -42,
            bottom: 126,
            child: Transform.rotate(
              angle: -0.2,
              child: Container(
                width: 146,
                height: 180,
                decoration: BoxDecoration(
                  color: const Color(0xFFDDF5E8),
                  borderRadius: BorderRadius.circular(38),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SettingsHeader(
                  title: strings.text('settingsTitle'),
                  onBackRequested: onBackRequested ??
                      () {
                        Navigator.of(context).maybePop();
                      },
                ),
                const SizedBox(height: 24),
                _SectionHeading(
                  icon: Icons.sports_esports_rounded,
                  iconColor: const Color(0xFFB7462F),
                  title: strings.text('settingsGameSectionTitle'),
                ),
                const SizedBox(height: 10),
                _SettingsTile(
                  icon: Icons.volume_up_rounded,
                  iconBubbleColor: const Color(0xFFFFE5DF),
                  iconColor: const Color(0xFFB7462F),
                  title: strings.text('settingsSound'),
                  trailing: _NeoSwitch(
                    value: soundEnabled.value,
                    onChanged: () => soundEnabled.value = !soundEnabled.value,
                  ),
                  onTap: () => soundEnabled.value = !soundEnabled.value,
                ),
                const SizedBox(height: 12),
                _SettingsTile(
                  icon: Icons.music_note_rounded,
                  iconBubbleColor: const Color(0xFFEEE7FF),
                  iconColor: const Color(0xFF6C50D8),
                  title: strings.text('settingsMusic'),
                  trailing: _NeoSwitch(
                    value: musicEnabled.value,
                    onChanged: () => musicEnabled.value = !musicEnabled.value,
                  ),
                  onTap: () => musicEnabled.value = !musicEnabled.value,
                ),
                const SizedBox(height: 12),
                _SettingsTile(
                  icon: Icons.vibration_rounded,
                  iconBubbleColor: const Color(0xFFE0F7EC),
                  iconColor: const Color(0xFF0A7A63),
                  title: strings.text('settingsHaptic'),
                  trailing: _NeoSwitch(
                    value: hapticEnabled.value,
                    onChanged: () => hapticEnabled.value = !hapticEnabled.value,
                  ),
                  onTap: () => hapticEnabled.value = !hapticEnabled.value,
                ),
                const SizedBox(height: 24),
                _SectionHeading(
                  icon: Icons.settings_rounded,
                  iconColor: const Color(0xFF6C50D8),
                  boxed: true,
                  title: strings.text('settingsAppSectionTitle'),
                ),
                const SizedBox(height: 10),
                _SettingsTile(
                  icon: Icons.language_rounded,
                  iconBubbleColor: const Color(0xFFFFE6E0),
                  iconColor: const Color(0xFFB7462F),
                  title: strings.text('language'),
                  subtitle: strings.localeLabel(currentLocale),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    size: 30,
                    color: Color(0xFF8B8686),
                  ),
                  onTap: openLanguagePicker,
                ),
                const SizedBox(height: 12),
                _SettingsTile(
                  icon: Icons.nightlight_round,
                  iconBubbleColor: const Color(0xFFEEE7FF),
                  iconColor: const Color(0xFF6C50D8),
                  title: strings.text('darkMode'),
                  trailing: _NeoSwitch(
                    value: isDarkMode,
                    onChanged: () {
                      onThemeModeChanged(
                        isDarkMode ? ThemeMode.light : ThemeMode.dark,
                      );
                    },
                  ),
                  onTap: () {
                    onThemeModeChanged(
                      isDarkMode ? ThemeMode.light : ThemeMode.dark,
                    );
                  },
                ),
                const SizedBox(height: 12),
                _SettingsTile(
                  icon: Icons.notifications_rounded,
                  iconBubbleColor: const Color(0xFFE0F7EC),
                  iconColor: const Color(0xFF0A7A63),
                  title: strings.text('settingsNotifications'),
                  trailing: _NeoSwitch(
                    value: notificationsEnabled.value,
                    onChanged: () =>
                        notificationsEnabled.value = !notificationsEnabled.value,
                  ),
                  onTap: () =>
                      notificationsEnabled.value = !notificationsEnabled.value,
                ),
                const SizedBox(height: 24),
                _SectionHeading(
                  icon: Icons.person_rounded,
                  iconColor: const Color(0xFF0A7A63),
                  title: strings.text('settingsAccountSectionTitle'),
                ),
                const SizedBox(height: 10),
                _SettingsTile(
                  icon: Icons.logout_rounded,
                  iconBubbleColor: const Color(0xFFFFE5DF),
                  iconColor: const Color(0xFFB7462F),
                  title: strings.text('settingsLogout'),
                  titleColor: const Color(0xFFB7462F),
                  onTap: onLogout,
                ),
                const SizedBox(height: 12),
                _SettingsTile(
                  icon: Icons.delete_forever_rounded,
                  iconBubbleColor: const Color(0xFFF0B5C3),
                  iconColor: const Color(0xFFB60F45),
                  title: strings.text('settingsDeleteAccount'),
                  titleColor: const Color(0xFFB60F45),
                  backgroundColor: const Color(0xFFF9E0E4),
                  borderColor: Colors.transparent,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader({
    required this.title,
    required this.onBackRequested,
  });

  final String title;
  final VoidCallback onBackRequested;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onBackRequested,
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 32,
            color: Colors.black,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
            minWidth: 32,
            minHeight: 32,
          ),
          splashRadius: 22,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 28,
              height: 1,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.3,
              color: Colors.black,
            ),
          ),
        ),
        const Icon(
          Icons.star_rounded,
          size: 30,
          color: Color(0xFFFF7A67),
        ),
        const SizedBox(width: 10),
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: Center(
            child: Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFF4ED),
              ),
              child: const Icon(
                Icons.person_rounded,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.boxed = false,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final bool boxed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        boxed
            ? Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.settings_rounded,
                  size: 16,
                  color: Colors.white,
                ),
              )
            : Icon(
                icon,
                size: 24,
                color: iconColor,
              ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1D1B1B),
            ),
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.iconBubbleColor,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.titleColor = const Color(0xFF1D1B1B),
  });

  final IconData icon;
  final Color iconBubbleColor;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(34),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(34),
            border: borderColor == Colors.transparent
                ? null
                : Border.all(color: borderColor, width: 3),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE9E2DB).withValues(alpha: 0.8),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconBubbleColor,
                ),
                child: Icon(
                  icon,
                  size: 26,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: titleColor,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF706B6B),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 10),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NeoSwitch extends StatelessWidget {
  const _NeoSwitch({
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 58,
        height: 34,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: value ? const Color(0xFF93F0CB) : Colors.white,
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.10),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
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
