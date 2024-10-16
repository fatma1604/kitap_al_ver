// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final List<String> imageUrls; // Expect a List<String>

  const MyImageSlider({
    super.key,
    required this.imageUrls,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        onPageChanged: onChange,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Hero(
            tag: imageUrls[index],
            child: Image.network(
                imageUrls[index]), 
          );
        },
      ),
    );
  }
}
