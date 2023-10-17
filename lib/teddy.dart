import 'dart:math';

import 'package:flutter/material.dart';

class MyTeddy extends StatelessWidget {
  final int teddySpriteCount; // between 1~22
  final String teddyDirection;

  const MyTeddy({
    Key? key,
    required this.teddySpriteCount,
    required this.teddyDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (teddyDirection == "left") {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 50,
        width: 50,
        child: Image.asset("images/teddy$teddySpriteCount.png"),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 50,
          width: 50,
          child: Image.asset("images/teddy$teddySpriteCount.png"),
        ),
      );
    }
  }
}
