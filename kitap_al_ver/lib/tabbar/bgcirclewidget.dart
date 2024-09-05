// ignore: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/tabbar/topLiquidPainter.dart';

class BGCircleWidget extends StatelessWidget {
  final int currentIndex;
  final int index;
  final Animation<double> bGCircleTransAni;
  final Animation<double> oneToZeroAnim;
  final Color color;
  final double colorOpacity;
  final Animation<double> bottomLiquidAni1;
  final Animation<double> bottomLiquidAni2;
  final Animation<double> bottomLiquidAni3;
  final Animation<double> bottomLiquidAni4;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  BGCircleWidget({
    required this.currentIndex,
    required this.index,
    required this.bGCircleTransAni,
    required this.oneToZeroAnim,
    required this.color,
    required this.colorOpacity,
    required this.bottomLiquidAni1,
    required this.bottomLiquidAni2,
    required this.bottomLiquidAni3,
    required this.bottomLiquidAni4,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, index == currentIndex ? bGCircleTransAni.value : 5),
      // ignore: sized_box_for_whitespace
      child: Container(
        width: 40,
        height: 65,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: 40 * oneToZeroAnim.value,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            Container(
              width: 50 * oneToZeroAnim.value,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(colorOpacity),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: SizedBox(
                width: 50 * oneToZeroAnim.value,
                height: 75 * oneToZeroAnim.value,
                child: CustomPaint(
                  painter: TopLiquidPainter(
                    bottomLiquidAni1.value,
                    bottomLiquidAni2.value,
                    bottomLiquidAni3.value,
                    bottomLiquidAni4.value,
                    Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: SizedBox(
                width: 50 * oneToZeroAnim.value,
                height: 50 * oneToZeroAnim.value,
                child: CustomPaint(
                  painter: TopLiquidPainter(
                    bottomLiquidAni1.value,
                    bottomLiquidAni2.value,
                    bottomLiquidAni3.value,
                    bottomLiquidAni4.value,
                    color.withOpacity(colorOpacity),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
