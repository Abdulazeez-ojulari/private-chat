import 'package:flutter/material.dart';
import 'package:privatechat/screens/friends_chat.dart';
import 'package:privatechat/screens/home_page.dart';
import 'package:privatechat/screens/profile_page.dart';
import 'package:privatechat/utils/bottom_nav_item.dart';

import 'cupertino_home_scaffold.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  BottomNavItem _currentTab = BottomNavItem.chatExplore;

  void _select(BottomNavItem tabItem) {
    if (tabItem == _currentTab) {
      navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentTab = tabItem;
      });
    }
  }

  final Map<BottomNavItem, GlobalKey<NavigatorState>> navigatorKeys = {
    BottomNavItem.chatExplore: GlobalKey<NavigatorState>(),
    BottomNavItem.chatFriends: GlobalKey<NavigatorState>(),
    BottomNavItem.profile: GlobalKey<NavigatorState>(),
  };

  Map<BottomNavItem, WidgetBuilder> get widgetBuilders {
    return {
      BottomNavItem.chatExplore: (_) => const HomePage(),
      BottomNavItem.chatFriends: (_) => const FriendsChat(),
      BottomNavItem.profile: (_) => const ProfilePage()
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
      child: CupertinoHomeScaffold(
        navigatorKeys: navigatorKeys,
        currentTab: _currentTab,
        onSelectTab: _select,
        screenBuilders: widgetBuilders,
      ),
    );
  }
}
