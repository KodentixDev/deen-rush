import 'package:flutter/material.dart';

import '../../data/friends_catalog.dart';

class ProfileBackground extends StatelessWidget {
  const ProfileBackground({super.key});

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
        _ProfileGlow(top: -40, right: -54, size: 200),
        _ProfileGlow(bottom: -30, left: -32, size: 150),
      ]);
}

class ProfileBackCircle extends StatelessWidget {
  const ProfileBackCircle({
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

class ProfileAvatarCard extends StatelessWidget {
  const ProfileAvatarCard({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: 106,
        height: 106,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(
          Icons.face_3_rounded,
          size: 60,
          color: Color(0xFFFFD053),
        ),
      );
}

class ProfilePanel extends StatelessWidget {
  const ProfilePanel({
    super.key,
    required this.child,
  });

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

class ProfileActionTile extends StatelessWidget {
  const ProfileActionTile({
    super.key,
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
              trailing ??
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF8B8897),
                  ),
            ],
          ),
        ),
      );
}

class ProfileSwitchTile extends StatelessWidget {
  const ProfileSwitchTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

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
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(width: 18, height: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class ProfileFriendStrip extends StatelessWidget {
  const ProfileFriendStrip({
    super.key,
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
              child: _ProfileFriendBubble(label: '+$remainingCount'),
            ),
          ...List.generate(visibleFriends.length, (index) {
            final friend = visibleFriends[index];
            final right = remainingCount > 0 ? 24.0 * (index + 1) : 24.0 * index;
            return Positioned(
              right: right,
              child: _ProfileFriendBubble(
                icon: friend.icon,
                color: friend.avatarColor,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class ProfileLogoutDialog extends StatelessWidget {
  const ProfileLogoutDialog({
    super.key,
    required this.title,
    required this.message,
    required this.cancel,
    required this.ok,
  });

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: Color(0xE8FFFFFF)),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF2EA0FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(ok),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

class _ProfileGlow extends StatelessWidget {
  const _ProfileGlow({
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

class _ProfileFriendBubble extends StatelessWidget {
  const _ProfileFriendBubble({
    this.icon,
    this.label,
    this.color = Colors.white,
  });

  final IconData? icon;
  final String? label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF8E45FE), width: 2),
        ),
        alignment: Alignment.center,
        child: label != null
            ? Text(
                label!,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF6F36F4),
                  fontWeight: FontWeight.w700,
                ),
              )
            : Icon(icon, size: 16, color: const Color(0xFF6F36F4)),
      );
}
