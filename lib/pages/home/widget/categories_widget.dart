import 'package:flutter/material.dart';

import '../../../core/constant/app_image.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          children: const [
            Image(image: AssetImage(AppImage.logoThumbnail)),
            Text(
              'Categories',
              style: TextStyle(color: Colors.white),
            ),
        ]),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        color: Colors.transparent,
        child: const Center(child: Text('Categories', style: TextStyle(color: Colors.white) )),
      ),
    );
  }
}
