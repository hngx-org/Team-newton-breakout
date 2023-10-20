import 'dart:async';
import 'dart:math';
import 'package:breakout_revival/component/background.dart';
import 'package:breakout_revival/component/ball.dart';
import 'package:breakout_revival/component/bricks.dart';
import 'package:breakout_revival/component/player.dart';
import 'package:breakout_revival/screens/homepage.dart';
import 'package:breakout_revival/utils/constants.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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

enum PLAYERDIRECTION {
  stationary,
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
  PLAYERDIRECTION playerDirection = PLAYERDIRECTION.stationary;

  //Player variables :-
  double playerX =
      0; // its value is -0.5 *(playerWidth) to ensure that the player bar initially remains in the centre
  double playerWidth = 0.4; // ( 0.4, 0.8, 1.2)
  double playerSpeed = 0.2;

  //Brick variables :-
  double wallGap = 0;
  int numOfBricksPerRow = 3;
  double firstBrickX = 0;
  double firstBrickY = -0.8;
  double brickWidth = 0.6;
  double brickHeight = 0.07;
  double brickGap = 0.02;
  int initialLevel = 1;
  int numberOfRows = 4;
  List numberOfLives = [1, 1, 1];

  List<List<dynamic>> brickList = [];
  late Timer timer;
  List<List<dynamic>> generateBrickList(
      int numRows,
      int bricksPerRow,
      double brickWidth,
      double brickHeight,
      double brickGap,
      double brickX,
      double brickY) {
    List<List<dynamic>> bricksList = [];

    for (int row = 0; row < numRows; row++) {
      for (int col = 0; col < bricksPerRow; col++) {
        double x = brickX + col * (brickWidth + brickGap);
        double y = brickY + row * (brickHeight + brickGap);
        bricksList.add([x, y, false, false]);
      }
    }

    return bricksList;
  }

  List<List<String>> brickColors = [];

  generateRandomBrick() {
    List<List<String>> bricks = [
      [Constants.brownBrickPath, Constants.brownCrackedBrickPath],
      [Constants.deepBlueBrickPath, Constants.deepBlueCrackedBrickPath],
      [Constants.deepGreenBrickPath, Constants.deepGreenCrackedBrickPath],
      [Constants.redBrickPath, Constants.redCrackedbrickPath],
      [Constants.purpleBrickPath, Constants.purpleCrackedBrickPath],
      [Constants.yellowBrickPath, Constants.yellowCrackedbrickPath],
      [Constants.lightBlueBrickPath, Constants.lightBlueCrackedBrickPath],
      [Constants.lightGreenBrickPath, Constants.lightGreenCrackedBrickPath],
      [Constants.orangeBrickPath, Constants.orangeCrackedBrickPath],
      [Constants.greyBrickPath, Constants.greyCrackedBrickPath],
    ];
    List<List<String>> colors = [];
    // Generate a random index
    Random random = Random();
    for (int i = 0; i < brickList.length; i++) {
      // Generate a random index to pick a color pair
      int randomIndex = random.nextInt(bricks.length);
      colors.add(bricks[randomIndex]);
    }
    setState(() {
      brickColors = colors;
    });
  }

  List<Widget> generateBricks() {
    List<Widget> list = [];

    for (int i = 0; i < brickList.length; i++) {
      final List<String> brick = brickColors[i];
      list.add(
        MyBrick(
          brickX: brickList[i][0],
          brickY: brickList[i][1],
          brickHeight: brickHeight,
          brickWidth: brickWidth,
          brickBroken: brickList[i][2],
          brickCracked: brickList[i][3],
          numberOfBricksPerRow: numOfBricksPerRow,
          brick: brick, particleEffectAsset: '',
        ),
      );
    }
    return list;
  }

  void resetGame() {
    setState(() {
      hasGameEnded = false;
      hasGameStarted = false;
      brokenBrickCounter = 0;
      numberOfLives = [1, 1, 1];
      initialLevel = 1;
      scores = 0;
      ballX = 0.0;
      ballY = 0.0;
      ballXdir = DIRECTION.left;
      ballYdir = DIRECTION.down;
      numOfBricksPerRow = 3;
      brickWidth = 0.6;
      brickHeight = 0.07;
      brickGap = 0.02;
      wallGap = 0.5 *
          (2 -
              numOfBricksPerRow * brickWidth -
              (numOfBricksPerRow - 1) * brickGap);
      playerX = -0.5 * (playerWidth);
      firstBrickX = -1 + wallGap;
      brickList = generateBrickList(
          3, 3, brickWidth, brickHeight, brickGap, firstBrickX, firstBrickY);
      generateRandomBrick();
    });
  }

  void nextLevel(int level) {
    if (level == 2) {
      setState(() {
        hasGameEnded = false;
        hasGameStarted = false;
        ballX = 0.0;
        ballY = 0.0;

        brokenBrickCounter = 0;
        ballXdir = DIRECTION.left;
        ballYdir = DIRECTION.down;
        playerX = -0.5 * (playerWidth);
        numberOfRows = 5;
        numOfBricksPerRow = 4;
        brickGap = 0.01;
        brickWidth = 0.5;
        brickHeight = brickHeight;
        wallGap = 0.5 *
            (2 -
                numOfBricksPerRow * brickWidth -
                (numOfBricksPerRow - 1) * brickGap);
        firstBrickX = -1 + wallGap;
        brickList = generateBrickList(numberOfRows, numOfBricksPerRow,
            brickWidth, brickHeight, brickGap, firstBrickX, firstBrickY);
        generateRandomBrick();
      });
    } else if (level == 3) {
      setState(() {
        hasGameEnded = false;
        hasGameStarted = false;
        ballX = 0.0;
        ballY = 0.0;

        brokenBrickCounter = 0;
        ballXdir = DIRECTION.left;
        ballYdir = DIRECTION.down;
        playerX = -0.5 * (playerWidth);
        numberOfRows = 6;
        numOfBricksPerRow = 6;
        brickGap = 0.009;
        brickWidth = 0.3;
        brickHeight = brickHeight;
        wallGap = 0.5 *
            (2 -
                numOfBricksPerRow * brickWidth -
                (numOfBricksPerRow - 1) * brickGap);
        firstBrickX = -1 + wallGap;
        brickList = generateBrickList(numberOfRows, numOfBricksPerRow,
            brickWidth, brickHeight, brickGap, firstBrickX, firstBrickY);
        generateRandomBrick();
      });
    } else if (level == 4) {
      setState(() {
        hasGameEnded = false;
        hasGameStarted = false;
        ballX = 0.0;
        ballY = 0.0;

        brokenBrickCounter = 0;
        ballXdir = DIRECTION.left;
        ballYdir = DIRECTION.down;
        playerX = -0.5 * (playerWidth);
        numberOfRows = 8;
        numOfBricksPerRow = 9;
        brickGap = 0.007;
        brickWidth = 0.2;
        brickHeight = brickHeight;
        wallGap = 0.5 *
            (2 -
                numOfBricksPerRow * brickWidth -
                (numOfBricksPerRow - 1) * brickGap);
        firstBrickX = -1 + wallGap;
        brickList = generateBrickList(numberOfRows, numOfBricksPerRow,
            brickWidth, brickHeight, brickGap, firstBrickX, firstBrickY);
        generateRandomBrick();
      });
    }
  }

  //Game settings :-
  bool hasGameStarted = false;
  bool hasGameEnded = false;
  int brokenBrickCounter = 0;
  int scores = 0;
  String endText = '';
  bool hasGamePaused = false;

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
      hasGamePaused = false;
      hasGameStarted = true;
    });
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
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
          hasGameEnded = true;
        }
      });
    });
  }

  pauseGame() {
    setState(() {
      if (!hasGamePaused) {
        hasGamePaused = true;
      }

      timer.cancel();
    });
  }

  void checkForBrokenBricks() {
    for (int i = 0; i < brickList.length; i++) {
      if (ballX >= brickList[i][0] &&
          ballX <= brickList[i][0] + brickWidth &&
          ballY <= brickList[i][1] + brickHeight &&
          brickList[i][2] == false &&
          ballY >= brickList[i][1]) {
        if (initialLevel > 2) {
          if (brickList[i][3] == false) {
            brickList[i][3] = true;
            brokenBrickCounter++;
            scores = scores + brokenBrickCounter;
          } else {
            brickList[i][2] = true;
            brokenBrickCounter++;
            scores = scores + brokenBrickCounter;
          }
        } else {
          brickList[i][2] = true;
          brokenBrickCounter++;
          scores = scores + brokenBrickCounter;
        }

        // Play the "Brick Break" sound effect here
        FlameAudio.play(
          Constants.brickBreakSound,
        );

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
    if (ballY > 0.94 && numberOfLives[0] == 0) {
      saveScores();
      FlameAudio.play(
        Constants.gameOverSound,
      );
      setState(() {
        endText = 'GAME OVER!';
      });
      return true;
    }
    if (ballY > 0.94) {
      if (numberOfLives[2] != 0) {
        setState(() {
          timer.cancel();
          ballX = 0.0;
          ballY = 0.0;
          hasGamePaused = true;
          numberOfLives[2] = 0;
        });
        FlameAudio.play(
          Constants.gameOverSound,
        );
      } else {
        if (numberOfLives[1] != 0) {
          setState(() {
            timer.cancel();
            ballX = 0.0;
            hasGamePaused = true;
            ballY = 0.0;
            numberOfLives[1] = 0;
          });
          FlameAudio.play(
            Constants.gameOverSound,
          );
        } else {
          if (numberOfLives[0] != 0) {
            setState(() {
              timer.cancel();
              ballX = 0.0;
              hasGamePaused = true;
              ballY = 0.0;
              numberOfLives[0] = 0;
            });
            FlameAudio.play(
              Constants.gameOverSound,
            );
          }
        }
      }
    }
    return false;
  }

  saveScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final getScore = prefs.getInt('high') ?? 0;
    if (getScore < scores) {
      await prefs.setInt('high', scores);
    }
  }

  bool areAllBricksBroken() {
    if (initialLevel > 2) {
      if (brokenBrickCounter == (brickList.length * 2)) {
        FlameAudio.play(
          Constants.victorySound,
        );
        setState(() {
          endText = 'YOU WON!';
        });
        return true;
      }
    } else {
      if (brokenBrickCounter == brickList.length) {
        FlameAudio.play(
          Constants.victorySound,
        );
        setState(() {
          endText = 'YOU WON!';
        });
        return true;
      }
    }

    return false;
  }

  void updateBallDIRECTION() {
    //Bouncing ball upwards once it hits player bar
    if (ballX >= playerX && ballX <= playerX + playerWidth && ballY >= 0.84) {
      ballYdir = DIRECTION.up;
      //If the ball hits the exact edges of the player bar, we show an angle in its reflection
      if (ballX == playerX && ballXdir == DIRECTION.left) {
        ballXdir = DIRECTION.left;
      } else if (ballX == playerX + playerWidth &&
          ballXdir == DIRECTION.right) {
        ballXdir = DIRECTION.right;
      } else if (ballX == playerX && ballXdir == DIRECTION.right) {
        ballXdir = DIRECTION.left;
      } else if (ballX == (playerX + playerWidth) &&
          ballXdir == DIRECTION.left) {
        ballXdir = DIRECTION.right;
      }
      // Check the player's direction and set the ball's direction accordingly

      if (playerDirection == PLAYERDIRECTION.left &&
          ballXdir == DIRECTION.right &&
          ballYdir == DIRECTION.down) {
        ballXdir = DIRECTION.right;
        ballYdir = DIRECTION.up;
      } else if (playerDirection == PLAYERDIRECTION.left &&
          ballXdir == DIRECTION.left &&
          ballYdir == DIRECTION.down) {
        ballXdir = DIRECTION.left;
        ballYdir = DIRECTION.up;
      } else if (playerDirection == PLAYERDIRECTION.right &&
          ballXdir == DIRECTION.right &&
          ballYdir == DIRECTION.down) {
        ballXdir = DIRECTION.left;
        ballYdir = DIRECTION.up;
      } else if (playerDirection == PLAYERDIRECTION.right &&
          ballXdir == DIRECTION.left &&
          ballYdir == DIRECTION.down) {
        ballXdir = DIRECTION.left;
        ballYdir = DIRECTION.up;
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
  }

  void moveBall() {
    //Vertical Movement :
    if (ballYdir == DIRECTION.down) {
      ballY += ballSpeed;
    } else if (ballYdir == DIRECTION.up) {
      ballY -= ballSpeed;
    }

    //Horizontal Movement :
    if (ballXdir == DIRECTION.right) {
      ballX += ballSpeed;
    } else if (ballXdir == DIRECTION.left) {
      ballX -= ballSpeed;
    }
  }

  void movePlayer(double position) {
    setState(() {
      playerX = position;
    });
  }

  void movePlayerleft() {
    playerDirection = PLAYERDIRECTION.left;
    if (playerX - playerSpeed >= -1) {
      setState(() {
        playerX -= playerSpeed;
      });
    }
  }

  void movePlayerright() {
    playerDirection = PLAYERDIRECTION.right;
    if (playerX + playerWidth + playerSpeed <= 1) {
      setState(() {
        playerX += playerSpeed;
      });
    }
  }

  playMusic() {
    if (FlameAudio.bgm.isPlaying) {
      FlameAudio.bgm.pause();
    } else {
      FlameAudio.bgm.play(Constants.audio1, volume: 0.7);
    }
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    double delta = details.delta.dx * playerSpeed * playerSpeed;

    // Update the state of your container's position
    setState(() {
      if (delta < 0) {
        // If delta is negative, the player board is being dragged left
        playerDirection = PLAYERDIRECTION.left;
      } else if (delta > 0) {
        // If delta is positive, the player board is being dragged right
        playerDirection = PLAYERDIRECTION.right;
      } else {
        // If delta is zero, the player board is stationary
        playerDirection = PLAYERDIRECTION.stationary;
      }
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

  @override
  void initState() {
    super.initState();

    playerX = -0.5 * (playerWidth);
    wallGap = 0.5 *
        (2 -
            numOfBricksPerRow * brickWidth -
            (numOfBricksPerRow - 1) * brickGap);

    firstBrickX = -1 + wallGap;

    loadDetails();
    brickList = generateBrickList(numberOfRows, numOfBricksPerRow, brickWidth,
        brickHeight, brickGap, firstBrickX, firstBrickY);
    generateRandomBrick();
    // Load sound effects
    FlameAudio.audioCache.load(
      Constants.brickBreakSound,
    );
    FlameAudio.audioCache.load(
      Constants.audio1,
    );
    FlameAudio.audioCache.load(Constants.gameOverSound);
    FlameAudio.audioCache.load(Constants.victorySound);

    playMusic();
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryObject = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async {
        if (hasGameEnded || !hasGameStarted) {
          return true;
        }
        return false;
      },
      child: Scaffold(
        body: RawKeyboardListener(
          focusNode: FocusNode(),
          autofocus: true,
          onKey: (event) {
            if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
              movePlayerleft();
            } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
              movePlayerright();
            } else if (event.isKeyPressed(LogicalKeyboardKey.space)) {
              if (hasGamePaused) {
                startGame();
              } else {
                pauseGame();
              }
            }
          },
          child: BackGround(
            child: SafeArea(
              child: GestureDetector(
                onTap: hasGameStarted ? null : startGame,
                child: Center(
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 20.0.h, right: 20.w, top: 20.h, left: 20.w),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                for (int i = 0; i < numberOfLives.length; i++)
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 3.w),
                                    width: 20.w,
                                    height: 20.h,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: numberOfLives[i] == 1
                                            ? const Color(0xFF8cc63f)
                                            : Colors.transparent,
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.white,
                                        )),
                                  ),
                                Expanded(
                                  child: SizedBox(
                                    width: 1.w,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    hasGameEnded ? null : pauseGame();
                                  },
                                  child: Icon(
                                    Icons.pause_circle_filled_outlined,
                                    size: 28.sp,
                                    color: const Color(0xFF8cc63f),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    playMusic();
                                  },
                                  child: Icon(
                                    Icons.music_note,
                                    size: 28.sp,
                                    color: const Color(0xFF8cc63f),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  'Score: $scores',
                                  style: GoogleFonts.pressStart2p(
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //PLAYER INTERACTIVE SCREENS :

                      //1. Tap to Begin :-
                      Visibility(
                        visible: !hasGameStarted,
                        child: Align(
                          alignment: const Alignment(0.0, -0.2),
                          child: Text(
                            kIsWeb ? 'click to begin' : 'tap to begin',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color: const Color(0xFF8cc63f),
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: hasGamePaused,
                        child: Container(
                          alignment: const Alignment(0, -0.1),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8cc63f),
                              padding: EdgeInsets.symmetric(
                                horizontal: mediaQueryObject.size.width * 0.02,
                                vertical: kIsWeb
                                    ? mediaQueryObject.size.height * 0.02
                                    : mediaQueryObject.size.height * 0.015,
                              ),
                            ),
                            onPressed: () async {
                              startGame();
                            },
                            child: Icon(
                              Icons.pause_circle_filled_outlined,
                              size: kIsWeb
                                  ? 20
                                  : mediaQueryObject.size.height * 0.03,
                              color: const Color(0xFF6666FF),
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
                                            : mediaQueryObject.size.height *
                                                0.025,
                                        color: const Color(0xFF8cc63f),
                                      ),
                                ),
                                SizedBox(
                                    height:
                                        mediaQueryObject.size.height * 0.05),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF8cc63f),
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              mediaQueryObject.size.width *
                                                  0.02,
                                          vertical: kIsWeb
                                              ? mediaQueryObject.size.height *
                                                  0.02
                                              : mediaQueryObject.size.height *
                                                  0.015,
                                        ),
                                      ),
                                      onPressed: resetGame,
                                      child: Icon(
                                        Icons.replay,
                                        size: kIsWeb
                                            ? 20
                                            : mediaQueryObject.size.height *
                                                0.03,
                                        color: const Color(0xFF6666FF),
                                      ),
                                    ),
                                    Visibility(
                                      visible: areAllBricksBroken(),
                                      child: SizedBox(
                                        width:
                                            mediaQueryObject.size.width * 0.03,
                                      ),
                                    ),
                                    Visibility(
                                      visible: areAllBricksBroken(),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF8cc63f),
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                mediaQueryObject.size.width *
                                                    0.02,
                                            vertical: kIsWeb
                                                ? mediaQueryObject.size.height *
                                                    0.02
                                                : mediaQueryObject.size.height *
                                                    0.015,
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (initialLevel != 4) {
                                            setState(() {
                                              initialLevel = initialLevel + 1;
                                            });
                                            nextLevel(initialLevel);
                                          } else {
                                            setState(() {
                                              hasGameEnded = true;
                                              endText = "No more Levels";
                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.fast_forward_rounded,
                                          size: kIsWeb
                                              ? 20
                                              : mediaQueryObject.size.height *
                                                  0.03,
                                          color: const Color(0xFF6666FF),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaQueryObject.size.width * 0.03,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF8cc63f),
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                mediaQueryObject.size.width *
                                                    0.02,
                                            vertical: kIsWeb
                                                ? mediaQueryObject.size.height *
                                                    0.02
                                                : mediaQueryObject.size.height *
                                                    0.015,
                                          )),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                HomeScreen.route,
                                                (route) => false);
                                      },
                                      child: Icon(
                                        Icons.home_outlined,
                                        size: kIsWeb
                                            ? 20
                                            : mediaQueryObject.size.height *
                                                0.03,
                                        color: const Color(0xFF6666FF),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),

                      //BALL

                      Ball(
                        ballX: ballX,
                        ballY: ballY,
                        hasGameEnded: hasGameEnded,
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
        ),
      ),
    );
  }
}
