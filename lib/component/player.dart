import 'package:flutter/material.dart';

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
        //alignment: Alignment(playerX, 0.9),
        alignment:
            Alignment((2 * playerX! + playerWidth!) / (2 - playerWidth!), 0.9),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.teal,
          ),
          height: 15,
          width: MediaQuery.of(context).size.width * playerWidth! / 2,
        ),
      ),
    );
  }
}
