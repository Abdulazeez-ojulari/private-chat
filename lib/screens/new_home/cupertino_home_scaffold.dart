import './custom_bottom_bar.dart';
import './custom_cupertino_tab_scaffold.dart';
import 'package:flutter/cupertino.dart'
    hide CupertinoTabBar, CupertinoTabScaffold;
import 'package:flutter/material.dart';

import 'package:privatechat/utils/bottom_nav_item.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold({
    Key? key,
    required this.currentTab,
    required this.onSelectTab,
    required this.widgetBuilders,
    required this.navigatorKeys,
  }) : super(key: key);
  final BottomNavItem currentTab;
  final ValueChanged<BottomNavItem> onSelectTab;
  final Map<BottomNavItem, WidgetBuilder> widgetBuilders;
  final Map<BottomNavItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (context, index) {
        final item = BottomNavItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKeys[item],
          builder: (context) => widgetBuilders[item]!(context),
        );
      },
      tabBar: CupertinoTabBar(
        height: 70,
        backgroundColor: const Color(0xffffffff),
        activeColor: const Color(0xfffe9aab),
        items: [
          _buildItem(BottomNavItem.chatExplore),
          _buildItem(BottomNavItem.chatFriends),
          _buildItem(BottomNavItem.profile),
        ],
        onTap: (index) => onSelectTab(BottomNavItem.values[index]),
      ),
    );
  }

  BottomNavigationBarItem _buildItem(BottomNavItem tabItem) {
    final itemData = BottomNavItemData.allTabItems[tabItem];
    return BottomNavigationBarItem(
      icon: Icon(itemData!.icon),
    );
  }
}
