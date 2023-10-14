import 'package:breakout_revival/utils/constants.dart';
import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final double brickX;
  final double brickY;
  final double brickHeight;
  final double brickWidth;
  final bool brickBroken;
  final int numberOfBricksPerRow;
  const MyBrick({
    super.key,
    required this.brickX,
    required this.brickY,
    required this.brickHeight,
    required this.brickWidth,
    required this.brickBroken,
    required this.numberOfBricksPerRow,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: brickBroken ? 0.0 : 1.0,
      child: Container(
        alignment:
            Alignment((2 * brickX + brickWidth) / (2 - brickWidth), brickY),
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              Constants.brickPath,
            ),
            fit: BoxFit.cover,
          )),
          height: MediaQuery.of(context).size.height *
              brickHeight /
              numberOfBricksPerRow,
          width: MediaQuery.of(context).size.width *
              brickWidth /
              numberOfBricksPerRow,
        ),
      ),
    );
  }
}
