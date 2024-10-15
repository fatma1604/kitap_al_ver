import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitap_al_ver/utils/color.dart';

class AppTextTheme {
  AppTextTheme._();
  static TextStyle heading(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    return TextStyle(
      fontSize: 18,
      color: theme.brightness == Brightness.dark
          ? AppColor.white
          : AppColor.textLiht,
      fontWeight: FontWeight.w900,
      shadows: const [
        BoxShadow(
          color: AppColor.shadow,
          blurRadius: 3,
          offset: Offset(0, 1), 
        ),
      ],
    );
  }

  static TextStyle subheading(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    return TextStyle(
        color: theme.brightness == Brightness.dark
            ? AppColor.textDark
            : AppColor.textLiht,
        fontWeight: FontWeight.normal,
        fontSize: 18.sp);
  }

  static TextStyle body(BuildContext context) {


    return TextStyle(
        color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 16.sp);
  }

  static TextStyle caption(BuildContext context) {


    return TextStyle(
        color: AppColor.textDark, fontWeight: FontWeight.bold, fontSize: 16.sp);
  }

  static TextStyle emphasized(BuildContext context) {
  

    return TextStyle(
        color: AppColor.black, fontWeight: FontWeight.bold, fontSize: 16.sp);
  }

  static TextStyle largeTitle(BuildContext context) {


    return TextStyle(
        color: AppColor.black, fontWeight: FontWeight.w800, fontSize: 25.sp);
  }

  static TextStyle users(BuildContext context) {
  

    return TextStyle(
        color: AppColor.black, fontWeight: FontWeight.w800, fontSize: 18.sp);
  }

  static TextStyle username(BuildContext context) {
    return TextStyle(
        color: AppColor.black, fontWeight: FontWeight.normal, fontSize: 18.sp);
  }
}
