import 'dart:async';
import 'package:breakout_revival/component/ball.dart';
import 'package:breakout_revival/component/bricks.dart';
import 'package:breakout_revival/component/player.dart';
import 'package:breakout_revival/screens/homepage.dart';
import 'package:breakout_revival/utils/constants.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/background.dart';
import '../providers/game_state_provider.dart';

class GameScreen extends StatefulWidget {
  static const route = '/game';

  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

final GameState gameStateClass = GameState(); 

// final MediaQuery.sizeOf(context) = MediaQuery.of(context);
  

  @override
  void initState() {
    super.initState();
   
  gameStateClass.initializeGame();
  
   // Load sound effects
    FlameAudio.audioCache.load(
      Constants.brickBreakSound,
    );
    FlameAudio.audioCache.load(Constants.gameOverSound);
    FlameAudio.audioCache.load(Constants.victorySound);
  }

  @override
  Widget build(BuildContext context) {
    final gameState = context.read<GameState>();
    // final MediaQuery.sizeOf(context) = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        if (gameState.hasGameEnded) {
          return true;
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF6666FF),
        body: RawKeyboardListener(
          focusNode: FocusNode(),
          autofocus: true,
          onKey: (event) {
            if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
              gameState.movePlayerleft();
            } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
              gameState.movePlayerright();
            }
          },

          child: BackGround(
            child: SafeArea(
              child: GestureDetector(
                onTap: gameState.hasGameStarted ? null : gameState.startGame,
                child: Center(
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 20.0.h, right: 20.w, top: 20.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    gameState.hasGameEnded ? null : gameState.pauseGame();
                                  },
                                  child: Icon(
                                    Icons.pause_circle_filled_outlined,
                                    size: 28.sp,
                                    color: const Color(0xFF3333AA),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                InkWell(
                                  onTap: () {
                                   gameState.playMusic();
                                  },
                                  
                                  child: Icon(
                                    Icons.music_note,
                                    size: 28.sp,
                                    color: const Color(0xFF3333AA),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  'Score: ${gameState.scores}',
                                  style: GoogleFonts.pressStart2p(
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //PLAYER INTERACTIVE SCREENS :
          
                      //1. Tap to Begin :-
                      Visibility(
                        visible: !gameState.hasGameStarted,
                        child: Align(
                          alignment: const Alignment(0.0, -0.2),
                          child: Text(
                            kIsWeb ? 'click to begin' : 'tap to begin',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color: const Color(0xFF3333AA),
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: gameState.hasGamePaused,
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF000088),
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.sizeOf(context).width * 0.02,
                                vertical: kIsWeb
                                    ? MediaQuery.sizeOf(context).height * 0.02
                                    : MediaQuery.sizeOf(context).height * 0.015,
                              ),
                            ),
                            onPressed: () async {
                              gameState.startGame();
                            },
                            child: Icon(
                              Icons.pause_circle_filled_outlined,
                              size: kIsWeb
                                  ? 20
                                  : MediaQuery.sizeOf(context).height * 0.03,
                              color: const Color(0xFF6666FF),
                            ),
                          ),
                        ),
                      ),
                      //2. Game Over Screen :-
                      Visibility(
                          visible: gameState.hasGameEnded,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  gameState.endText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                        fontSize: kIsWeb
                                            ? MediaQuery.sizeOf(context).width * 0.03
                                            : MediaQuery.sizeOf(context).height *
                                                0.025,
                                        color: const Color(0xFF3333AA),
                                      ),
                                ),
                                SizedBox(
                                    height: MediaQuery.sizeOf(context).height * 0.05),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF000088),
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              MediaQuery.sizeOf(context).width * 0.02,
                                          vertical: kIsWeb
                                              ? MediaQuery.sizeOf(context).height *
                                                  0.02
                                              : MediaQuery.sizeOf(context).height *
                                                  0.015,
                                        ),
                                      ),
                                      onPressed: gameState.resetGame,
                                      child: Icon(
                                        Icons.replay,
                                        size: kIsWeb
                                            ? 20
                                            : MediaQuery.sizeOf(context).height * 0.03,
                                        color: const Color(0xFF6666FF),
                                      ),
                                    ),
                                    Visibility(
                                      visible: gameState.areAllBricksBroken(),
                                      child: SizedBox(
                                        width: MediaQuery.sizeOf(context).width * 0.03,
                                      ),
                                    ),
                                    Visibility(
                                      visible: gameState.areAllBricksBroken(),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF000088),
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                MediaQuery.sizeOf(context).width *
                                                    0.02,
                                            vertical: kIsWeb
                                                ? MediaQuery.sizeOf(context).height *
                                                    0.02
                                                : MediaQuery.sizeOf(context).height *
                                                    0.015,
                                          ),
                                        ),
                                        onPressed: () async {
          
                                          gameState.nextLevel(gameState.initialLevel + 1);
                                          
                                        },
                                        child: Icon(
                                          Icons.fast_forward_rounded,
                                          size: kIsWeb
                                              ? 20
                                              : MediaQuery.sizeOf(context).height *
                                                  0.03,
                                          color: const Color(0xFF6666FF),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width * 0.03,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF000088),
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                MediaQuery.sizeOf(context).width *
                                                    0.02,
                                            vertical: kIsWeb
                                                ? MediaQuery.sizeOf(context).height *
                                                    0.02
                                                : MediaQuery.sizeOf(context).height *
                                                    0.015,
                                          )),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                HomeScreen.route,
                                                (route) => false);
                                      },
                                      child: Icon(
                                        Icons.home_outlined,
                                        size: kIsWeb
                                            ? 20
                                            : MediaQuery.sizeOf(context).height * 0.03,
                                        color: const Color(0xFF6666FF),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
          
                      //BALL
          
                      Ball(
                        ballX: gameState.ballX,
                        ballY: gameState.ballY,
                        hasGameEnded: gameState.hasGameEnded,
                      ),
          
                      //PLAYER
                      MyPlayer(
                        onHorizontalDragUpdate: gameState.onHorizontalDragUpdate,
                        playerX: gameState.playerX,
                        playerWidth: gameState.playerWidth,
                      ),
          
                      //BRICKS
                      ...gameState.generateBricks(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}