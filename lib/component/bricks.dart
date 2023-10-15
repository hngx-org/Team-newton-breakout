import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final double brickX;
  final double brickY;
  final double brickHeight;
  final double brickWidth;
  final bool brickBroken;
  final bool brickCracked;
  final int numberOfBricksPerRow;
  final List brick;
  const MyBrick({
    super.key,
    required this.brickX,
    required this.brickY,
    required this.brickHeight,
    required this.brickWidth,
    required this.brickBroken,
    required this.numberOfBricksPerRow,
    required this.brickCracked,
    required this.brick,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: brickBroken ? 0.0 : 1.0,
      child: Container(
        alignment:
            Alignment((2 * brickX + brickWidth) / (2 - brickWidth), brickY),
        child: SizedBox(
          height: (MediaQuery.of(context).size.height * brickHeight) / 2,
          width: (MediaQuery.of(context).size.width * brickWidth) / 2,
          child: Image.asset(
            brickCracked ? brick[1] : brick[0],
          ),
        ),
      ),
    );
  }
}
