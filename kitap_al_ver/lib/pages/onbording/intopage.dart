import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitap_al_ver/configuration/costant/color.dart';

class IntroPage extends StatelessWidget {
  final String imagePath;
  final Gradient lightGradient;
  final Gradient darkGradient;

  // ignore: use_super_parameters
  const IntroPage({
    Key? key,
    required this.imagePath,
    required this.lightGradient,
    required this.darkGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: isDarkMode ? darkGradient : lightGradient,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? AppColor.darttBg : AppColor.lightBg,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(
                    300.w, // Use responsive sizing if needed
                    80.h, // Use responsive sizing if needed
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 290.h,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                gradient: Theme.of(context).brightness == Brightness.dark
                    ? darkGradient
                    : lightGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(
                    300.w,
                    80.h,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
