import 'package:flutter/material.dart';
import 'package:kitap_al_ver/components/tabbar/liquidTabbar.dart';
import 'package:kitap_al_ver/pages/home/books_home.dart';
import 'package:kitap_al_ver/pages/onbording/onbording_screen.dart';


final class AppRoute {
  const AppRoute._();

  static const String onboard = "/onboard";
  static const String booksHome = "/booksHome";
  static const String liquidTab = "/liquidTab";

  static Map<String, WidgetBuilder> get routes => {
    onboard: (context) => const OnboardingScreen(),
    booksHome: (context) => const Books_Home(),
    liquidTab: (context) =>  LiquidTabBar(),
  };
}
