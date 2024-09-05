
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/configuration/costant/color.dart';



class Menubutton extends StatelessWidget {
  final String buttonText;
  final Widget targetScreen;
//
  const Menubutton({
    super.key,
    required this.buttonText,
    required this.targetScreen, // Added targetScreen parameter
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen), // Navigate to the target screen
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? AppColor.buttondart
              : AppColor.buttonlight,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          border: Border.all(
            color: theme.brightness == Brightness.dark
                ? Colors.white.withOpacity(0.5)
                : Colors.black.withOpacity(0.5),
            width: 2,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 15.0,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 10),
              Text(
                buttonText,
                style: TextStyle(
                  color: theme.brightness == Brightness.dark
                      ? Colors.white
                      : AppColor.yazilight,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  shadows: [
                    BoxShadow(
                      color: theme.brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.3)
                          : Colors.black.withOpacity(0.3),
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
