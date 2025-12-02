import 'package:flutter/material.dart';
import '../../../app/app_routes.dart';
import '../../../core/widgets/bg_designe_1.dart';
import '../../../core/widgets/login_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _onLoginSuccess(BuildContext context) {
    // After "login", go to home and CLEAR the stack:
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      body: Stack(
        children: [
          const Positioned.fill(child: BgDesign1()),

          // Center the whole login card
          Center(
            child: LoginWidgetA(
              onLoginSuccess: () => _onLoginSuccess(context),
            ),
          ),
        ],
      ),
    );
  }
}