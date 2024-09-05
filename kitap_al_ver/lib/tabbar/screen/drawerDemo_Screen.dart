// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/tabbar/screen/drawer/animatedDrawer.dart';
import 'package:kitap_al_ver/tabbar/screen/drawer/drawer_screen.dart';


// ignore: use_key_in_widget_constructors
class DrawerDemoScreen extends StatelessWidget {  // İsim değiştirildi
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          const AnimatedDrawer(),
        ],
      ),
    );
  }
}
