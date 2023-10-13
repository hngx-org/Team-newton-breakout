import 'package:breakout_revival/screens/gamepage.dart';
import 'package:breakout_revival/screens/homepage.dart';
import 'package:breakout_revival/component/settings.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.route,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.tealAccent.shade700,
        primaryColor: Colors.tealAccent.shade700,
        cardColor: const Color(0xFFDFF3E8),
        textTheme: TextTheme(
            displayLarge: TextStyle(
              color: Colors.tealAccent.shade100,
              fontFamily: 'Press_Start_2P',
            ),
            displayMedium: const TextStyle(
              fontFamily: 'Amaranth',
              color: Color(0xFFDFF3E8),
            )),
      ),
      routes: {
        HomeScreen.route: (context) => const HomeScreen(),
        GameScreen.route: (context) => const GameScreen(),
        SettingScreen.route: (context) => const SettingScreen(),
      },
    );
  }
}

/*
  CHALLENGES : 
  1. Difficulty in Moving Player : 
  => Resolved through use of keyboard in desktop. 
      Have to work on dragging the scroll on mobile.

  2. How to maintain

*/