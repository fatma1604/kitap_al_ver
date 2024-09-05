import 'package:flutter/material.dart';
import 'package:kitap_al_ver/pages/onbording/onbording_screen.dart';
import 'package:kitap_al_ver/widget/%C4%B1nformation.dart';

typedef AppRouteMapFunction = Widget Function(BuildContext context);

final class AppRoute {
  const AppRoute._();

  static const String onboard = "/onboard";
  static const String login = "/login";
  static const String home = "/home";
  static const String search = "/search";
  static const String favourite = "/favourite";
  static const String profile = "/profile";
  static const String curved = "/curved";
  static const String viewmore = "/viewmore";
  static const String course = "/course";
  static const String catalogCourse = "/catalogCourse";
  static const String profiledit = "/profiledit";
  static const String loginOrRegister = "/loginOrRegister";
  static const String calendar = "/calendar";
  static const String setting = "/setting";
  static const String forgot = "/forgot";
  static const String catalog = "/catalog";
  static const String register = "/register";
  static const String personall = "/personal";
  static const String note = "/note";
  static const String start = "/start";
  static const String announcement = "/announcement";
  static const String quizStart = "/quizStart";
  static const String admin = "/admin";
  static const String exam = "/exam";
  static const String tabbarhome = "/tababrhome";
  static const String information = "/tababrhome";

  static Map<String, AppRouteMapFunction> routes = {
    onboard: (context) => const OnboardingScreen(),
    information: (context) => InformationFormScreen(),

    // tabbarhome: (context) =>const BooksCategoryScreen(),
    /* login: (context) => LoginPage(),
    home: (context) => const HomePage(),
    onboard: (context) => OnboardingAnimation(),
    profile: (context) => const ProfilePage(),
    curved: (context) => const CurvedNavBarWidget(),
    viewmore: (context) => const ViewMorePage(),
    course: (context) => const CourseViewPage(),
    catalogCourse: (context) => const CatalogCourseViewPage(),
    profiledit: (context) => const ProfileEditPage(),
    calendar: (context) => const CalendarPage(),
    forgot: (context) => ForgotPasswordPage(),
    catalog: (context) => const CatalogPage(),
    register: (context) => RegisterPage(),
    note: (context) => const NotePage(),
    start: (context) => const StartPage(),
    announcement: (context) => const AnnouncementSurveyPage(),
    loginOrRegister: (context) => const LoginOrRegister(),
    quizStart: (context) => const QuizStartPage(),
    admin: (context) => const AdminPage(),
    exam: (context) => const ExamPage(),*/
  };
}
