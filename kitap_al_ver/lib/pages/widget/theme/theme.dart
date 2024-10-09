import 'package:flutter/material.dart';
import 'package:kitap_al_ver/utils/color.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightMode {
    const ColorScheme colorScheme = ColorScheme.light();

    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: const TextTheme(),
      appBarTheme: const AppBarTheme(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColor.buttonlight),
        ),
      ),
    );
  }

  static ThemeData get darkMode {
    const ColorScheme colorScheme = ColorScheme.dark();

    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColor.yazidart),
        bodyMedium: TextStyle(color: AppColor.screendart),
        displayLarge: TextStyle(color: AppColor.yazidart, fontSize: 32),
        displayMedium: TextStyle(color: AppColor.yazidart, fontSize: 24),
        displaySmall: TextStyle(color: AppColor.yazidart, fontSize: 18),
        labelLarge: TextStyle(color: AppColor.yazidart),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.screendart,
        foregroundColor: AppColor.yazidart,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.buttondart,
          foregroundColor: AppColor.yazidart,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColor.yazidart,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColor.yazidart,
          side: const BorderSide(color: AppColor.buttondart),
        ),
      ),
    );
  }
}

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? AppTheme.darkMode : AppTheme.lightMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
