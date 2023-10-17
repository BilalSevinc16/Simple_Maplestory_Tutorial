import 'dart:math';

import 'package:flutter/material.dart';

class MyBoy extends StatelessWidget {
  final int boySpriteCount; // between 1~2
  final String boyDirection;
  final int? attackBoySpriteCount;
  final bool? underAttack;
  final bool? currentlyLeveling;

  const MyBoy({
    Key? key,
    required this.boySpriteCount,
    required this.boyDirection,
    this.attackBoySpriteCount,
    this.underAttack,
    this.currentlyLeveling,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int directionAsInt = 1;
    if (boyDirection == "right") {
      directionAsInt = 1;
    } else if (boyDirection == "left") {
      directionAsInt = 0;
    } else {
      directionAsInt = 1;
    }
    if (attackBoySpriteCount == 0) {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi * directionAsInt),
      );
    }
    if (boyDirection == "left") {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 120,
        width: 120,
        child: Image.asset("images/walkboy$boySpriteCount.png"),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 120,
          width: 120,
          child: Image.asset("images/walkboy$boySpriteCount.png"),
        ),
      );
    }
  }
}
