import 'package:flutter/material.dart';

class StageDesignCircle extends StatelessWidget {
  final double size;
  final Color color;
  final int rings;
  final double ringSpacing;

  const StageDesignCircle({
    super.key,
    this.size = 400,
    this.color = const Color(0xFFBA4A2C), // your red-brown tone
    this.rings = 4,
    this.ringSpacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(rings, (index) {
          double ringSize = size - (index * ringSpacing);

          return Container(
            width: ringSize,
            height: ringSize,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 25,
                  spreadRadius: -5,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}