import 'package:flutter/material.dart';

class DocumentWidget extends StatelessWidget {
  const DocumentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color.fromARGB(0, 19, 19, 19),
      
      body: Center(
        child: Text('Documents', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
