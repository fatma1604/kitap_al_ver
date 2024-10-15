// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TBIconData extends StatelessWidget {
  final IconData icon;
  final double size;
  final double opacity;

  // ignore: use_super_parameters
  const TBIconData({
    Key? key,
    required this.icon,
    this.size = 1.0, 
    this.opacity = 1.0, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 28 * size,
      color: const Color.fromARGB(150, 0, 0, 0),
    );
  }
}
