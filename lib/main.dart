import 'package:breakout_revival/screens/gamepage.dart';
import 'package:breakout_revival/screens/homepage.dart';
import 'package:breakout_revival/component/settings.dart';
import 'package:breakout_revival/screens/splash_screen/splash_screen.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411.4, 868.6),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: SplashScreen.route,
            theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: const Color(0xFF6666FF),
              primaryColor: const Color(0xFF3333AA),
              cardColor: const Color(0xFFDFF3E8),
              textTheme: const TextTheme(
                  displayLarge: TextStyle(
                    color: Color(0xFF000088),
                    fontFamily: 'Press_Start_2P',
                  ),
                  displayMedium: TextStyle(
                    fontFamily: 'Amaranth',
                    color: Color(0xFFDFF3E8),
                  )),
            ),
            routes: {
              SplashScreen.route: (context) => const SplashScreen(),
              HomeScreen.route: (context) => const HomeScreen(),
              GameScreen.route: (context) => const GameScreen(),
              SettingScreen.route: (context) => const SettingScreen(),
            },
          );
        });
  }
}

/*
  CHALLENGES : 
  1. Difficulty in Moving Player : 
  => Resolved through use of keyboard in desktop. 
      Have to work on dragging the scroll on mobile.

  2. How to maintain

*/