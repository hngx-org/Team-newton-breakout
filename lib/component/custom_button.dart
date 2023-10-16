import 'package:breakout_revival/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color textColor;
  final bool isPressed;
  final List<String> images;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.textColor = Colors.white,
    required this.isPressed,
    required this.images, // Default text color
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: 200.w,
        height: 100.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isPressed ? images[1] : images[0],
            ),
          ),
        ),
        child: Ink.image(
          image: const AssetImage(Constants.deepBlueBrickPath),
          child: InkWell(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: GoogleFonts.pressStart2p(
                  color: textColor,
                  fontSize: 14.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
