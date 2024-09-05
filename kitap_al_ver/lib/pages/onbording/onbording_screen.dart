// ignore_for_file: library_private_types_in_public_api

import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitap_al_ver/configuration/core/onbordbutton.dart';
import 'package:kitap_al_ver/configuration/costant/color.dart';
import 'package:kitap_al_ver/configuration/costant/images.dart';
import 'package:kitap_al_ver/pages/onbording/intopage.dart';
import 'package:kitap_al_ver/pages/widget/loginorregister/auth.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  // ignore: prefer_final_fields
  List<bool> _buttonsVisible = [false, false, false];

  final List<Widget> pages = [
    const IntroPage(
      imagePath: AppImage.onbording1,
      lightGradient: LinearGradient(
        begin: Alignment.topCenter,
        colors: [
          AppColor.onbordinglight,
          AppColor.onbordinglight1,
        ],
      ),
      darkGradient: LinearGradient(
        begin: Alignment.centerRight,
        colors: [
          AppColor.onbordingdark,
          AppColor.onbordingdark1,
        ],
      ),
    ),
    const IntroPage(
      imagePath: AppImage.onbording2,
      lightGradient: LinearGradient(
        begin: Alignment.topCenter,
        colors: [
          AppColor.onbordinglight,
          AppColor.onbordinglight1,
        ],
      ),
      darkGradient: LinearGradient(
        begin: Alignment.topCenter,
        colors: [
          AppColor.onbordingdark,
          AppColor.onbordingdark1,
        ],
      ),
    ),
    const IntroPage(
      imagePath: AppImage.onbording3,
      lightGradient: LinearGradient(
        begin: Alignment.topCenter,
        colors: [
          AppColor.onbordinglight,
          AppColor.onbordinglight1,
        ],
      ),
      darkGradient: LinearGradient(
        begin: Alignment.topCenter,
        colors: [
          AppColor.onbordingdark,
          AppColor.onbordingdark1,
        ],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _buttonsVisible.length; i++) {
      Timer(Duration(seconds: 5 * (i + 1)), () {
        if (mounted) {
          setState(() {
            _buttonsVisible[i] = true;
          });
        }
      });
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
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OnButton(
                      onPressed: () {
                        if (_currentPage > 0) {
                          setState(() {
                            _currentPage--;
                          });
                        }
                      },
                      primaryColor: AppColor.lightBg,
                      onPrimaryColor: Theme.of(context).cardColor,
                      elevation: 5.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 20.h),
                      text: 'Back',
                    ),
                    OnButton(
                      onPressed: () {
                        if (_currentPage < pages.length - 1) {
                          setState(() {
                            _currentPage++;
                          });
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AuthPage(
                                      isLogin: true,
                                    )),
                          );
                        }
                      },
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
