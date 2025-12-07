import 'package:flutter/material.dart';
import '../../../core/widgets/bg_design_3.dart';

class AddCategories extends StatelessWidget {
  const AddCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      body: Stack(
        children: [
          Positioned.fill(child: BgDesign3()),
          // Your main content
          const Center(
            child: Text(
              'Create New Categories',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Helvetica',
              ),
            ),
          ),
          // Custom small back button
          Positioned(
            top: 68,
            left: 30,
            child: GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE82925),
                  borderRadius: BorderRadius.circular(45),
                ),
                padding: const EdgeInsets.all(6),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
