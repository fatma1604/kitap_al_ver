// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/utils/color.dart';

class AppTheme {
  AppTheme._();

  /* ------------- Light Theme ------------- */
  static ThemeData get lightMode {
    const ColorScheme colorScheme = ColorScheme.light(
      background: AppColor.lightBg,
      primary: AppColor.buttonlight,
      onPrimary: AppColor.yazilight,
      secondary: AppColor.screenlight,
      onSecondary: AppColor.fromlight,
      surface: AppColor.screenlight1,
      onSurface: AppColor.screendart1,
      error: AppColor.forget,
      onError: AppColor.forget2,
    );

    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColor.yazilight),
        bodyMedium: TextStyle(color: AppColor.screenlight),
        displayLarge: TextStyle(color: AppColor.yazilight, fontSize: 32),
        displayMedium: TextStyle(color: AppColor.yazilight, fontSize: 24),
        displaySmall: TextStyle(color: AppColor.yazilight, fontSize: 18),
        labelLarge: TextStyle(color: AppColor.yazilight),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.screenlight,
        foregroundColor: AppColor.yazilight,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.buttonlight,
          foregroundColor: AppColor.yazilight,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColor.yazilight,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColor.yazilight,
          side: const BorderSide(color: AppColor.buttonlight),
        ),
      ),
    );
  }

  /* ------------- Dark Theme ------------- */
  static ThemeData get darkMode {
    const ColorScheme colorScheme = ColorScheme.dark(
      background: AppColor.darttBg,
      primary: AppColor.buttondart,
      onPrimary: AppColor.yazidart,
      secondary: AppColor.screendart,
      onSecondary: Color.fromARGB(211, 235, 177, 174),
      surface: AppColor.screendart1,
      onSurface: AppColor.screenlight1,
      error: AppColor.forget,
      onError: AppColor.forget2,
    );

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
