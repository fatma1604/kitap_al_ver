// ignore_for_file: file_names


import 'package:flutter/material.dart';
import 'package:kitap_al_ver/configuration/core/my_searchWidget.dart';
import 'package:kitap_al_ver/tabbar/screen/drawer/books_home.dart';


class AnimatedDrawer extends StatefulWidget {
  // ignore: use_super_parameters
  const AnimatedDrawer({
    Key? key,
  }) : super(key: key);

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
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: SearchWidget(
                                searchController: searchController),
                          ),
                          IconButton(
                            icon: const Icon(Icons.filter_list),
                            onPressed: () {
                              // Add functionality for the filter icon here
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.settings),
                            onPressed: () {
                              // Add functionality for the settings icon here
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
          const  Expanded(
              child: Books_Home(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
