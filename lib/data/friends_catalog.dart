import 'package:flutter/material.dart';

class FriendProfile {
  const FriendProfile({
    required this.id,
    required this.name,
    required this.icon,
    required this.avatarColor,
  });

  final String id;
  final String name;
  final IconData icon;
  final Color avatarColor;
}

const friendsCatalog = [
  FriendProfile(
    id: 'mr_dat',
    name: 'Mr.Dat',
    icon: Icons.face_3_rounded,
    avatarColor: Color(0xFFE1F0FF),
  ),
  FriendProfile(
    id: 'soham',
    name: 'Soham',
    icon: Icons.face_rounded,
    avatarColor: Color(0xFFFFE4D8),
  ),
  FriendProfile(
    id: 'darlene',
    name: 'Darlene',
    icon: Icons.face_6_rounded,
    avatarColor: Color(0xFFFFE7F4),
  ),
  FriendProfile(
    id: 'gladys',
    name: 'Gladys',
    icon: Icons.face_4_rounded,
    avatarColor: Color(0xFFE1F6FF),
  ),
  FriendProfile(
    id: 'debra',
    name: 'Debra',
    icon: Icons.face_5_rounded,
    avatarColor: Color(0xFFFFE9D9),
  ),
  FriendProfile(
    id: 'shane',
    name: 'Shane',
    icon: Icons.face_3_rounded,
    avatarColor: Color(0xFFFFEDE1),
  ),
  FriendProfile(
    id: 'victoria',
    name: 'Victoria',
    icon: Icons.face_2_rounded,
    avatarColor: Color(0xFFE8E6FF),
  ),
  FriendProfile(
    id: 'aubrey',
    name: 'Aubrey',
    icon: Icons.face_rounded,
    avatarColor: Color(0xFFFFE4E1),
  ),
];
