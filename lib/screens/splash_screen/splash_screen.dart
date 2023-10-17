import 'package:breakout_revival/screens/auth.dart';
import 'package:breakout_revival/screens/homepage.dart';
import 'package:breakout_revival/utils/game_services/game_service.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late FlameSplashController _controller;
  final GameService gameService = GameService();
  bool isSignedIn = false;

  @override
  void initState() {
    super.initState();

    _controller = FlameSplashController();
    checkIfSignedIn();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  navigateToHome() {
    Navigator.of(context).pushNamed(HomeScreen.route);
  }

  navigateToAuth() {
    Navigator.of(context).pushNamed(AuthScreen.route);
  }

  checkIfSignedIn() async {
    isSignedIn = await gameService.isSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlameSplashScreen(
        onFinish: (context) async {
          if (isSignedIn) {
            navigateToHome();
          } else {
            navigateToAuth();
          }
        },
        theme: FlameSplashTheme.dark,
        showBefore: (context) => SizedBox(
          width: double.infinity,
          height: 200.h,
          child: Image.asset("assets/png/hng-logo.png"),
        ),
        controller: _controller,
        showAfter: (context) => Text(
          'Breakout\nRevival',
          style: GoogleFonts.pressStart2p(
            fontSize: 24.sp,
          ),
        ),
      ),
    );
  }
}
