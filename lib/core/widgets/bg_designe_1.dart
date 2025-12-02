import '../design/circle_design.dart';
import 'package:flutter/material.dart';

class BgDesign1 extends StatelessWidget {
  const BgDesign1({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -320, // move outside the screen
          left: -120,
          child: StageDesignCircle(
            size: 500,
            color: Color(0xFFE82925),
            rings: 4,
            ringSpacing: 75,
          ),
        ),
        Positioned(
          top: 760, // move outside the screen
          left: 120,
          child: StageDesignCircle(
            size: 500,
            color: Color(0xFFE82925),
            rings: 4,
            ringSpacing: 75,
          ),
        ),
      ],
    );
  }
}
