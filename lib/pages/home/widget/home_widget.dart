import 'package:flutter/material.dart';
import '../../../core/constant/app_image.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      
      body: Center(
        child: Text('Home', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
