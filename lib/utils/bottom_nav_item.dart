import 'package:flutter/material.dart';

enum BottomNavItem { chatExplore, chatFriends, profile }

class BottomNavItemData {
  const BottomNavItemData({required this.icon});
  final IconData icon;

  static const Map<BottomNavItem, BottomNavItemData> allTabItems = {
    BottomNavItem.chatExplore: BottomNavItemData(
      icon: Icons.search_rounded,
    ),
    BottomNavItem.chatFriends: BottomNavItemData(
      icon: Icons.chat_outlined,
    ),
    BottomNavItem.profile: BottomNavItemData(
      icon: Icons.person_outline_rounded,
    ),
  };

 
}
