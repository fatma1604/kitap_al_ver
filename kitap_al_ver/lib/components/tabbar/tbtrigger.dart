
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/components/tabbar/tBiconData.dart';


class TBTrigger extends StatelessWidget {
  final int currentIndex;
  final int index;
  final Animation<double> tBHeightAni;
  final Animation<double> triggerableAni;
  final List<IconData> listOfIcons;
  final Function(int) onTabTapped;
  final AnimationController tBWidthCon;
  final AnimationController tBColorOpacCon;
  final AnimationController transCon;
  final AnimationController triggerableCon;
  final AnimationController bottomLiquidCon;

  // ignore: use_key_in_widget_constructors
  const TBTrigger({
    required this.currentIndex,
    required this.index,
    required this.tBHeightAni,
    required this.triggerableAni,
    required this.listOfIcons,
    required this.onTabTapped,
    required this.tBWidthCon,
    required this.tBColorOpacCon,
    required this.transCon,
    required this.triggerableCon,
    required this.bottomLiquidCon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        onTabTapped(currentIndex);
        tBWidthCon.forward();
        tBColorOpacCon.forward();
        transCon.reset();
        transCon.forward();
        triggerableCon.forward();
        bottomLiquidCon.forward();
      },
      child: Container(
        alignment: Alignment.center,
        height: tBHeightAni.value,
        width: index == currentIndex ? triggerableAni.value : 50,
        child: index == currentIndex
            ? const SizedBox()
            : TBIconData(
                icon: listOfIcons[currentIndex],
                size: 1,
                opacity: 1,
              ),
      ),
    );
  }
}
