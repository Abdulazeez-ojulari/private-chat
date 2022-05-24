import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:privatechat/utils/dark_theme_preference.dart';

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = true;
  bool status1 = false;
  bool status2 = false;
  bool status3 = false;
  bool status4 = false;
  bool status5 = false;

  //Getter

  // themeNotifier() {
  //   darkTheme = true;
  // }

  updateStatus2(val) {
    status2 = val;
    notifyListeners();
  }

  bool get darkTheme => _darkTheme;

  set darkTheme(val) {
    _darkTheme = val;

    updateStatus2(val);
    darkThemePreference.setDarkTheme(val);
    darkThemePreference.setButtonStatus(val);

    notifyListeners();
  }
}
