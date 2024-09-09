import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitap_al_ver/post/camerapage.dart';
import 'package:kitap_al_ver/post/galleripage.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  File? imageCamera;
  Uint8List? imageGallery;
  int _currentIndex = 0; // Define _currentIndex here

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void _handleImageCaptured(File image) {
    setState(() {
      imageCamera = image;
      // Pass imageCamera to Galleripage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Galleripage(initialImage: imageCamera),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: [
                SimpleCameraTest(),
                Galleripage(initialImage: imageCamera), // Pass initial image
              ],
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: 10.h,
              right: _currentIndex == 0 ? 90.w : 140.w,
              child: Container(
                width: 150.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        navigationTapped(0);
                      },
                      child: Icon(
                        Icons.camera_alt,
                        color: _currentIndex == 0 ? Colors.white : Colors.grey,
                        size: 20.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        navigationTapped(1);
                      },
                      child: Icon(
                        Icons.photo_library,
                        color: _currentIndex == 1 ? Colors.white : Colors.grey,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
