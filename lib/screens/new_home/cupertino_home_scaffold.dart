import './custom_bottom_bar.dart';
import './custom_cupertino_tab_scaffold.dart';
import 'package:flutter/cupertino.dart'
    hide CupertinoTabBar, CupertinoTabScaffold;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:privatechat/controllers/themeNotifier.dart';
import 'package:privatechat/utils/bottom_nav_item.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold({
    Key? key,
    required this.currentTab,
    required this.onSelectTab,
    required this.screenBuilders,
    required this.navigatorKeys,
  }) : super(key: key);
  final BottomNavItem currentTab;
  final ValueChanged<BottomNavItem> onSelectTab;
  final Map<BottomNavItem, WidgetBuilder> screenBuilders;
  final Map<BottomNavItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context).darkTheme;
    return CupertinoTabScaffold(
      // restorationId: 'root',
      backgroundColor: theme ? Colors.white : const Color(0xff201f24),
      tabBuilder: (context, index) {
        final item = BottomNavItem.values[index];
        return CupertinoTabView(
          restorationScopeId: 'root',
          navigatorKey: navigatorKeys[item],
          builder: (context) => screenBuilders[item]!(context),
        );
      },
      tabBar: CupertinoTabBar(
        inactiveColor: theme
            ? Colors.white
            : const Color(0xff707070),
        shadowColor: theme
            ? const Color(0xff000000)
            : const Color(0x45000000),
        height: 70,
        backgroundColor: theme ? const Color(0xff201f24) : Colors.white,
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
