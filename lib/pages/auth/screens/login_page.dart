import 'package:flutter/material.dart';
import '../../../app/app_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _onLoginSuccess(BuildContext context) {
    // After "login", go to home and CLEAR the stack:
    // No back to login, no back to start.
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        automaticallyImplyLeading: true, // back to StartPage (if you didn't clear it)
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _onLoginSuccess(context),
          child: const Text('Login (simulate success)'),
        ),
      ),
    );
  }
}