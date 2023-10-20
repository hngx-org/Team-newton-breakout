import 'package:breakout_revival/utils/game_services/game_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:breakout_revival/component/background.dart';
import 'package:breakout_revival/utils/constants.dart';
import 'package:breakout_revival/screens/homepage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:breakout_revival/component/custom_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatefulWidget {
  static const route = '/auth';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GameService gameService = GameService();
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
                icon: Icons.login_outlined,
                label: "Sign In",
                onPressed: () async {
                  setState(() {
                    isPressed[0] = true;
                  });
                  await playAudio();

                  try {
                    // final logins = await gameService.signIn();
                    final googleUser =
                        await GoogleSignIn(signInOption: SignInOption.standard)
                            .signIn();

                    final googleAuth = await googleUser?.authentication;

                    if (googleAuth != null) {
                      // Create a new credential
                      final credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth.accessToken,
                        idToken: googleAuth.idToken,
                      );

                      // Once signed in, return the UserCredential

                      await _auth.signInWithCredential(credential);
                      await navigateToHome();
                    } else {
                      showSnack();
                    }
                  } on Exception {
                    showSnack();
                  }

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
                    icon: Icons.person_2_outlined,
                    label: "Guest",
                    onPressed: () async {
                      setState(() {
                        isPressed[1] = true;
                      });
                      await playAudio();

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

  showSnack() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Error signing in. Sign in as Guest instead')),
    );
  }

  playAudio() async {
    FlameAudio.play(Constants.brickBreakSound);
  }

  navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1200), () async {
      await Navigator.of(context).pushNamed(HomeScreen.route);
    });
  }
}
