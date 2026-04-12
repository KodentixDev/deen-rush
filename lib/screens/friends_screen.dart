import 'package:flutter/material.dart';

import '../components/friends/friends_screen_widgets.dart';
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
            const Positioned.fill(child: FriendsBackground()),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      FriendsCircleButton(
                        icon: Icons.arrow_back_rounded,
                        onTap: () => Navigator.of(context).pop(_friendIds),
                      ),
                      const Spacer(),
                      FriendsCircleButton(
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
                  FriendsSearchBar(
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
                            separatorBuilder: (_, _) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final friend = visibleFriends[index];
                              return FriendCard(
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
        builder: (_) => AddFriendsScreen(initialFriendIds: _friendIds),
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
            const Positioned.fill(child: FriendsBackground()),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FriendsCircleButton(
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
                  FriendsSearchBar(
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
                            separatorBuilder: (_, _) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final friend = visibleFriends[index];
                              final isAdded = _friendIds.contains(friend.id);
                              return FriendCard(
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
