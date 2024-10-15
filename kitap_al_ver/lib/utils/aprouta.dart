import 'package:flutter/material.dart';
import 'package:kitap_al_ver/components/tabbar/liquidTabbar.dart';
import 'package:kitap_al_ver/pages/auth/forget_page.dart';
import 'package:kitap_al_ver/pages/home/bookcatagory.dart';
import 'package:kitap_al_ver/pages/home/books_home.dart';
import 'package:kitap_al_ver/pages/misc/explone.dart';
import 'package:kitap_al_ver/pages/onbording/onbording_screen.dart';
import 'package:kitap_al_ver/pages/product/cartPage.dart';


final class AppRoute {
  const AppRoute._();

  static const String onboard = "/onboard";
  static const String booksHome = "/booksHome";
  static const String liquidTab = "/liquidTab";
  static const String card = "/card";
  static const String forget = "/forget";
  static const String explone = "/explone";
   static const String bookscateg = "/bookscateg";


  static Map<String, WidgetBuilder> get routes => {
    onboard: (context) => const OnboardingScreen(),
    booksHome: (context) => const Books_Home(),
    liquidTab: (context) =>  LiquidTabBar(),
    card: (context) => const CartPage(),
    forget: (context) => const ForgetPage(),
     explone: (context) => const Explone(),
      bookscateg: (context) =>  BookCategoryOverview()

  };
}
