import 'package:flutter/material.dart';

enum BallState {
  ideal,
  drag,
  release,
  completed,
}

class Constants {
  static const String pngPath = 'assets/png';
  static const String jpgPath = 'assets/jpg';
  static const String audioPath = 'assets/audio';
  static const String ballPath = '$pngPath/ball.png';

  static const String lightGreenBrickPath = '$pngPath/light-green-tiles.png';
  static const String lightGreenCrackedBrickPath =
      '$pngPath/light-green-cracked-tiles.png';
  static const String brownBrickPath = '$pngPath/brown-tiles.png';
  static const String brownCrackedBrickPath =
      '$pngPath/brown-cracked-tiles.png';
  static const String deepBlueBrickPath = '$pngPath/deep-blue-tiles.png';
  static const String deepBlueCrackedBrickPath =
      '$pngPath/deep-blue-cracked-tiles.png';
  static const String deepGreenBrickPath = '$pngPath/deep-green-tiles.png';
  static const String deepGreenCrackedBrickPath =
      '$pngPath/deep-green-cracked-tiles.png';
  static const String greyBrickPath = '$pngPath/grey-tiles.png';
  static const String greyCrackedBrickPath = '$pngPath/grey-cracked-tiles.png';
  static const String lightBlueBrickPath = '$pngPath/light-blue-tiles.png';
  static const String lightBlueCrackedBrickPath =
      '$pngPath/light-blue-cracked-tiles.png';
  static const String orangeBrickPath = '$pngPath/orange-tiles.png';
  static const String orangeCrackedBrickPath =
      '$pngPath/orange-cracked-tiles.png';
  static const String purpleBrickPath = '$pngPath/purple-tiles.png';
  static const String purpleCrackedBrickPath =
      '$pngPath/purple-cracked-tiles.png';
  static const String redBrickPath = '$pngPath/red-tiles.png';
  static const String redCrackedbrickPath = '$pngPath/red-cracked-tiles.png';
  static const String yellowBrickPath = '$pngPath/yellow-tiles.png';
  static const String yellowCrackedbrickPath =
      '$pngPath/yellow-cracked-tiles.png';

  static const String brickPath = '$pngPath/tiles.png';
  static const String crackedBrickPath = '$pngPath/cracked-tiles.png';
  static const String smallPlayerPath = '$pngPath/player-small.png';
  static const String bigPlayerPath = '$pngPath/player-big.png';

  static const String bg1Path = '$jpgPath/bg1.jpeg';
  static const String bg2Path = '$jpgPath/bg2.jpeg';
  static const String bg3Path = '$jpgPath/bg3.jpeg';

  static const String audio1 = 'music1.ogg';
  static const String audio2 = 'music2.ogg';
  static const String audio3 = 'music3.ogg';
  static const String brickBreakSound = 'brick.ogg';
  static const String victorySound = 'succes.ogg';
  static const String gameOverSound = 'failure.ogg';

  static const ballRadius = 8.0;

  static const ballColor = 0xFFFFFFFF;

  static const brickColor = 0xFF24998B;
  static const brickFontColor = 0xFFFFFFFF;
  static const brickFontSize = 20.0;

  static const numberOfBricksInRow = 7;
  static const brickPadding = 8;
  static const maxValueOfBrick = 10;
  static const minValueOfBrick = -5;

  static const panelColor = 0xFF1B1B1B;

  static const Color startButtonColor = Color.fromRGBO(235, 32, 93, 1);
  static const Color continueButtonColor = Color.fromRGBO(235, 32, 93, 1);
  static const Color restartButtonColor = Color.fromRGBO(243, 181, 45, 1);

  static const String gameTitle = 'The BricksBreaker Game';

  static const String brickRowRemoverText = '💣';
  static const String brickColumnRemoverText = '🧨';
  static const double powerUpProbability = 15;

  static const String brickRowRemoverAudio = 'row_explosion.mp3';
  static const String brickColumnRemoverAudio = 'column_explosion.mp3';
  static const String ballAudio = 'ball.mp3';
}
