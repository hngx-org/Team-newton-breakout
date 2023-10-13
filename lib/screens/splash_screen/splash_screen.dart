import 'package:breakout_revival/screens/homepage.dart';
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

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlameSplashScreen(
        onFinish: (context) =>
            Navigator.of(context).pushNamed(HomeScreen.route),
        theme: FlameSplashTheme.dark,
        showBefore: (context) => SizedBox(
          width: double.infinity,
          height: 200.h,
          child: Image.asset("assets/png/hng-logo.png"),
        ),
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
