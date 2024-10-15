
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/pages/widget/theme/text_them.dart';
import 'package:kitap_al_ver/utils/color.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;

  const MyButton({
    super.key,
    required this.buttonText,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? AppColor.buttondart
              : AppColor.buttonlight, 
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 100.0,
          vertical: 20.0,
        ),
        child: Text(
          buttonText,
          style: AppTextTheme.heading(context),
        ),
      ),
    );
  }
}

