import 'package:breakout_revival/component/background.dart';
import 'package:breakout_revival/screens/gamepage.dart';
import 'package:breakout_revival/component/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _highScore = 0;

  @override
  void initState() {
    super.initState();

    checkScore();
  }

  checkScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _highScore = prefs.getInt('high') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryObject = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: BackGround(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      color: const Color(0xFF000088),
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
                          backgroundColor: const Color(0xFF000088),
                          padding: EdgeInsets.symmetric(
                            horizontal: mediaQueryObject.size.width * 0.02,
                            vertical: kIsWeb
                                ? mediaQueryObject.size.height * 0.02
                                : mediaQueryObject.size.height * 0.015,
                          )),
                      onPressed: () {
                        Navigator.of(context).pushNamed(GameScreen.route);
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
                          backgroundColor: const Color(0xFF000088),
                          padding: EdgeInsets.symmetric(
                            horizontal: mediaQueryObject.size.width * 0.02,
                            vertical: kIsWeb
                                ? mediaQueryObject.size.height * 0.02
                                : mediaQueryObject.size.height * 0.015,
                          )),
                      onPressed: () {
                        Navigator.of(context).pushNamed(SettingScreen.route);
                      },
                      child: Icon(
                        Icons.settings_rounded,
                        size: kIsWeb ? 20 : mediaQueryObject.size.height * 0.03,
                      ),
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
