import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:breakout_revival/component/background.dart';
import 'package:breakout_revival/utils/constants.dart';
import 'package:breakout_revival/screens/homepage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:breakout_revival/component/custom_button.dart';

class AuthScreen extends StatefulWidget {
  static const route = '/auth';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  List<bool> isPressed = [false, false];
  @override
  void initState() {
    super.initState();
    FlameAudio.audioCache.load(Constants.brickBreakSound);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGround(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                label: "Sign In",
                onPressed: () async {
                  setState(() {
                    isPressed[0] = true;
                  });
                  await FlameAudio.bgm.play(Constants.brickBreakSound);

                  await navigateToHome();
                  setState(() {
                    isPressed[0] = false;
                  });
                  // Handle Sign In button click
                },
                // Set a custom background color
                textColor: Colors.white,
                isPressed: isPressed[0],
                images: const [
                  Constants.deepBlueBrickPath,
                  Constants.deepBlueCrackedBrickPath,
                ], // Set a custom text color
              ),
              SizedBox(
                height: 10.h,
              ), // Add spacing between buttons
              Stack(
                alignment: Alignment.center,
                children: [
                  CustomButton(
                    label: "Guest",
                    onPressed: () async {
                      setState(() {
                        isPressed[1] = true;
                      });
                      await FlameAudio.bgm.play(Constants.brickBreakSound);
                      await navigateToHome();

                      setState(() {
                        isPressed[1] = false;
                      });
                      // Handle Sign In button click
                    },

                    // Set a custom background color
                    textColor: Colors.white,
                    isPressed: isPressed[1],
                    images: const [
                      Constants.deepGreenBrickPath,
                      Constants.deepGreenCrackedBrickPath,
                    ], // Set a custom text color
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  navigateToHome() async {
    await Navigator.of(context).pushNamed(HomeScreen.route);
  }
}
