import './custom_bottom_bar.dart';
import './custom_cupertino_tab_scaffold.dart';
import 'package:flutter/cupertino.dart'
    hide CupertinoTabBar, CupertinoTabScaffold;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:privatechat/utils/themeNotifier.dart';
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
    return CupertinoTabScaffold(
      // restorationId: 'root',
      backgroundColor: Colors.white,
      tabBuilder: (context, index) {
        final item = BottomNavItem.values[index];
        return CupertinoTabView(
          restorationScopeId: 'root',
          navigatorKey: navigatorKeys[item],
          builder: (context) => screenBuilders[item]!(context),
        );
      },
      tabBar: CupertinoTabBar(
        inactiveColor: Provider.of<ThemeNotifier>(context).darkTheme
            ? Colors.white
            : const Color(0xff707070),
        shadowColor: Provider.of<ThemeNotifier>(context).darkTheme
            ? const Color(0xff000000)
            : const Color(0x45000000),
        height: 70,
        backgroundColor: Provider.of<ThemeNotifier>(context).darkTheme
            ? const Color(0xff201f24)
            : const Color(0xffffffff),
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
