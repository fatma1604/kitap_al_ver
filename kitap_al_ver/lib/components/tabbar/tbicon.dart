// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TBIcon extends StatelessWidget {
  final int currentIndex;
  final int index;
  final Animation<double> transAni;
  final Animation<double> oneToZeroAnim;
  final List<IconData> listOfFilledIcons;
  final List<IconData> listOfIcons;

  // ignore: use_super_parameters
  const TBIcon({
    Key? key,
    required this.currentIndex,
    required this.index,
    required this.transAni,
    required this.oneToZeroAnim,
    required this.listOfFilledIcons,
    required this.listOfIcons,
  }) : super(key: key);

  Widget tBIconData(IconData icon, double size, double opacity) {
    return Icon(
      icon,
      size: 28 * size,
      color: const Color.fromARGB(255, 218, 212, 212).withOpacity(opacity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: index == currentIndex ? 1 : 0,
      child: Transform.translate(
        offset: Offset(0, index == currentIndex ? transAni.value : 0),
        child: Container(
          width: 50,
          alignment: Alignment.center,
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 400),
            firstChild: tBIconData(
              listOfFilledIcons[currentIndex],
              oneToZeroAnim.value,
              oneToZeroAnim.value,
            ),
            secondChild: tBIconData(
              listOfIcons[currentIndex],
              1,
              1,
            ),
            crossFadeState: index == currentIndex
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
        ),
      ),
    );
  }
}
