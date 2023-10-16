// import 'package:breakout_revival/utils/constants.dart';
// import 'package:flame/components.dart';
// import 'package:flame_audio/flame_audio.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../component/bricks.dart';
// import '../screens/gamepage.dart';


// class GameState extends ChangeNotifier {

//   double ballX;
//   double ballY;
//   double ballSpeed = 0.022; //(0.010, 0.016, 0.022)
//   DIRECTION ballXdir = DIRECTION.left;
//   DIRECTION ballYdir = DIRECTION.down;
//   PLAYERDIRECTION playerDirection = PLAYERDIRECTION.stationary;
  
//     //Player variables :-
//   double playerX =
//       0; // its value is -0.5 *(playerWidth) to ensure that the player bar initially remains in the centre
//   double playerWidth = 0.4; // ( 0.4, 0.8, 1.2)
//   double playerSpeed = 0.2;
  
//   //Brick variables :-
//   double wallGap = 0;
//   int numOfBricksPerRow = 3;
//   double firstBrickX = 0;
//   double firstBrickY = -0.8;
//   double brickWidth = 0.4;
//   double brickHeight = 0.1;
//   double brickGap = 0.05;
//   int initialLevel = 1;
//   int numberOfRows = 3;

//    List<List<dynamic>> brickList = [];
//   late Timer timer;

//    //Game settings :-
//    bool hasGameEnded = false;
//   bool hasGameStarted = false;
//   int brokenBrickCounter = 0;
//   int scores = 0;
//    String endText = '';
//   bool hasGamePaused = false;

//   List<List<dynamic>> generateBrickList(
//       int numRows,
//       int bricksPerRow,
//       double brickWidth,
//       double brickHeight,
//       double brickGap,
//       double brickX,
//       double brickY) {
//     List<List<dynamic>> bricksList = [];

//     for (int row = 0; row < numRows; row++) {
//       for (int col = 0; col < bricksPerRow; col++) {
//         double x = brickX + col * (brickWidth + brickGap);
//         double y = brickY + row * (brickHeight + brickGap);
//         bricksList.add([x, y, false]);
//       }
//     }

//     return bricksList;
//   }

//   List<Widget> generateBricks() {
//     List<Widget> list = [];
//     for (int i = 0; i < brickList.length; i++) {
//       list.add(
//         MyBrick(
//           brickX: brickList[i][0],
//           brickY: brickList[i][1],
//           brickHeight: brickHeight,
//           brickWidth: brickWidth,
//           brickBroken: brickList[i][2],
//         ),
//       );
//     }
//     return list;
//   }

//    void resetGame() {
   
//       hasGameEnded = false;
//       hasGameStarted = false;
//       brokenBrickCounter = 0;
//       firstBrickX = -1 + wallGap;

//       scores = 0;
//       ballX = 0.0;
//       ballY = 0.0;
//       ballXdir = DIRECTION.left;
//       ballYdir = DIRECTION.down;
//       numOfBricksPerRow = 3;
//       brickWidth = 0.4;
//       brickHeight = 0.1;
//       brickGap = 0.05;
//       wallGap = 0.5 *
//           (2 -
//               numOfBricksPerRow * brickWidth -
//               (numOfBricksPerRow - 1) * brickGap);
//       playerX = -0.5 * (playerWidth);
//       brickList = generateBrickList(
//           3, 3, brickWidth, brickHeight, brickGap, firstBrickX, firstBrickY);
    
//   }

//   GameState({required this.ballX, required this.ballY});

//   // Define methods to update game state
//   void updateBall(double x, double y) {
//     ballX = x;
//     ballY = y;
//     notifyListeners();
//   }


//    //ALL FUNCTIONS :-

//   void loadDetails() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
   
//       ballSpeed = prefs.getDouble('bs') ?? 1.0;
//       playerWidth = prefs.getDouble('pw') ?? 1.0;
//       if (ballSpeed == 0.5) {
//         ballSpeed = 0.010;
//       } else if (ballSpeed == 1.0) {
//         ballSpeed = 0.016;
//       } else if (ballSpeed == 1.5) {
//         ballSpeed = 0.022;
//       }

//       if (playerWidth == 0.5) {
//         playerWidth = 0.4;
//       } else if (playerWidth == 1.0) {
//         playerWidth = 0.8;
//       } else if (playerWidth == 1.5) {
//         playerWidth = 1.2;
//       }

//       playerX = -(0.5) * playerWidth;
    
//   }

//   void startGame() {
    
//       hasGamePaused = false;
//       hasGameStarted = true;
    
//     timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      
//         //The ball must be moving constantly from the starting of the game till its over
//         //Thus, every 10 milliseconds we move the ball and uodate its DIRECTION
//         moveBall();
//         updateBallDIRECTION();

//         //We must also keep checking if the ball has hit any bricks
//         checkForBrokenBricks();
//         //If at any point of the game, the player dies, we must :
//         //  1. stop the timer,
//         //  2. update the game state booleans

//         if (isPlayerDead() || areAllBricksBroken()) {
//           timer.cancel();
          
//             hasGameEnded = true;
        
//         }
//       });
//     }
//   }

//   pauseGame() {
    
//       hasGameStarted = false;
//       hasGamePaused = true;
//       timer.cancel();

//   }

//   void checkForBrokenBricks() {
//     for (int i = 0; i < brickList.length; i++) {
//       if (ballX >= brickList[i][0] &&
//           ballX <= brickList[i][0] + brickWidth &&
//           ballY <= brickList[i][1] + brickHeight &&
//           brickList[i][2] == false &&
//           ballY >= brickList[i][1]) {
//         setState(() {
//           brickList[i][2] = true;
//           brokenBrickCounter++;
//           scores = scores + brokenBrickCounter;

//           // Play the "Brick Break" sound effect here
//         FlameAudio.play(Constants.brickBreakSound,);

//           //update ball's DIRECTION
//           //Now to do this, we must determine which side of the brick has been hit
//           // as that influences the DIRECTION in which the ball has to be reflected

//           //To do this, we can compute the distance of the ball from each side of the brick
//           //The shortest distance will correspond to the side of the brick that has been hit
//           double leftSideDist = (brickList[i][0] - ballX).abs();
//           double rightSideDist = (brickList[i][0] + brickWidth - ballX).abs();
//           double topSideDist = (brickList[i][1] - ballY).abs();
//           double bottomSideDist = (brickList[i][1] + brickHeight - ballY).abs();

//           String min = findMinDist(
//               leftSideDist, rightSideDist, topSideDist, bottomSideDist);
//           switch (min) {
//             case 'l':
//               ballXdir = DIRECTION.left;
//               break;
//             case 'r':
//               ballXdir = DIRECTION.right;
//               break;
//             case 't':
//               ballYdir = DIRECTION.up;
//               break;
//             case 'b':
//               ballYdir = DIRECTION.down;
//               break;
//           }
//         });
//       }
//     }
//   }

//   String findMinDist(double l, double r, double t, double b) {
//     double mini = l;
//     if (mini > r) mini = r;
//     if (mini > t) mini = t;
//     if (mini > b) mini = b;

//     if ((mini - l).abs() < 0.01) {
//       return 'l';
//     } else if ((mini - r).abs() < 0.01) {
//       return 'r';
//     } else if ((mini - t).abs() < 0.01) {
//       return 't';
//     } else if ((mini - b).abs() < 0.01) {
//       return 'b';
//     }

//     return '';
//   }

//   bool isPlayerDead() {
//     if (ballY > 0.94) {
//       saveScores();
//     FlameAudio.play(Constants.gameOverSound,);
      
//         endText = 'GAME OVER!';
    
//       return true;
//     }
//     return false;
//   }

//   saveScores() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final getScore = prefs.getInt('high') ?? 0;
//     if (getScore < scores) {
//       await prefs.setInt('high', scores);
//     }
//   }

//   bool areAllBricksBroken() {
//     if (brokenBrickCounter == brickList.length) {
//       FlameAudio.play(Constants.victorySound,);
//       setState(() {
//         endText = 'YOU WON!';
//       });
//       return true;
//     }
//     return false;
//   }

//   void updateBallDIRECTION() {
    
//       //Bouncing ball upwards once it hits player bar
//       if (ballX >= playerX && ballX <= playerX + playerWidth && ballY >= 0.88) {
//         ballYdir = DIRECTION.up;
//         //If the ball hits the exact edges of the player bar, we show an angle in its reflection
//         if (ballX == playerX) {
//           ballXdir = DIRECTION.left;
//         } else if (ballX == playerX + playerWidth) {
//           ballXdir = DIRECTION.right;
//         }
//         // Check the player's direction and set the ball's direction accordingly
//         if (playerDirection == PLAYERDIRECTION.left) {
//           ballXdir = DIRECTION.left;
//         } else if (playerDirection == PLAYERDIRECTION.right) {
//           ballXdir = DIRECTION.right;
//         }
//       }
//       //Bouncing ball downwards once it hits the top of the screen
//       else if (ballY <= -1) {
//         ballYdir = DIRECTION.down;
//       }
//       //Bouncing ball right if it hits the left side of the screen
//       if (ballX <= -1) {
//         ballXdir = DIRECTION.right;
//       }
//       //Bouncing ball left if it hits the right side of the screen
//       else if (ballX >= 1) {
//         ballXdir = DIRECTION.left;
//       }
//   }

//   void moveBall() {
    
//       //Vertical Movement :
//       if (ballYdir == DIRECTION.down) {
//         ballY += ballSpeed;
//       } else if (ballYdir == DIRECTION.up) {
//         ballY -= ballSpeed;
//       }

//       //Horizontal Movement :
//       if (ballXdir == DIRECTION.right) {
//         ballX += ballSpeed;
//       } else if (ballXdir == DIRECTION.left) {
//         ballX -= ballSpeed;
//       }

//   }

//   void movePlayer(double position) {
    
//       playerX = position;

//   }

//   void movePlayerleft() {
//     playerDirection = PLAYERDIRECTION.left;
//     if (playerX - playerSpeed >= -1) {
//       setState(() {
//         playerX -= playerSpeed;
//       });
//     }
//   }

//   void movePlayerright() {
//     playerDirection = PLAYERDIRECTION.right;
//     if (playerX + playerWidth + playerSpeed <= 1) {
//       setState(() {
//         playerX += playerSpeed;
//       });
//     }
//   }

//   playMusic() {
//     if (FlameAudio.bgm.isPlaying) {
//       FlameAudio.bgm.pause();
//     } else {
//       FlameAudio.bgm.play(Constants.audio1);
//     }
//   }

//   void onHorizontalDragUpdate(DragUpdateDetails details) {
//     double delta = details.delta.dx * playerSpeed * playerSpeed;

//     // Update the state of your container's position
    
//       if (delta < 0) {
//         // If delta is negative, the player board is being dragged left
//         playerDirection = PLAYERDIRECTION.left;
//       } else if (delta > 0) {
//         // If delta is positive, the player board is being dragged right
//         playerDirection = PLAYERDIRECTION.right;
//       } else {
//         // If delta is zero, the player board is stationary
//         playerDirection = PLAYERDIRECTION.stationary;
//       }
//       // Add the delta multiplied by the player speed to the initial position
//       playerX += delta * playerSpeed;

//       // Check if the container is within the screen boundaries
//       if (playerX < -1) {
//         // If it is too far left, set it to -1
//         playerX = -1;
//       } else if (playerX + playerWidth > 1) {
//         // If it is too far right, set it to 1 - playerWidth
//         playerX = 1 - playerWidth;
//       }

//       // Assign the initial position to the playerX variable
//   }

