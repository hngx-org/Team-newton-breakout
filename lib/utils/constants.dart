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
  static const String smallPlayerPath = '$pngPath/player-small.png';
  static const String bigPlayerPath = '$pngPath/player-big.png';

  static const String bg1Path = '$jpgPath/bg1.jpeg';
  static const String bg2Path = '$jpgPath/bg2.jpeg';
  static const String bg3Path = '$jpgPath/bg3.jpeg';

  static const String audio1 = 'music1.ogg';
  static const String audio2 = 'music2.ogg';

  static const ballRadius = 10.0;

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
