import 'package:flutter/material.dart';
import '../../../app/app_routes.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start / Intro'),
        automaticallyImplyLeading: false, // no back arrow here
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Go to login and REPLACE start page (no back to start)
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          },
          child: const Text('Continue to Login'),
        ),
      ),
    );
  }
}