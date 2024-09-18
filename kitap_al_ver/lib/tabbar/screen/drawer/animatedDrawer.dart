// ignore_for_file: file_names, use_super_parameters

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/aramabut/admin.dart';
import 'package:kitap_al_ver/aramabut/bildirim.dart';
import 'package:kitap_al_ver/tabbar/screen/drawer/books_home.dart';
import 'package:kitap_al_ver/aramabut/mySearc.dart';

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

    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
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
                          child: const Icon(Icons.arrow_back_ios),
                          onTap: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              isDrawerOpen = false;
                            });
                          },
                        )
                      : GestureDetector(
                          child: const Icon(Icons.menu),
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
                          const Text("konum A"),
                          IconButton(
                            icon: const Icon(Icons.add_location_outlined),
                            color: const Color.fromARGB(232, 131, 17, 17),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PhotoPickerScreen()));
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_alert_outlined),
                            color: const Color.fromARGB(232, 131, 17, 17),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Bildirim()));
                            },
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
