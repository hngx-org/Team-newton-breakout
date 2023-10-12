import 'dart:async';
import 'package:breakout_revival/game/component/bricks.dart';
import 'package:breakout_revival/game/component/player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameScreen extends StatefulWidget {
  static const route = '/game';

  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

enum DIRECTION {
  up,
  down,
  left,
  right,
}

class _GameScreenState extends State<GameScreen> {
  //Ball variables :-
  double ballX = 0.0;
  double ballY = 0.0;
  double ballSpeed = 0.022; //(0.010, 0.016, 0.022)
  DIRECTION ballXdir = DIRECTION.left;
  DIRECTION ballYdir = DIRECTION.down;

  //Player variables :-
  double playerX = -0.5 *
      (playerWidth); // its value is -0.5 *(playerWidth) to ensure that the player bar initially remains in the centre
  static double playerWidth = 0.4; // ( 0.4, 0.8, 1.2)
  double playerSpeed = 0.2;

  //Brick variables :-
  static double wallGap = 0.5 *
      (2 - numOfBricksPerRow * brickWidth - (numOfBricksPerRow - 1) * brickGap);
  static int numOfBricksPerRow = 4;
  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.9;
  static double brickWidth = 0.4;
  static double brickHeight = 0.1;
  static double brickGap = 0.05;

  List brickList = [
    [firstBrickX, firstBrickY, false],
    [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 3 * (brickWidth + brickGap), firstBrickY, false],
    [
      firstBrickX + 0 * (brickWidth + brickGap),
      firstBrickY + 1 * (brickHeight + brickGap),
      false
    ],
    [
      firstBrickX + 1 * (brickWidth + brickGap),
      firstBrickY + 1 * (brickHeight + brickGap),
      false
    ],
    [
      firstBrickX + 2 * (brickWidth + brickGap),
      firstBrickY + 1 * (brickHeight + brickGap),
      false
    ],
    [
      firstBrickX + 3 * (brickWidth + brickGap),
      firstBrickY + 1 * (brickHeight + brickGap),
      false
    ],
    [
      firstBrickX + 0 * (brickWidth + brickGap),
      firstBrickY + 2 * (brickHeight + brickGap),
      false
    ],
    [
      firstBrickX + 1 * (brickWidth + brickGap),
      firstBrickY + 2 * (brickHeight + brickGap),
      false
    ],
    [
      firstBrickX + 2 * (brickWidth + brickGap),
      firstBrickY + 2 * (brickHeight + brickGap),
      false
    ],
    [
      firstBrickX + 3 * (brickWidth + brickGap),
      firstBrickY + 2 * (brickHeight + brickGap),
      false
    ],
  ];

  List<Widget> generateBricks() {
    List<Widget> list = [];
    for (int i = 0; i < brickList.length; i++) {
      list.add(
        MyBrick(
          brickX: brickList[i][0],
          brickY: brickList[i][1],
          brickHeight: brickHeight,
          brickWidth: brickWidth,
          brickBroken: brickList[i][2],
        ),
      );
    }
    return list;
  }

  //Game settings :-
  bool hasGameStarted = false;
  bool hasGameEnded = false;
  int brokenBrickCounter = 0;
  String endText = '';

  //ALL FUNCTIONS :-

  void loadDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ballSpeed = prefs.getDouble('bs') ?? 1.0;
      playerWidth = prefs.getDouble('pw') ?? 1.0;
      if (ballSpeed == 0.5) {
        ballSpeed = 0.010;
      } else if (ballSpeed == 1.0) {
        ballSpeed = 0.016;
      } else if (ballSpeed == 1.5) {
        ballSpeed = 0.022;
      }

      if (playerWidth == 0.5) {
        playerWidth = 0.4;
      } else if (playerWidth == 1.0) {
        playerWidth = 0.8;
      } else if (playerWidth == 1.5) {
        playerWidth = 1.2;
      }

      playerX = -(0.5) * playerWidth;
    });
  }

  void startGame() {
    setState(() {
      hasGameStarted = true;
    });
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        //The ball must be moving constantly from the starting of the game till its over
        //Thus, every 10 milliseconds we move the ball and uodate its DIRECTION
        moveBall();
        updateBallDIRECTION();

        //We must also keep checking if the ball has hit any bricks
        checkForBrokenBricks();
        //If at any point of the game, the player dies, we must :
        //  1. stop the timer,
        //  2. update the game state booleans

        if (isPlayerDead() || areAllBricksBroken()) {
          timer.cancel();
          setState(() {
            hasGameEnded = true;
          });
        }
      });
    });
  }

  void pauseGame() {
    setState(() {
      hasGameStarted = true;
    });

    // Timer.periodic(const Duration(milliseconds: 10), (timer) {
    //   setState(() {
    //     //The ball must be moving constantly from the starting of the game till its over
    //     //Thus, every 10 milliseconds we move the ball and uodate its DIRECTION
    //     moveBall();
    //     updateBallDIRECTION();

    //     //We must also keep checking if the ball has hit any bricks
    //     checkForBrokenBricks();
    //     //If at any point of the game, the player dies, we must :
    //     //  1. stop the timer,
    //     //  2. update the game state booleans

    //     if (isPlayerDead() || areAllBricksBroken()) {
    //       timer.cancel();
    //       setState(() {
    //         hasGameEnded = true;
    //       });
    //     }
    //   });
    // });
  }

  void checkForBrokenBricks() {
    for (int i = 0; i < brickList.length; i++) {
      if (ballX >= brickList[i][0] &&
              ballX <= brickList[i][0] + brickWidth &&
              ballY <= brickList[i][1] + brickHeight &&
              brickList[i][2] == false
          // && ballY >= brickList[i][1]) {
          ) {
        setState(() {
          brickList[i][2] = true;
          brokenBrickCounter++;
          //update ball's DIRECTION
          //Now to do this, we must determine which side of the brick has been hit
          // as that influences the DIRECTION in which the ball has to be reflected

          //To do this, we can compute the distance of the ball from each side of the brick
          //The shortest distance will correspond to the side of the brick that has been hit
          double leftSideDist = (brickList[i][0] - ballX).abs();
          double rightSideDist = (brickList[i][0] + brickWidth - ballX).abs();
          double topSideDist = (brickList[i][1] - ballY).abs();
          double bottomSideDist = (brickList[i][1] + brickHeight - ballY).abs();

          String min = findMinDist(
              leftSideDist, rightSideDist, topSideDist, bottomSideDist);
          switch (min) {
            case 'l':
              ballXdir = DIRECTION.left;
              break;
            case 'r':
              ballXdir = DIRECTION.right;
              break;
            case 't':
              ballYdir = DIRECTION.up;
              break;
            case 'b':
              ballYdir = DIRECTION.down;
              break;
          }
        });
      }
    }
  }

  String findMinDist(double l, double r, double t, double b) {
    double mini = l;
    if (mini > r) mini = r;
    if (mini > t) mini = t;
    if (mini > b) mini = b;

    if ((mini - l).abs() < 0.01) {
      return 'l';
    } else if ((mini - r).abs() < 0.01) {
      return 'r';
    } else if ((mini - t).abs() < 0.01) {
      return 't';
    } else if ((mini - b).abs() < 0.01) {
      return 'b';
    }

    return '';
  }

  bool isPlayerDead() {
    if (ballY > 0.94) {
      setState(() {
        endText = 'GAME OVER!';
      });
      return true;
    }
    return false;
  }

  bool areAllBricksBroken() {
    if (brokenBrickCounter == brickList.length) {
      setState(() {
        endText = 'YOU WON!';
      });
      return true;
    }
    return false;
  }

  void updateBallDIRECTION() {
    setState(() {
      //Bouncing ball upwards once it hits player bar
      if (ballX >= playerX && ballX <= playerX + playerWidth && ballY >= 0.88) {
        ballYdir = DIRECTION.up;
        //If the ball hits the exact edges of the player bar, we show an angle in its reflection
        if (ballX == playerX) {
          ballXdir = DIRECTION.left;
        } else if (ballX == playerX + playerWidth) {
          ballXdir = DIRECTION.right;
        }
      }
      //Bouncing ball downwards once it hits the top of the screen
      else if (ballY <= -1) {
        ballYdir = DIRECTION.down;
      }
      //Bouncing ball right if it hits the left side of the screen
      if (ballX <= -1) {
        ballXdir = DIRECTION.right;
      }
      //Bouncing ball left if it hits the right side of the screen
      else if (ballX >= 1) {
        ballXdir = DIRECTION.left;
      }
    });
  }

  void moveBall() {
    setState(() {
      //Vertical Movement :
      if (ballYdir == DIRECTION.down) {
        ballY += ballSpeed;
      } else if (ballYdir == DIRECTION.up) {
        ballY -= ballSpeed;
      }

      //Horizontal Movement :
      if (ballXdir == DIRECTION.right) {
        ballX += 1.5 * ballSpeed;
      } else if (ballXdir == DIRECTION.left) {
        ballX -= 1.5 * ballSpeed;
      }
    });
  }

  void movePlayer(double position) {
    setState(() {
      playerX = position;
    });
  }

  void movePlayerleft() {
    if (playerX - playerSpeed >= -1) {
      setState(() {
        playerX -= playerSpeed;
      });
    }
  }

  void movePlayerright() {
    if (playerX + playerWidth + playerSpeed <= 1) {
      setState(() {
        playerX += playerSpeed;
      });
    }
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    double delta = details.delta.dx * playerSpeed * playerSpeed;

    // Update the state of your container's position
    setState(() {
      // Add the delta multiplied by the player speed to the initial position
      playerX += delta * playerSpeed;

      // Check if the container is within the screen boundaries
      if (playerX < -1) {
        // If it is too far left, set it to -1
        playerX = -1;
      } else if (playerX + playerWidth > 1) {
        // If it is too far right, set it to 1 - playerWidth
        playerX = 1 - playerWidth;
      }

      // Assign the initial position to the playerX variable
    });
  }

  void resetGame() {
    setState(() {
      hasGameEnded = false;
      hasGameStarted = false;
      brokenBrickCounter = 0;
      ballX = 0.0;
      ballY = 0.0;
      ballXdir = DIRECTION.left;
      ballYdir = DIRECTION.down;
      playerX = -0.5 * (playerWidth);
      for (int i = 0; i < brickList.length; i++) {
        brickList[i][2] = false;
      }
    });
  }

  @override
  void initState() {
    loadDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryObject = MediaQuery.of(context);
    return SafeArea(
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            movePlayerleft();
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            movePlayerright();
          }
        },
        child: GestureDetector(
          onTap: hasGameStarted ? pauseGame : startGame,
          child: Scaffold(
            backgroundColor: Colors.tealAccent,
            body: Center(
              child: Stack(
                children: [
                  //PLAYER INTERACTIVE SCREENS :

                  //1. Tap to Begin :-
                  Visibility(
                    visible: !hasGameStarted,
                    child: Align(
                      alignment: const Alignment(0.0, -0.2),
                      child: Text(
                        kIsWeb ? 'click to begin' : 'tap to begin',
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: Colors.teal.shade700,
                                  fontSize: 16,
                                ),
                      ),
                    ),
                  ),

                  //2. Game Over Screen :-
                  Visibility(
                      visible: hasGameEnded,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              endText,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                    fontSize: kIsWeb
                                        ? mediaQueryObject.size.width * 0.03
                                        : mediaQueryObject.size.height * 0.025,
                                    color: Colors.teal,
                                  ),
                            ),
                            SizedBox(
                                height: mediaQueryObject.size.height * 0.05),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          mediaQueryObject.size.width * 0.02,
                                      vertical: kIsWeb
                                          ? mediaQueryObject.size.height * 0.02
                                          : mediaQueryObject.size.height *
                                              0.015,
                                    ),
                                  ),
                                  onPressed: resetGame,
                                  child: Icon(
                                    Icons.replay,
                                    size: kIsWeb
                                        ? 20
                                        : mediaQueryObject.size.height * 0.03,
                                    color: Colors.tealAccent,
                                  ),
                                ),
                                SizedBox(
                                  width: mediaQueryObject.size.width * 0.03,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            mediaQueryObject.size.width * 0.02,
                                        vertical: kIsWeb
                                            ? mediaQueryObject.size.height *
                                                0.02
                                            : mediaQueryObject.size.height *
                                                0.015,
                                      )),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.home_outlined,
                                    size: kIsWeb
                                        ? 20
                                        : mediaQueryObject.size.height * 0.03,
                                    color: Colors.tealAccent,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),

                  //BALL
                  Container(
                    alignment: Alignment(ballX, ballY),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor:
                          hasGameEnded ? Colors.tealAccent : Colors.teal,
                    ),
                  ),

                  //PLAYER
                  MyPlayer(
                    onHorizontalDragUpdate: onHorizontalDragUpdate,
                    playerX: playerX,
                    playerWidth: playerWidth,
                  ),

                  //BRICKS
                  ...generateBricks(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


