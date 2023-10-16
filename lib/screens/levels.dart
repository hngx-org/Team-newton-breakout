import 'package:flutter/material.dart';
import 'package:breakout_revival/component/background.dart';
import 'package:breakout_revival/utils/constants.dart';
import 'package:breakout_revival/screens/homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:breakout_revival/component/customButton.dart';

class LevelScreen extends StatelessWidget {
  static const route = '/levels';

  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGround(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row for levels 1, 2, and 3
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    label: "Level 1",
                    onPressed: () {},
                    backgroundColor: Colors.brown,
                    textColor: Colors.white,
                  ),
                  const SizedBox(width: 20),
                  CustomButton(
                    label: "Level 2",
                    onPressed: () {},
                    backgroundColor: Colors.brown,
                    textColor: Colors.white,
                  ),
                  const SizedBox(width: 20),
                  CustomButton(
                    label: "Level 3",
                    onPressed: () {},
                    backgroundColor: Colors.brown,
                    textColor: Colors.white,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Row for levels 4, 5, and 6
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    label: "Level 4",
                    onPressed: () {},
                    backgroundColor: Colors.brown,
                    textColor: Colors.white,
                  ),
                  const SizedBox(width: 20),
                  CustomButton(
                    label: "Level 5",
                    onPressed: () {},
                    backgroundColor: Colors.brown,
                    textColor: Colors.white,
                  ),
                  const SizedBox(width: 20),
                  CustomButton(
                    label: "Level 6",
                    onPressed: () {},
                    backgroundColor: Colors.brown,
                    textColor: Colors.white,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Row for levels 7, 8, and 9
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    label: "Level 7",
                    onPressed: () {},
                    backgroundColor: Colors.brown,
                    textColor: Colors.white,
                  ),
                  const SizedBox(width: 20),
                  CustomButton(
                    label: "Level 8",
                    onPressed: () {},
                    backgroundColor: Colors.brown,
                    textColor: Colors.white,
                  ),
                  const SizedBox(width: 20),
                  CustomButton(
                    label: "Level 9",
                    onPressed: () {},
                    backgroundColor: Colors.brown,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
