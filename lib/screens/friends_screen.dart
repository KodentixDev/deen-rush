import 'package:flutter/material.dart';

import '../data/friends_catalog.dart';
import '../l10n/app_strings.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({
    super.key,
    required this.initialFriendIds,
  });

  final Set<String> initialFriendIds;

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  late Set<String> _friendIds;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _friendIds = {...widget.initialFriendIds};
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final visibleFriends = friendsCatalog
        .where((friend) => _friendIds.contains(friend.id))
        .where((friend) => friend.name.toLowerCase().contains(_query))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF8E45FE),
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(child: _FriendsBackground()),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _CircleButton(
                        icon: Icons.arrow_back_rounded,
                        onTap: () => Navigator.of(context).pop(_friendIds),
                      ),
                      const Spacer(),
                      _CircleButton(
                        icon: Icons.add_rounded,
                        backgroundColor: const Color(0xFFFFD83D),
                        iconColor: const Color(0xFF7F40F7),
                        onTap: _openAddFriends,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    strings.text('profileFriends'),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _SearchBar(
                    hintText: strings.text('friendsSearchHint'),
                    onChanged: (value) {
                      setState(() {
                        _query = value.trim().toLowerCase();
                      });
                    },
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: visibleFriends.isEmpty
                        ? Center(
                            child: Text(
                              strings.text('friendsNoResults'),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: visibleFriends.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final friend = visibleFriends[index];
                              return _FriendCard(
                                friend: friend,
                                pointsLabel: strings.text('friendsPoints'),
                                actionLabel: strings.text('friendsUnfriend'),
                                actionIcon: Icons.person_remove_alt_1_rounded,
                                actionColor: const Color(0x33FFFFFF),
                                actionTextColor: Colors.white,
                                onActionTap: () {
                                  setState(() {
                                    _friendIds.remove(friend.id);
                                  });
                                },
                              );
                            },
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

  Future<void> _openAddFriends() async {
    final updatedIds = await Navigator.of(context).push<Set<String>>(
      MaterialPageRoute<Set<String>>(
        builder: (_) => AddFriendsScreen(
          initialFriendIds: _friendIds,
        ),
      ),
    );

    if (updatedIds != null) {
      setState(() {
        _friendIds = updatedIds;
      });
    }
  }
}

class AddFriendsScreen extends StatefulWidget {
  const AddFriendsScreen({
    super.key,
    required this.initialFriendIds,
  });

  final Set<String> initialFriendIds;

  @override
  State<AddFriendsScreen> createState() => _AddFriendsScreenState();
}

class _AddFriendsScreenState extends State<AddFriendsScreen> {
  late Set<String> _friendIds;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _friendIds = {...widget.initialFriendIds};
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final visibleFriends = friendsCatalog
        .where((friend) => friend.name.toLowerCase().contains(_query))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF8E45FE),
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(child: _FriendsBackground()),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CircleButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => Navigator.of(context).pop(_friendIds),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    strings.text('friendsAddTitle'),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _SearchBar(
                    hintText: strings.text('friendsSearchHint'),
                    onChanged: (value) {
                      setState(() {
                        _query = value.trim().toLowerCase();
                      });
                    },
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: visibleFriends.isEmpty
                        ? Center(
                            child: Text(
                              strings.text('friendsNoResults'),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: visibleFriends.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final friend = visibleFriends[index];
                              final isAdded = _friendIds.contains(friend.id);
                              return _FriendCard(
                                friend: friend,
                                pointsLabel: strings.text('friendsPoints'),
                                actionLabel: isAdded
                                    ? strings.text('friendsAdded')
                                    : strings.text('friendsAdd'),
                                actionIcon: Icons.person_add_alt_1_rounded,
                                actionColor: isAdded
                                    ? const Color(0xFF85D6F7)
                                    : const Color(0xFF29C5F6),
                                actionTextColor: Colors.white,
                                onActionTap: () {
                                  setState(() {
                                    _friendIds.add(friend.id);
                                  });
                                },
                              );
                            },
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

class _FriendsBackground extends StatelessWidget {
  const _FriendsBackground();

  @override
  Widget build(BuildContext context) => Stack(
        children: const [
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
          _Glow(top: -54, right: -68, size: 220),
          _Glow(bottom: -40, left: -38, size: 150),
        ],
      );
}

class _Glow extends StatelessWidget {
  const _Glow({
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

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.iconColor,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.black.withValues(alpha: 0.14),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor ?? Colors.white,
          ),
        ),
      );
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.hintText,
    required this.onChanged,
  });

  final String hintText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) => Container(
        height: 46,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0x663E158A),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: TextField(
                    onChanged: onChanged,
                    style: const TextStyle(
                      color: Color(0xFF553090),
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(
                        color: Color(0xFF9D8EC1),
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.search_rounded,
                color: Color(0xFFB985FF),
                size: 24,
              ),
            ),
          ],
        ),
      );
}

class _FriendCard extends StatelessWidget {
  const _FriendCard({
    required this.friend,
    required this.pointsLabel,
    required this.actionLabel,
    required this.actionIcon,
    required this.actionColor,
    required this.actionTextColor,
    required this.onActionTap,
  });

  final FriendProfile friend;
  final String pointsLabel;
  final String actionLabel;
  final IconData actionIcon;
  final Color actionColor;
  final Color actionTextColor;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.14),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            _AvatarBubble(friend: friend),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friend.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    pointsLabel,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xD9FFFFFF),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            TextButton.icon(
              onPressed: onActionTap,
              style: TextButton.styleFrom(
                backgroundColor: actionColor,
                foregroundColor: actionTextColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              icon: Icon(actionIcon, size: 18),
              label: Text(
                actionLabel,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );
}

class _AvatarBubble extends StatelessWidget {
  const _AvatarBubble({
    required this.friend,
  });

  final FriendProfile friend;

  @override
  Widget build(BuildContext context) => Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: friend.avatarColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            friend.icon,
            color: const Color(0xFF6F36F4),
            size: 24,
          ),
        ),
      );
}
