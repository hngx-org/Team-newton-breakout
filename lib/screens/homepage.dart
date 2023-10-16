import 'package:breakout_revival/component/background.dart';
import 'package:breakout_revival/screens/gamepage.dart';
import 'package:breakout_revival/component/settings.dart';
import 'package:breakout_revival/screens/instuctionpage.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/game_state_provider.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final gameState = GameState(); 

  @override
  void initState() {
    super.initState();
    FlameAudio.audioCache.load(
      Constants.audio3,
    );
    gameState.checkScore();
    gameState.playMusic();
  }

  

  @override
  void dispose() {
    gameState.playMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryObject = MediaQuery.of(context);
    
    final gameState = Provider.of<GameState>(context);
    return SafeArea(
      child: Scaffold(
        body: BackGround(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'High Score: ${gameState.highScore}',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8cc63f),
                          padding: EdgeInsets.symmetric(
                            horizontal: mediaQueryObject.size.width * 0.02,
                            vertical: kIsWeb
                                ? mediaQueryObject.size.height * 0.02
                                : mediaQueryObject.size.height * 0.015,
                          )),
                      onPressed: () async {
                        gameState.stopMusic();
                        await Navigator.of(context).pushNamed(GameScreen.route);
                        gameState.checkScore();
                        gameState.stopMusic();
                        gameState.playMusic();
                      },
                      child: Icon(
                        Icons.play_arrow_rounded,
                        size: kIsWeb ? 20 : mediaQueryObject.size.height * 0.03,
                      ),
                    ),
                    SizedBox(
                      width: mediaQueryObject.size.width * 0.03,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8cc63f),
                        padding: EdgeInsets.symmetric(
                          horizontal: mediaQueryObject.size.width * 0.02,
                          vertical: kIsWeb
                              ? mediaQueryObject.size.height * 0.02
                              : mediaQueryObject.size.height * 0.015,
                        ),
                      ),
                      onPressed: () {
                        // Play or pause music based on its current state
                        Navigator.of(context).pushNamed(SettingScreen.route);
                      },
                      child: Icon(
                        Icons.settings,
                        size: kIsWeb ? 20 : mediaQueryObject.size.height * 0.03,
                      ),
                    ),
                    SizedBox(
                      width: mediaQueryObject.size.width * 0.02,
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaQueryObject.size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8cc63f),
                        padding: EdgeInsets.symmetric(
                          horizontal: mediaQueryObject.size.width * 0.02,
                          vertical: kIsWeb
                              ? mediaQueryObject.size.height * 0.02
                              : mediaQueryObject.size.height * 0.015,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(InstructionsScreen.route);
                      },
                      child: Icon(
                        Icons.info_outlined,
                        size: kIsWeb ? 20 : mediaQueryObject.size.height * 0.03,
                      ),
                    ),
                    SizedBox(
                      width: mediaQueryObject.size.width * 0.03,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8cc63f),
                        padding: EdgeInsets.symmetric(
                          horizontal: mediaQueryObject.size.width * 0.02,
                          vertical: kIsWeb
                              ? mediaQueryObject.size.height * 0.02
                              : mediaQueryObject.size.height * 0.015,
                        ),
                      ),
                      onPressed: () {
                        // Play or pause music based on its current state
                        FlameAudio.bgm.isPlaying ? gameState.pauseMusic() : gameState.playMusic();
                      },
                      child: Icon(
                        FlameAudio.bgm.isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_filled,
                        size: kIsWeb ? 20 : mediaQueryObject.size.height * 0.03,
                      ),
                    ),
                    SizedBox(
                      width: mediaQueryObject.size.width * 0.02,
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaQueryObject.size.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
