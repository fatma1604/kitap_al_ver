import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();
  static TextStyle login(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextStyle(
      fontSize: 18,
      color: theme.brightness == Brightness.dark
          ? const Color.fromARGB(244, 255, 255, 255)
          : const Color.fromARGB(244, 148, 80, 108),
      fontWeight: FontWeight.w900,
      shadows: const [
        BoxShadow(
          color: Color.fromARGB(122, 185, 105, 138),
          blurRadius: 3,
          offset: Offset(0, 1), // Gölgelendirme yönü ve mesafesi
        ),
      ],
    );
  }

  static TextStyle register(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextStyle(
      fontSize: 18,
      color: theme.brightness == Brightness.dark
          ? const Color.fromARGB(244, 255, 255, 255)
          : const Color.fromARGB(244, 148, 80, 108),
      fontWeight: FontWeight.w900,
      shadows: const [
        BoxShadow(
          color: Color.fromARGB(122, 185, 105, 138),
          blurRadius: 3,
          offset: Offset(0, 1), // Gölgelendirme yönü ve mesafesi
        ),
      ],
    );
  }

  static TextStyle myTabbarr(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color textColor = theme.brightness == Brightness.dark
        ? Colors.white
        : const Color.fromARGB(255, 147, 188, 207);

    return TextStyle(
      fontSize: 15,
      color: textColor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle myDrwer(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color textColor = theme.brightness == Brightness.dark
        ? const Color.fromARGB(255, 87, 85, 85)
        : const Color.fromARGB(255, 235, 243, 247);

    return TextStyle(
      fontSize: 15,
      color: textColor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle menu(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color textColor = theme.brightness == Brightness.dark
        ? const Color.fromARGB(255, 87, 85, 85)
        : const Color.fromARGB(255, 235, 243, 247);

    return TextStyle(
      fontSize: 22,
      color: textColor,
      fontWeight: FontWeight.bold,
    );
  }

  
}
