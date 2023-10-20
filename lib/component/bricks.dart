import 'dart:async';

import 'package:flutter/material.dart';

class MyBrick extends StatefulWidget {
  final double brickX;
  final double brickY;
  final double brickHeight;
  final double brickWidth;
  final bool brickBroken;
  final bool brickCracked;
  final int numberOfBricksPerRow;
  final bool hasPowerUp;
  final List<String> brick;
  final String? powerUpType;

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
    required this.hasPowerUp,
    this.powerUpType,
  });

  @override
  State<MyBrick> createState() => _MyBrickState();
}

class _MyBrickState extends State<MyBrick> {
  int currentAnimationFrame = 0; // Initialize with the first frame
  List<String> spriteFrames = [];
  bool animationPlaying = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      for (int i = 0; i <= 9; i++) {
        spriteFrames.add('assets/particle/frame000$i.png');
      }
      for (int i = 10; i <= 70; i++) {
        spriteFrames.add('assets/particle/frame00$i.png');
      }
    });
  }

  @override
  void didUpdateWidget(covariant MyBrick oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.brickBroken && !animationPlaying) {
      // Start the animation when brickBroken is true
      _startAnimation();
    }
  }

  // Function to start the animation
  void _startAnimation() {
    if (animationPlaying) return;

    setState(() {
      animationPlaying = true;
    });
    _playAnimationFrame();

    // Play the animation frames
  }

  // Function to play each animation frame
  void _playAnimationFrame() {
    final int totalFrames = spriteFrames.length;
    animationPlaying = true;

    // Start a timer to play the animation
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!mounted) {
        timer.cancel(); // Cancel the timer if the widget is not mounted
        return;
      }

      setState(() {
        if (currentAnimationFrame < totalFrames - 1) {
          currentAnimationFrame++;
        } else {
          // Animation finished
          animationPlaying = false;
          timer.cancel(); // Stop the timer
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible: !widget.brickBroken,
          child: Container(
            alignment: Alignment(
              (2 * widget.brickX + widget.brickWidth) / (2 - widget.brickWidth),
              widget.brickY,
            ),
            child: SizedBox(
              height:
                  (MediaQuery.of(context).size.height * widget.brickHeight) / 2,
              width:
                  (MediaQuery.of(context).size.width * widget.brickWidth) / 2,
              child: Image.asset(
                widget.brickCracked ? widget.brick[1] : widget.brick[0],
              ),
            ),
          ),
        ),
        Visibility(
          visible: widget.brickBroken && animationPlaying,
          child: Container(
            alignment: Alignment(
              (2 * widget.brickX + widget.brickWidth) / (2 - widget.brickWidth),
              widget.brickY,
            ),
            child: SizedBox(
              height: (MediaQuery.of(context).size.height * widget.brickHeight),
              width:
                  (MediaQuery.of(context).size.width * widget.brickWidth) / 2,
              child: Image.asset(spriteFrames[currentAnimationFrame]),
            ),
          ),
        ),
      ],
    );
  }
}
