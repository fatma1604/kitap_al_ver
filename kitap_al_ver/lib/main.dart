// ignore_for_file: use_super_parameters

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitap_al_ver/configuration/costant/aprouta.dart';
import 'package:kitap_al_ver/configuration/costant/theme/theme.dart';
import 'package:kitap_al_ver/firebase_options.dart';
import 'package:kitap_al_ver/pages/onbording/onbording_screen.dart';


//istedim gibi çalışan 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
  
 
 const MyApp(),
    
  );
}

class MyApp extends StatelessWidget {
  final bool? onboardingCompleted;

  const MyApp({Key? key, this.onboardingCompleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 732),
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const OnboardingScreen(),
        theme: AppTheme.lightMode,
        darkTheme: AppTheme.darkMode,
        themeMode: ThemeMode.system,
        initialRoute:
            onboardingCompleted ?? false ? AppRoute.start : AppRoute.onboard,
        routes: AppRoute.routes,
      ),
    );
  }
}
