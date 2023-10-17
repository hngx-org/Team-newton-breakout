import 'package:breakout_revival/component/background.dart';
import 'package:breakout_revival/component/custom_button.dart';
import 'package:breakout_revival/screens/gamepage.dart';
import 'package:breakout_revival/component/settings.dart';
import 'package:breakout_revival/screens/instuctionpage.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _highScore = 0;
  List<bool> isPressed = [
    false,
    false,
    false,
    false,
  ];
  bool _isBgMusicPlaying = true;
  @override
  void initState() {
    super.initState();
    FlameAudio.audioCache.load(
      Constants.audio3,
    );
    FlameAudio.audioCache.load(
      Constants.brickBreakSound,
    );
    checkScore();
    playMusic();
  }

  checkScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _highScore = prefs.getInt('high') ?? 0;
    });
  }

  void playMusic() {
    setState(() {
      if (FlameAudio.bgm.isPlaying) {
        FlameAudio.bgm.pause();
        setState(() {
          _isBgMusicPlaying = false;
        });
      } else {
        FlameAudio.bgm.play(
          Constants.audio3,
        );
        setState(() {
          _isBgMusicPlaying = true;
        });
      }
    });
  }

  navigateToScreen(String route) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      await Navigator.of(context).pushNamed(route);
    });
  }

  void playAudio() {
    FlameAudio.play(Constants.brickBreakSound);
  }

  void stopMusic() {
    if (FlameAudio.bgm.isPlaying) {
      FlameAudio.bgm.stop();
    }
  }

  @override
  void dispose() {
    playMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryObject = MediaQuery.of(context);
    return Scaffold(
      body: BackGround(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'High Score: $_highScore',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(
                    height: mediaQueryObject.size.height * 0.07,
                  ),
                  Text(
                    kIsWeb
                        ? 'B R I C K - B R E A K E R'
                        : 'B R I C K \n\nB R E A K E R',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: const Color(0xFF8cc63f),
                        fontSize: kIsWeb
                            ? mediaQueryObject.size.width * 0.035
                            : mediaQueryObject.size.height * 0.025),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: mediaQueryObject.size.height * 0.07,
                  ),
                  CustomButton(
                    onPressed: () async {
                      setState(() {
                        isPressed[0] = true;
                      });
                      playAudio();
                      stopMusic();

                      await navigateToScreen(GameScreen.route);
                      checkScore();
                      stopMusic();
                      playMusic();
                      setState(() {
                        isPressed[0] = false;
                      });
                    },
                    label: 'Play',
                    isPressed: isPressed[0],
                    images: const [
                      Constants.lightBlueBrickPath,
                      Constants.lightBlueCrackedBrickPath
                    ],
                    icon: Icons.play_arrow_rounded,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomButton(
                    onPressed: () async {
                      setState(() {
                        isPressed[1] = true;
                      });
                      playAudio();
                      // Play or pause music based on its current state
                      await navigateToScreen(SettingScreen.route);
                      setState(() {
                        isPressed[1] = false;
                      });
                    },
                    icon: Icons.settings,
                    label: 'Settings',
                    isPressed: isPressed[1],
                    images: const [
                      Constants.orangeBrickPath,
                      Constants.orangeCrackedBrickPath,
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomButton(
                    onPressed: () async {
                      setState(() {
                        isPressed[2] = true;
                      });
                      playAudio();
                      // Play or pause music based on its current state
                      await navigateToScreen(InstructionsScreen.route);
                      setState(() {
                        isPressed[2] = false;
                      });
                    },
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    icon: Icons.info_outlined,
                    isPressed: isPressed[2],
                    label: 'How to play',
                    images: const [
                      Constants.purpleBrickPath,
                      Constants.purpleCrackedBrickPath
                    ],
                  ),
                ],
              ),
              Positioned(
                bottom: 2.h,
                left: 0,
                child: InkWell(
                  onTap: () {
                    // Play or pause music based on its current state
                    playMusic();
                  },
                  child: Icon(
                    _isBgMusicPlaying ? Icons.music_note : Icons.music_off,
                    color: Colors.white,
                    size: 32.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
