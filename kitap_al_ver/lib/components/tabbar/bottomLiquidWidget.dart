// Define the bottom liquid widget
// ignore_for_file: file_names




import 'package:flutter/material.dart';
import 'package:kitap_al_ver/components/tabbar/bottomLiquidPainter.dart';

// ignore: depend_on_referenced_packages


class BottomLiquidWidget extends StatelessWidget {
  final int currentIndex;
  final int index;
  final double bottomLiquidAni5Value;
  final Color color;
  final double colorOpacity;

  // ignore: use_super_parameters
  const BottomLiquidWidget({
    Key? key,
    required this.currentIndex,
    required this.index,
    required this.bottomLiquidAni5Value,
    required this.color,
    required this.colorOpacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          SizedBox(
            width: 35,
            height: 20,
            child: CustomPaint(
              painter: BottomLiquidPainter(
                bottomLiquidAni5Value,
                index == currentIndex ? Colors.white : Colors.transparent,
              ),
            ),
          ),
          SizedBox(
            width: 35,
            height: 20,
            child: CustomPaint(
              painter: BottomLiquidPainter(
                index == currentIndex ? bottomLiquidAni5Value : 1,
                color.withOpacity(colorOpacity),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
