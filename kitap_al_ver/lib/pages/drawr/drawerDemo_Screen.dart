import 'package:flutter/material.dart';
import 'package:kitap_al_ver/pages/drawr/animatedDrawer.dart';
import 'package:kitap_al_ver/pages/drawr/drawer_screen.dart';

import 'package:kitap_al_ver/utils/color.dart';

class DrawerDemoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColor.screendart : AppColor.screenlight,
      body: Stack(
        children: [
          DrawerScreen(),
          const AnimatedDrawer(),
        ],
      ),
    );
  }
}
