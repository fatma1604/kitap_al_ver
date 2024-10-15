// ignore_for_file: library_private_types_in_public_api, prefer_final_fields

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitap_al_ver/mainpage.dart';
import 'package:kitap_al_ver/pages/widget/core/onbordbutton.dart';
import 'package:kitap_al_ver/utils/color.dart';
import 'package:kitap_al_ver/pages/onbording/intopage.dart';
import 'package:kitap_al_ver/pages/auth/auth_Page.dart';
import 'package:kitap_al_ver/utils/images.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  List<bool> _buttonsVisible = [false, false, false];

  final List<Widget> pages = [
    const IntroPage(
      imagePath: AppImage.onbording1,
      lightGradient: LinearGradient(
        begin: Alignment.topCenter,
       colors: [AppColor.onbordinglight, AppColor.onboardingLightAccent],
      ),
      darkGradient: LinearGradient(
        begin: Alignment.topCenter,
       colors: [AppColor.onbordingdark, AppColor.onboardingDarkAccent],
      ),
    ),
    const IntroPage(
      imagePath: AppImage.onbording2,
      lightGradient: LinearGradient(
        begin: Alignment.topCenter,
      colors: [AppColor.onbordinglight, AppColor.onboardingLightAccent],
      ),
      darkGradient: LinearGradient(
        begin: Alignment.topCenter,
        colors: [AppColor.onbordingdark, AppColor.onboardingDarkAccent],
      ),
    ),
    const IntroPage(
      imagePath: AppImage.onbording3,
      lightGradient: LinearGradient(
        begin: Alignment.topCenter,
         colors: [AppColor.onbordinglight, AppColor.onboardingLightAccent],
      ),
      darkGradient: LinearGradient(
        begin: Alignment.topCenter,
         colors: [AppColor.onbordingdark, AppColor.onboardingDarkAccent],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _buttonsVisible.length; i++) {
      Future.delayed(Duration(seconds: 5 * (i + 1)), () {
        if (mounted) {
          setState(() {
            _buttonsVisible[i] = true;
          });
        }
      });
    }
  }

  void _handleBack() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  void _handleNext() {
    if (_currentPage < pages.length - 1) {
      setState(() {
        _currentPage++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      body: Stack(
        children: [
          pages[_currentPage],
          Positioned(
            bottom: 50.h,
            left: 0.w,
            right: 0.w,
            child: AnimatedOpacity(
              opacity: _buttonsVisible[_currentPage] ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OnButton(
                      onPressed: _handleBack,
                      primaryColor: AppColor.lightBg,
                      onPrimaryColor: Theme.of(context).cardColor,
                      elevation: 5.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 20.h),
                      text: 'Back',
                    ),
                    OnButton(
                      onPressed: _handleNext,
                      primaryColor: AppColor.lightBg,
                      onPrimaryColor: Theme.of(context).cardColor,
                      elevation: 5.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 20.h),
                      text: _currentPage == pages.length - 1 ? "Done" : "Next",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
