import 'package:breakout_revival/component/custom_button.dart';
import 'package:breakout_revival/screens/gamepage.dart';
import 'package:flutter/material.dart';
import 'package:breakout_revival/component/background.dart';
import 'package:breakout_revival/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LevelScreen extends StatefulWidget {
  static const route = '/levels';

  const LevelScreen({super.key});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
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
  List<bool> isPressed = [
    false,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGround(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Choose Level",
                style: GoogleFonts.pressStart2p(
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              // Row for levels 1, 2, and 3
              CustomButton(
                icon: Icons.lock_open_rounded,
                label: "Level 1",
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(GameScreen.route);
                },
                isPressed: isPressed[0],
                images: bricks[6],
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomButton(
                label: "Level 2",
                onPressed: () {},
                icon: Icons.lock,
                textColor: Colors.white,
                isPressed: isPressed[1],
                images: bricks[4],
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomButton(
                label: "Level 3",
                onPressed: () {},
                icon: Icons.lock,
                textColor: Colors.white,
                isPressed: isPressed[2],
                images: bricks[9],
              ),

              SizedBox(
                height: 15.h,
              ),

              // Row for levels 4, 5, and 6
              CustomButton(
                icon: Icons.lock,
                label: "Level 4",
                onPressed: () {},
                textColor: Colors.white,
                isPressed: isPressed[3],
                images: bricks[3],
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
