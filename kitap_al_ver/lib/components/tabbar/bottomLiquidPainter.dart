// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BottomLiquidPainter extends CustomPainter {
  final double _height;
  final Color _color;

  BottomLiquidPainter(this._height, this._color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = _color
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, size.height)
      ..cubicTo(
        size.width * .7,
        size.height * _height,
        size.width * .3,
        size.height * _height,
        size.width,
        size.height,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
