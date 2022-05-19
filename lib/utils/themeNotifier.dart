import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


ThemeData light = ThemeData(
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
  ),
  scaffoldBackgroundColor: Color(0xfff1f1f1),
  textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.black),
);

ThemeData dark = ThemeData(
  scaffoldBackgroundColor: Color(0xff201F24),
  backgroundColor: Color(0xff201F24),
  brightness: Brightness.dark,
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.white),
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";

  bool darkTheme = false;
  bool status1 = false;
  bool status2 = false;
  bool status3 = false;
  bool status4 = false;
  bool status5 = false;

  //Getter

  themeNotifier() {
    darkTheme = true;
  }

  updateStatus2(val) {
    status2 = val;
    notifyListeners();
  }

  toggleTheme(val) {
    darkTheme = !darkTheme;
    updateStatus2(val);
    notifyListeners();
  }
}
