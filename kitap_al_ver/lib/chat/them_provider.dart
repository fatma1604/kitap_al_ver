
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/chat/dark_mode.dart';
import 'package:kitap_al_ver/chat/light_mode.dart';


class ThemProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;
  ThemeData get themData => _themeData;

  bool get isDarkMode => _themeData == darkmode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkmode;
    } else {
      themeData = lightMode;
    }
    notifyListeners(); // Tema değiştiğinde dinleyicilere bildirilmesi için notifyListeners() çağrılır.
  }
}