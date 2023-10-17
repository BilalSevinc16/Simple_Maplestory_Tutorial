import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_maplestory_tutorial/boy.dart';
import 'package:simple_maplestory_tutorial/button.dart';
import 'package:simple_maplestory_tutorial/snail.dart';
import 'package:simple_maplestory_tutorial/teddy.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // BLUE SNAIL
  int snailSpriteCount = 1; // initially, bluesnail1.png
  static double snailPosX = 0.5;
  static double snailPosY = 1;
  String snailDirection = "left";
  int deadSnailSprite = 0;
  bool snailAttacked = false;

  //TEDDY BEAR
  int teddySpriteCount = 1; // initially, teddy1.png
  double teddyPosX = 0;
  String teddyDirection = "right";

  //BOY CHARACTER
  int boySpriteCount = 1; // initially, standingboy1.png
  double boyPosX = -0.5;
  double boyPosY = 1;
  String boyDirection = "right";
  int attackBoySpriteCount = 0;

  // Loading Screen
  var loadingScreenColor = Colors.blue.shade100;
  var loadingScreenTextColor = Colors.blue.shade700;
  var tapToPlayColor = Colors.white;
  int loadingTime = 3;
  bool gameHasStarted = false;

  // CASH
  double cashPosX = 2; // off screen
  double cashPosY = 0.95;
  int cashSpriteStep = 1;

  // HEALTH MANA EXP
  int currentExp = 80;
  int currentHP = 120;
  int currentMana = 100;
  double levelUpPosX = 5; // off screen
  double levelUpPosY = 5; // off screen

  bool underAttack = false;
  bool currentlyLeveling = false;

  // DAMAGE
  double damageY = 0.8;
  double damageX = snailPosX - 0.2;
  var hitColor = Colors.transparent;

  // STAR
  double starX = 2; // off screen
  double starY = 2; // off screen
  int starSprite = 0;

  void playNow() {
    startGameTimer();
    moveSnail();
    moveTeddy();
    attack();
  }

  void startGameTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        loadingTime--;
      });
      if (loadingTime == 0) {
        setState(() {
          loadingScreenColor = Colors.transparent;
          loadingTime = 3;
          loadingScreenTextColor = Colors.transparent;
        });
        timer.cancel();
      }
    });
  }

  void throwStar() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        attackBoySpriteCount++;
      });
      if (attackBoySpriteCount == 5) {
        if (boyDirection == "right" && boyPosX + 0.2 > snailPosX) {
          print("hit");
        } else {
          print("missed");
        }
        attackBoySpriteCount = 0;
        timer.cancel();
        starFlies();
      }
    });
  }

  void starFlies() {
    setState(() {
      starX = boyPosX + 0.1;
      starY = 0.9;
      currentMana -= 20;
    });
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        starX += 0.05;
        starSprite++;
      });
      if ((starX - snailPosX).abs() < 0.1) {
        timer.cancel();
        //showDamage();
        starX = 2; // off screen
        //killSnail();
      }
    });
  }

  void attack() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        attackBoySpriteCount++;
      });
      if (attackBoySpriteCount == 5) {
        if (boyDirection == "right" && boyPosX + 0.2 > snailPosX) {
          print("hit");
        } else {
          print("missed");
        }
        attackBoySpriteCount = 0;
        timer.cancel();
      }
    });
  }

  void moveTeddy() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        teddySpriteCount++;
        if (teddySpriteCount == 23) {
          teddySpriteCount = 1;
        }
        if ((teddyPosX - boyPosX).abs() > 0.2) {
          if (boyDirection == "right") {
            teddyPosX = boyPosX - 0.2;
          } else if (boyDirection == "left") {
            teddyPosX = boyPosX + 0.2;
          }
        }
        if (teddyPosX - boyPosX > 0) {
          teddyDirection = "left";
        } else {
          teddyDirection = "right";
        }
      });
    });
  }

  void moveSnail() {
    Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        snailSpriteCount++;
        if (snailDirection == "left") {
          snailPosX -= 0.01;
        } else {
          snailPosX += 0.01;
        }
        if (snailPosX < 0.3) {
          snailDirection = "right";
        } else if (snailPosX > 0.6) {
          snailDirection = "left";
        }
        if (snailSpriteCount == 5) {
          snailSpriteCount = 1;
        }
      });
    });
  }

  void moveLeft() {
    setState(() {
      boyPosX -= 0.03;
      boySpriteCount++;
      boyDirection = "left";
    });
  }

  void moveRight() {
    setState(() {
      boyPosX += 0.03;
      boySpriteCount++;
      boyDirection = "right";
    });
  }

  void jump() {
    double time = 0;
    double height = 0;
    double initialHeight = boyPosY;
    Timer.periodic(const Duration(milliseconds: 70), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.5 * time;
      setState(() {
        if (initialHeight - height > 1) {
          boyPosY = 1;
          timer.cancel();
          boySpriteCount = 1;
        } else {
          boyPosY = initialHeight - height;
          boySpriteCount = 2;
        }
      });
    });
  }

  void moveCash() {
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        cashSpriteStep++;
      });
      if ((boyPosX - cashPosX).abs() < 0.1) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue.shade300,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment(snailPosX, 1.06),
                      child: BlueSnail(
                        snailSpriteCount: snailSpriteCount,
                        snailDirection: snailDirection,
                      ),
                    ),
                    Container(
                      alignment: Alignment(teddyPosX, 1.02),
                      child: MyTeddy(
                        teddySpriteCount: teddySpriteCount,
                        teddyDirection: teddyDirection,
                      ),
                    ),
                    Container(
                      alignment: Alignment(boyPosX, 1.22),
                      child: MyBoy(
                        boySpriteCount: boySpriteCount % 2 + 1,
                        boyDirection: boyDirection,
                      ),
                    ),
                    Container(
                      color: loadingScreenColor,
                      child: Center(
                        child: Text(
                          loadingTime.toString(),
                          style: TextStyle(
                            color: loadingScreenTextColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 10,
              color: Colors.green.shade600,
            ),
            Expanded(
              child: Container(
                color: Colors.grey.shade500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "M A P L E S T O R Y",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyButton(
                          text: "PLAY",
                          function: () {
                            playNow();
                          },
                        ),
                        MyButton(
                          text: "ATTACK",
                          function: attack,
                        ),
                        MyButton(
                          text: "←",
                          function: () {
                            moveLeft();
                          },
                        ),
                        MyButton(
                          text: "↑",
                          function: () {
                            jump();
                          },
                        ),
                        MyButton(
                          text: "→",
                          function: () {
                            moveRight();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
