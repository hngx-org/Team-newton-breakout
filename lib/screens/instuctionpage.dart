import 'package:flutter/material.dart';
import 'package:breakout_revival/utils/constants.dart';

class InstructionsScreen extends StatelessWidget {
  static const route = '/instructions';

  const InstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF6666FF),
        title: const Text('Instructions'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'How to Play:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              '1. Move the paddle left and right to bounce the ball.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '2. Break all the bricks to win the game.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '3. Don\'t let the ball fall off the screen.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
