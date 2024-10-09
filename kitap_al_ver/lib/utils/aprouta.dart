import 'package:flutter/material.dart';
import 'package:kitap_al_ver/components/tabbar/liquidTabbar.dart';
import 'package:kitap_al_ver/pages/chat/chat_page.dart';
import 'package:kitap_al_ver/pages/home/books_home.dart';
import 'package:kitap_al_ver/pages/misc/explone.dart';
import 'package:kitap_al_ver/pages/onbording/onbording_screen.dart';

typedef AppRouteMapFunction = Widget Function(BuildContext context,
    {Map<String, dynamic>? userData});

final class AppRoute {
  const AppRoute._();

  static const String onboard = "/onboard";
  static const String booksHome = "/booksHome";
  static const String liquidTab = "/liquidTab";
  static const String chat = "/chatPage";
  static const String explone = "/explone ";

  static Map<String, AppRouteMapFunction> routes = {
    onboard: (context, {userData}) => const OnboardingScreen(),
    booksHome: (context, {userData}) => const Books_Home(),
    liquidTab: (context, {userData}) => LiquidTabBar(),
    chat: (context, {userData}) {
      final onboard = OnboardingScreen();
      // userData'nın null olup olmadığını kontrol et
      final email = userData?["email"] ??
          "default@example.com"; // Varsayılan değer ekleyebilirsin
      final uid =
          userData?["uid"] ?? "default_uid"; // Varsayılan değer ekleyebilirsin
      return ChatPage(
        receiverEmail: email,
        receiverId: uid,
      );
    },
    explone: (context, {userData}) => Explone(),
  };
}
