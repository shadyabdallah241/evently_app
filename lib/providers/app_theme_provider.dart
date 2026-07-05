import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  String getThemeName() {
    if (appTheme == ThemeMode.dark) {
      return "dark";
    }
    return "light";
  }

  bool isDark(BuildContext context) {
    if (appTheme == ThemeMode.dark) {
      return true;
    }
    return false;
  }

  void changeTheme(ThemeMode newTheme) {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    notifyListeners();
  }
}
