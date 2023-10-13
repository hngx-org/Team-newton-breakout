import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final double brickX;
  final double brickY;
  final double brickHeight;
  final double brickWidth;
  final bool brickBroken;

  const MyBrick({
    super.key,
    required this.brickX,
    required this.brickY,
    required this.brickHeight,
    required this.brickWidth,
    required this.brickBroken,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: brickBroken ? 0.0 : 1.0,
      child: Container(
        alignment:
            Alignment((2 * brickX + brickWidth) / (2 - brickWidth), brickY),
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(5), // Adjust this for rounded edges
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFDD4422), Color(0xFFBB3311), Color(0xFF880000)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.3), // Adjust shadow color and opacity
                blurRadius: 3, // Adjust the blur radius
                spreadRadius: 1, // Adjust the spread radius
                offset: const Offset(0, 2), // Adjust shadow offset
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height * brickHeight / 2,
          width: MediaQuery.of(context).size.width * brickWidth / 2,
        ),
      ),
    );
  }
}
