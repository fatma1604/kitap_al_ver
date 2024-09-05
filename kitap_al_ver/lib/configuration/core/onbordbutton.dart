import 'package:flutter/material.dart';

class OnButton extends StatelessWidget {
  // ignore: use_super_parameters
  const OnButton({
    Key? key,
    required this.onPressed,
    required this.primaryColor,
    required this.onPrimaryColor,
    required this.elevation,
    required this.padding,
    required this.text,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Color primaryColor;
  final Color onPrimaryColor;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final String text;

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;

    Color buttonBackgroundColor;
    Color textColor;
    Color shadowColor;

    if (brightness == Brightness.dark) {
      // Dark mod için renkler
      buttonBackgroundColor = const Color.fromARGB(255, 49, 10, 7);
      textColor = Colors.white;
      shadowColor = Colors.white.withOpacity(0.5);
    } else {
      // Light mod için renkler
      buttonBackgroundColor = const Color.fromARGB(255, 247, 118, 108);
      textColor = const Color.fromARGB(237, 250, 249, 249);
      shadowColor = Colors.black.withOpacity(0.5);
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        padding: padding,
        backgroundColor: buttonBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(228, 241, 193, 190),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
