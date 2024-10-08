
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/utils/color.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;

  const MyButton({
    super.key,
    required this.buttonText,
    this.onTap,
  });
// Color.fromARGB(255, 247, 95, 95)
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? AppColor.buttondart
              : AppColor.buttonlight, //LİYAT
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 100.0,
          vertical: 20.0,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: theme.brightness == Brightness.dark
                ? AppColor.white
                : AppColor.yazilight,
            fontWeight: FontWeight.w900,
            fontSize: 18,
            shadows: const [
              BoxShadow(
                color: AppColor.shadow,
                blurRadius: 3,
                offset: Offset(0, 1), // Gölgelendirme yönü ve mesafesi
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//