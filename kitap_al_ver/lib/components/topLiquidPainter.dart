// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TopLiquidPainter extends CustomPainter {
  final double _height1;
  final double _width1;
  final double _height2;
  final double _width2;
  final Color _color;

  TopLiquidPainter(
    this._height1,
    this._width1,
    this._height2,
    this._width2,
    this._color,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = _color
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, 0)
      ..cubicTo(
        0,
        size.height * .4,
        size.width * _width1,
        size.height * _height2,
        size.width * .5,
        size.height * _height1,
      )
      ..cubicTo(
        size.width * _width2,
        size.height * _height2,
        size.width,
        size.height * .4,
        size.width,
        0,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
