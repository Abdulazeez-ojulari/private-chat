import 'dart:ui' show ImageFilter;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Standard iOS 10 tab bar height.
const double _kTabBarHeight = 50.0;

const Color _kDefaultTabBarBorderColor = CupertinoDynamicColor.withBrightness(
  color: Color(0x4C000000),
  darkColor: Color(0x29000000),
);
const Color _kDefaultTabBarInactiveColor = CupertinoColors.inactiveGray;

class CupertinoTabBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a tab bar in the iOS style.
  const CupertinoTabBar({
    Key? key,
    required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.backgroundColor,
    this.activeColor,
    required this.inactiveColor,
    this.iconSize = 30.0,
    this.height = _kTabBarHeight,
    this.border = const Border(
      top: BorderSide(
        color: _kDefaultTabBarBorderColor,
        width: 0.0, // 0.0 means one physical pixel
      ),
    ), required this.shadowColor,
  })  : assert(items != null),
        assert(
          items.length >= 2,
        ),
        assert(currentIndex != null),
        assert(0 <= currentIndex && currentIndex < items.length),
        assert(iconSize != null),
        assert(height != null && height >= 0.0),
        assert(inactiveColor != null),
        super(key: key);

  final List<BottomNavigationBarItem> items;

  final ValueChanged<int>? onTap;

  final int currentIndex;

  final Color? backgroundColor;

  final Color? activeColor;

  final Color shadowColor;

  final Color? inactiveColor;

  final double iconSize;

  final double height;

  final Border? border;

  @override
  Size get preferredSize => Size.fromHeight(height);

  /// Indicates whether the tab bar is fully opaque or can have contents behind
  /// it show through it.
  bool opaque(BuildContext context) {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    final Color backgroundColor = CupertinoDynamicColor.resolve(
      this.backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor,
      context,
    );

    final Color inactive =
        CupertinoDynamicColor.resolve(inactiveColor!, context);
    Widget result = Container(
      decoration: BoxDecoration(
        //border: resolvedBorder,
        boxShadow:  [
          BoxShadow(
              color: shadowColor,
              offset: Offset(0, 4),
              blurRadius: 20,
              spreadRadius: 3)
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: backgroundColor,
      ),
      height: height + bottomPadding,
      child: IconTheme.merge(
        // Default with the inactive state.
        data: IconThemeData(color: inactive, size: iconSize),
        child: DefaultTextStyle(
          // Default with the inactive state.
          style: CupertinoTheme.of(context)
              .textTheme
              .tabLabelTextStyle
              .copyWith(color: inactive),
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: Semantics(
                explicitChildNodes: true,
                child: Row(
                  // Align bottom since we want the labels to be aligned.
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: _buildTabItems(context),
                )),
          ),
        ),
      ),
    );

    // if (opaque(context)) {
    //   // For non-opaque backgrounds, apply a blur effect.
    //   result = ClipRect(
    //     child: BackdropFilter(
    //       filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
    //       child: result,
    //     ),
    //   );
    // }

    return result;
  }

  List<Widget> _buildTabItems(BuildContext context) {
    final List<Widget> result = <Widget>[];
    final CupertinoLocalizations localizations =
        CupertinoLocalizations.of(context);

    for (int index = 0; index < items.length; index += 1) {
      final bool active = index == currentIndex;
      result.add(
        _wrapActiveItem(
          context,
          Expanded(
            child: Semantics(
              selected: active,
              hint: localizations.tabSemanticsLabel(
                tabIndex: index + 1,
                tabCount: items.length,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap == null
                    ? null
                    : () {
                        onTap!(index);
                      },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _buildSingleTabItem(items[index], active),
                  ),
                ),
              ),
            ),
          ),
          active: active,
        ),
      );
    }

    return result;
  }

  List<Widget> _buildSingleTabItem(BottomNavigationBarItem item, bool active) {
    return <Widget>[
      Expanded(
        child: Center(child: active ? item.activeIcon : item.icon),
      ),
      if (item.label != null) Text(item.label!),
    ];
  }

  /// Change the active tab item's icon and title colors to active.
  Widget _wrapActiveItem(BuildContext context, Widget item,
      {required bool active}) {
    if (!active) return item;

    final Color activeColor = CupertinoDynamicColor.resolve(
      this.activeColor ?? CupertinoTheme.of(context).primaryColor,
      context,
    );
    return IconTheme.merge(
      data: IconThemeData(color: activeColor),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: activeColor),
        child: item,
      ),
    );
  }

  /// Create a clone of the current [CupertinoTabBar] but with provided
  /// parameters overridden.
  CupertinoTabBar copyWith({
    Key? key,
    List<BottomNavigationBarItem>? items,
    Color? backgroundColor,
    Color? activeColor,
    Color? inactiveColor,
    double? iconSize,
    double? height,
    Border? border,
    int? currentIndex,
    ValueChanged<int>? onTap,
  }) {
    return CupertinoTabBar(
      key: key ?? this.key,
      items: items ?? this.items,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      iconSize: iconSize ?? this.iconSize,
      height: height ?? this.height,
      border: border ?? this.border,
      currentIndex: currentIndex ?? this.currentIndex,
      onTap: onTap ?? this.onTap,
      shadowColor: shadowColor,
    );
  }
}
