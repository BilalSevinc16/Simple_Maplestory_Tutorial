import 'dart:math';

import 'package:flutter/material.dart';

class BlueSnail extends StatelessWidget {
  final int snailSpriteCount; // between 1~4
  final String snailDirection;

  const BlueSnail({
    Key? key,
    required this.snailSpriteCount,
    required this.snailDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snailDirection == "left") {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 50,
        width: 50,
        child: Image.asset("images/snail$snailSpriteCount.png"),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 50,
          width: 50,
          child: Image.asset("images/snail$snailSpriteCount.png"),
        ),
      );
    }
  }
}
