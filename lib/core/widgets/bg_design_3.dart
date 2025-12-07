import '../design/circle_design.dart';
import 'package:flutter/material.dart';

class BgDesign3 extends StatelessWidget {
  const BgDesign3({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 700, // move outside the screen
          left: -30,
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
