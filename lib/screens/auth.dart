import 'package:flutter/material.dart';
import 'package:breakout_revival/component/background.dart';
import 'package:breakout_revival/utils/constants.dart';
import 'package:breakout_revival/screens/homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:breakout_revival/component/customButton.dart';

class AuthScreen extends StatelessWidget {
  static const route = '/auth';

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
                onPressed: () {
                  // Handle Sign In button click
                },
                backgroundColor: Colors.brown, // Set a custom background color
                textColor: Colors.white, // Set a custom text color
              ),
              SizedBox(height: 20), // Add spacing between buttons
              Stack(
                alignment: Alignment.center,
                children: [
                  CustomButton(
                    label: "Continue as guest",
                    onPressed: () {
                      // Handle Sign In button click
                    },
                    backgroundColor: 
                        Colors.brown, // Set a custom background color
                    textColor: Colors.white, // Set a custom text color
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
