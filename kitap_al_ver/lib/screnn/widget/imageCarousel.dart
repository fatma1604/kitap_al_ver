// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController _pageController = PageController();
  Timer? _timer;

  // List of images
  List<String> images = [
    'assets/images/slider.jpg',
    'assets/images/image1.png',
    'assets/images/slider3.png',
  ];

  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    // Start automatic slideshow
    _startSlideshow();
  }

  @override
  void dispose() {
    // Dispose timer when widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  void _startSlideshow() {
    // Set up timer to change page every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPageIndex < images.length - 1) {
        _currentPageIndex++;
      } else {
        _currentPageIndex = 0;
      }
      _pageController.animateToPage(
        _currentPageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 130,
        child: PageView.builder(
          controller: _pageController,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Image.asset(
              images[index],
              fit: BoxFit.cover,
            );
          },
          onPageChanged: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
        ),
      ),
    );
  }
}
