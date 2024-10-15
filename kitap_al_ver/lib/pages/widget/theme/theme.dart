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
        bodyLarge: TextStyle(color: AppColor.textDark),
        bodyMedium: TextStyle(color: AppColor.screendart),
        displayLarge: TextStyle(color: AppColor.textDark, fontSize: 32),
        displayMedium: TextStyle(color: AppColor.textDark, fontSize: 24),
        displaySmall: TextStyle(color: AppColor.textDark, fontSize: 18),
        labelLarge: TextStyle(color: AppColor.textDark),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.screendart,
        foregroundColor: AppColor.textDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.buttondart,
          foregroundColor: AppColor.textDark,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColor.textDark,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColor.textDark,
          side: const BorderSide(color: AppColor.buttondart),
        ),
      ),
    );
  }
}


