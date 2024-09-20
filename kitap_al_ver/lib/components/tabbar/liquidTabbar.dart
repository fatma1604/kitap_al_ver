// ignore_for_file: file_names, unused_import, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/pages/chat/chat_home.dart';

import 'package:kitap_al_ver/pages/widget/core/pageCon.dart';
import 'package:kitap_al_ver/utils/color.dart';
import 'package:kitap_al_ver/pages/widget/constat.dart';
import 'package:kitap_al_ver/pages/profile/favori/favorite.dart';
import 'package:kitap_al_ver/pages/home/bookcatagory.dart';
import 'package:kitap_al_ver/components/tabbar/bgcirclewidget.dart';
import 'package:kitap_al_ver/components/tabbar/bottomLiquidWidget.dart';
import 'package:kitap_al_ver/pages/profile/profil_screen.dart';
import 'package:kitap_al_ver/pages/drawr/drawerDemo_Screen.dart';
import 'package:kitap_al_ver/components/tabbar/tBiconData.dart';
import 'package:kitap_al_ver/components/tabbar/tbicon.dart';

// ignore: use_key_in_widget_constructors
class LiquidTabBar extends StatefulWidget {
  @override
  LiquidTabBarState createState() => LiquidTabBarState();
}

class LiquidTabBarState extends State<LiquidTabBar>
    with TickerProviderStateMixin {
  late PageController pageCon;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int currentColor = 0;
  int index = 0;
  int pageIndex = 0;

  void onPageChanged(int page) {
    setState(() {
      pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    pageCon.animateToPage(index,
        duration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  void initState() {
    pageCon = PageController(initialPage: pageIndex);

    tBWidthCon = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 250),
    );

    tBWidthAni = Tween<double>(begin: 1, end: .85).animate(CurvedAnimation(
        parent: tBWidthCon, curve: Curves.easeOut, reverseCurve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          tBWidthCon.reverse();
          tBHeightCon.forward();
        }
      });

    tBHeightCon = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 300),
    );

    tBHeightAni = Tween<double>(begin: 70, end: 85).animate(CurvedAnimation(
        parent: tBHeightCon, curve: Curves.easeOut, reverseCurve: Curves.ease))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          tBHeightCon.reverse();
        }
      });

    tBColorOpacCon = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      reverseDuration: const Duration(milliseconds: 350),
    );

    tBColorOpacAni = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: tBColorOpacCon,
            curve: Curves.easeOut,
            reverseCurve: Curves.ease))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          tBColorOpacCon.reverse();
        }
      });

    transCon = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    transAni = Tween<double>(begin: 0.0, end: -85.0)
        .animate(CurvedAnimation(parent: transCon, curve: Curves.easeOutCubic))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          oneToZeroCon.forward();
        }
      });

    bGCircleTransAni = Tween<double>(begin: 5.0, end: -75.0)
        .animate(CurvedAnimation(parent: transCon, curve: Curves.easeOutCubic))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          oneToZeroCon.forward();
        }
      });

    triggerableCon = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 300),
    );

    triggerableAni = Tween<double>(begin: 50.0, end: 0.0).animate(
        CurvedAnimation(
            parent: triggerableCon,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeInCubic))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          triggerableCon.reverse();
        }
      });

    oneToZeroCon = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    oneToZeroAnim = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
      parent: oneToZeroCon,
      curve: Curves.easeIn,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          transCon.reset();
          oneToZeroCon.reverse();
        }
      });

    bottomLiquidCon = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 250),
        reverseDuration: const Duration(milliseconds: 300));

    bottomLiquidAni1 = Tween<double>(begin: .5, end: 1)
        .animate(CurvedAnimation(parent: bottomLiquidCon, curve: Curves.ease))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          bottomLiquidCon.reverse();
        }
      });

    bottomLiquidAni2 = Tween<double>(begin: .4, end: .2).animate(
      CurvedAnimation(
        parent: bottomLiquidCon,
        curve: Curves.ease,
      ),
    );

    bottomLiquidAni3 = Tween<double>(begin: .5, end: .8).animate(
      CurvedAnimation(
        parent: bottomLiquidCon,
        curve: Curves.ease,
      ),
    );

    bottomLiquidAni4 = Tween<double>(begin: .6, end: .8).animate(
      CurvedAnimation(
        parent: bottomLiquidCon,
        curve: Curves.ease,
      ),
    );

    bottomLiquidAni5 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: bottomLiquidCon,
        curve: Curves.easeInQuad,
        reverseCurve: Curves.easeOutExpo,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    pageCon.dispose();
    tBWidthCon.dispose();
    tBHeightCon.dispose();
    tBColorOpacCon.dispose();
    transCon.dispose();
    triggerableCon.dispose();
    oneToZeroCon.dispose();
    bottomLiquidCon.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<Widget> screens = [
      DrawerDemoScreen(),
      ChatHome(),
      BookCategoryOverview(),
      const Favorite(),
      ProfilScreen(
        userId: _auth.currentUser!.uid,
      ),
    ];
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            // ignore: sort_child_properties_last
            children: screens,
            onPageChanged: onPageChanged,
            controller: pageCon,
          ),
          IgnorePointer(
            ignoring: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: screenWidth * tBWidthAni.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      5,
                      (index) => BottomLiquidWidget(
                        currentIndex: index,
                        index: this.index,
                        bottomLiquidAni5Value: bottomLiquidAni5.value,
                        color: listOfColors[currentColor],
                        colorOpacity: tBColorOpacAni.value,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: tBHeightAni.value - 1,
                ),
              ],
            ),
          ),
          IgnorePointer(
            ignoring: true,
            child: SizedBox(
              width: screenWidth * tBWidthAni.value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  5,
                  (index) => BGCircleWidget(
                    currentIndex: index, // Define `currentIndex` as needed
                    index: this.index,
                    bGCircleTransAni: bGCircleTransAni,
                    oneToZeroAnim: oneToZeroAnim,
                    color: listOfColors[
                        currentColor], // Define `currentColor` as needed
                    colorOpacity: tBColorOpacAni.value,
                    bottomLiquidAni1: bottomLiquidAni1,
                    bottomLiquidAni2: bottomLiquidAni2,
                    bottomLiquidAni3: bottomLiquidAni3,
                    bottomLiquidAni4: bottomLiquidAni4,
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColor.liqudart
                  : AppColor.liquliht, // Light mode color
              borderRadius: BorderRadius.vertical(),
            ),
            child: Container(
              height: tBHeightAni.value,
              width: screenWidth * tBWidthAni.value,
              decoration: BoxDecoration(
                color: listOfColors[currentColor].withOpacity(
                  tBColorOpacAni.value,
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  5,
                  (index) => TBIcon(
                    currentIndex:
                        index, // Provide the appropriate value for currentIndex
                    index: index,
                    transAni: transAni,
                    oneToZeroAnim: oneToZeroAnim,
                    listOfFilledIcons: listOfFilledIcons,
                    listOfIcons: listOfIcons,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: screenWidth * tBWidthAni.value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  tBTrigger(0),
                  tBTrigger(1),
                  tBTrigger(2),
                  tBTrigger(3),
                  tBTrigger(4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tBTrigger(int currentIndex) {
    return InkWell(
      onTap: () {
        onTabTapped(currentIndex);
        currentColor = currentIndex;
        index = currentIndex;
        tBWidthCon.forward();
        tBColorOpacCon.forward();
        transCon.reset();
        transCon.forward();
        triggerableCon.forward();
        bottomLiquidCon.forward();
      },
      child: Container(
        alignment: Alignment.center,
        height: tBHeightAni.value,
        width: index == currentIndex ? triggerableAni.value : 50,
        child: index == currentIndex
            ? const SizedBox()
            : TBIconData(
                icon: listOfIcons[currentIndex],
                size: 1,
                opacity: 1,
              ),
      ),
    );
  }
}
