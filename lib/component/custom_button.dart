import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color textColor;
  final bool isPressed;
  final List<String> images;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.textColor = Colors.white,
    required this.isPressed,
    required this.images,
    this.icon,
    this.padding, // Default text color3
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: padding,
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
        child: InkWell(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  label,
                  style: GoogleFonts.pressStart2p(
                    color: textColor,
                    fontSize: 14.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
