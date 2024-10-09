import 'package:flutter/material.dart';
import 'package:kitap_al_ver/components/admin_buton/categoriAdmin.dart';
import 'package:kitap_al_ver/pages/home/books_home.dart';
import 'package:kitap_al_ver/pages/search/mySearc.dart';
import 'package:kitap_al_ver/utils/color.dart';

class AnimatedDrawer extends StatefulWidget {
  const AnimatedDrawer({Key? key}) : super(key: key);

  @override
  State<AnimatedDrawer> createState() => _DrawerfState();
}

class _DrawerfState extends State<AnimatedDrawer> {
  final TextEditingController searchController = TextEditingController();
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double mHeight = mediaQueryData.size.height;
    final double mWidth = mediaQueryData.size.width;

    // Get current theme data
    final theme = Theme.of(context);
    final backgroundColor = theme.brightness == Brightness.dark
        ? AppColor.screendart
        : AppColor.screenlight; // Background color for light mode
    final iconColor = theme.brightness == Brightness.dark
        ? Colors.white
        : Colors.white; // Icon color

    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius:
            isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
      ),
      child: SizedBox(
        width: mWidth,
        height: mHeight,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  isDrawerOpen
                      ? GestureDetector(
                          child: Icon(Icons.arrow_back_ios,
                              color: iconColor), // Icon color
                          onTap: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              isDrawerOpen = false;
                            });
                          },
                        )
                      : GestureDetector(
                          child:
                              Icon(Icons.menu, color: iconColor), // Icon color
                          onTap: () {
                            setState(() {
                              xOffset = 290;
                              yOffset = 80;
                              isDrawerOpen = true;
                            });
                          },
                        ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: MySearchWidget(
                                searchController: searchController),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_location_outlined),
                            color: AppColor.icon,
                            onPressed: () {
                             
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_alert_outlined),
                            color: AppColor.icon,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Expanded(
              child: Books_Home(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
