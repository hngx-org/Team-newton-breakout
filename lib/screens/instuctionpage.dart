import 'package:breakout_revival/component/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructionsScreen extends StatelessWidget {
  static const route = '/instructions';

  const InstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGround(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 20.h,
              ),
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.4,
              decoration: BoxDecoration(
                  color: const Color(0xFF8cc63f).withOpacity(.2),
                  borderRadius: BorderRadius.circular(25.r)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'How to Play:',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 24.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    '1. Move the paddle left and right to bounce the ball.',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 14.sp,
                      height: 1.5.h,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    '2. Break all the bricks to win the game.',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 14.sp,
                      height: 1.5.h,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    '3. Don\'t let the ball fall off the screen.',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 14.sp,
                      height: 1.5.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
