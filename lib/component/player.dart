import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPlayer extends StatelessWidget {
  final double? playerX;
  final double? playerWidth; //out of 2
  final void Function(DragUpdateDetails)? onHorizontalDragUpdate;

  const MyPlayer(
      {super.key, this.playerX, this.playerWidth, this.onHorizontalDragUpdate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      child: Container(
          margin: EdgeInsets.only(top: 10.h),
          //alignment: Alignment(playerX, 0.9),
          alignment: Alignment(
              (2 * playerX! + playerWidth!) / (2 - playerWidth!), 0.9),
          child: Container(
            width: MediaQuery.of(context).size.width *
                playerWidth! /
                2, // Adjust width to your requirements
            height: 25.h, // Adjust height to your requirements
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(10), // Adjust the border radius
              color: Colors.blue, // Change the color to your preference
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.4), // Adjust shadow color and opacity
                  spreadRadius: 1, // Adjust the spread radius
                  blurRadius: 5, // Adjust the blur radius
                  offset: const Offset(0, 3), // Adjust the shadow offset
                ),
              ],
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF6666FF),
                  Color(0xFF3333AA),
                  Color(0xFF000088)
                ],
              ),
            ),
          )),
    );
  }
}
