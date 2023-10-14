import 'package:breakout_revival/utils/constants.dart';
import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  final Widget child;
  const BackGround({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Constants.bg2Path,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
