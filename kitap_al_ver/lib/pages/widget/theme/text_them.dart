import 'package:flutter/material.dart';
import 'package:kitap_al_ver/utils/color.dart';

class AppTextTheme {
  AppTextTheme._();
  static TextStyle login(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextStyle(
      fontSize: 18,
      color: theme.brightness == Brightness.dark
          ? AppColor.white
          : AppColor.yazilight,
      fontWeight: FontWeight.w900,
      shadows: const [
        BoxShadow(
          color: AppColor.shadow,
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
          ? AppColor.white
          : AppColor.yazilight,
      fontWeight: FontWeight.w900,
      shadows: const [
        BoxShadow(
          color: AppColor.shadow,
          blurRadius: 3,
          offset: Offset(0, 1), // Gölgelendirme yönü ve mesafesi
        ),
      ],
    );
  }


 static TextStyle comment(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextStyle(
     
      color: theme.brightness == Brightness.dark
          ? AppColor.yazidart
          : AppColor.yazilight,
      fontWeight: FontWeight.normal,
      
    );
  }
 static TextStyle description(BuildContext context) {
   
    return const TextStyle(
     
      color:Colors.black54,
      fontWeight: FontWeight.bold,
      fontSize: 16
      
    );
  }



  
}
