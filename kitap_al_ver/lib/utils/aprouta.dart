import 'package:flutter/material.dart';
import 'package:kitap_al_ver/components/tabbar/liquidTabbar.dart';
import 'package:kitap_al_ver/pages/home/books_home.dart';
import 'package:kitap_al_ver/pages/onbording/onbording_screen.dart';

typedef AppRouteMapFunction = Widget Function(BuildContext context);

final class AppRoute {
  const AppRoute._();

  static const String onboard = "/onboard";
  static const String bookshome = "/bookshome";
  static const String liquattab = "/liquattab";

  static Map<String, AppRouteMapFunction> routes = {
    onboard: (context) => const OnboardingScreen(),
    bookshome: (context) => const Books_Home(),
    liquattab: (context) =>  LiquidTabBar(),
  };
}
