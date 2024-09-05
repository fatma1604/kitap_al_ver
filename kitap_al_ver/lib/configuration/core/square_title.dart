// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class SquareTitle extends StatelessWidget {
  final images;
  final Function()? onTap;
  // ignore: use_super_parameters
  const SquareTitle({Key? key, this.onTap, required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          images,
          height: 50,
        ),
      ),
    );
  }
}
