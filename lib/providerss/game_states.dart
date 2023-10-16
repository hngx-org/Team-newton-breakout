import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/gamepage.dart';
import '../utils/constants.dart';

class GamesState extends ChangeNotifier {
  final double _ballX = 0.0;
  final double _ballY = 0.0;
  double ballSpeed = 0.022; //(0.010, 0.016, 0.022)
  DIRECTION ballXdir = DIRECTION.left;
  DIRECTION ballYdir = DIRECTION.down;
  PLAYERDIRECTION playerDirection = PLAYERDIRECTION.stationary;

  double get ballX => _ballX;
  double get ballY => _ballY;
  //  double get ballSpeed => _ballSpeed;

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

  //Player variables :-
  double playerX =
      0; // its value is -0.5 *(playerWidth) to ensure that the player bar initially remains in the centre
  double playerWidth = 0.4; // ( 0.4, 0.8, 1.2)
  double playerSpeed = 0.2;

  List<List<String>> brickColors = [];

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    double delta = details.delta.dx * playerSpeed * playerSpeed;

    // Update the state of your container's position

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
    notifyListeners();
  }

  void movePlayerleft() {
    playerDirection = PLAYERDIRECTION.left;
    if (playerX - playerSpeed >= -1) {
      playerX -= playerSpeed;
    }
    notifyListeners();
  }

  void movePlayerright() {
    playerDirection = PLAYERDIRECTION.right;
    if (playerX + playerWidth + playerSpeed <= 1) {
      playerX += playerSpeed;
    }
    notifyListeners();
  }

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

    brickColors = colors;
    notifyListeners();
  }

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
    notifyListeners();
    return bricksList;
  }

  void loadDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

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
    notifyListeners();
  }

  void initializeGame() {
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
    notifyListeners();
  }
}
