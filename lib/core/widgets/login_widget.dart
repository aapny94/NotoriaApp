import 'package:flutter/material.dart';
import '../constant/app_image.dart';

class LoginWidgetA extends StatelessWidget {
  final TextEditingController usernameCtrl;
  final TextEditingController passwordCtrl;
  final VoidCallback onLoginPress;
  final bool isLoading;
  final String? errorMessage;

  const LoginWidgetA({
    super.key,
    required this.usernameCtrl,
    required this.passwordCtrl,
    required this.onLoginPress,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AppImage.logoWhite, fit: BoxFit.contain),
          ),
        ),

        const SizedBox(height: 50),
        const Text("Login",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),

        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(top: 0, right: 70, left: 70),
          child: Text(
            'Please enter your credentials to access the admin panel.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),

        const SizedBox(height: 30),
        SizedBox(
          height: 50,
          width: 350,
          child: TextField(
            controller: usernameCtrl,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: inputDecoration("Username"),
          ),
        ),

        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          width: 350,
          child: TextField(
            controller: passwordCtrl,
            obscureText: true,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: inputDecoration("Password"),
          ),
        ),

        if (errorMessage != null) ...[
          const SizedBox(height: 12),
          Text(
            errorMessage!,
            style: const TextStyle(color: Colors.red, fontSize: 14),
          ),
        ],

        const SizedBox(height: 60),
        SizedBox(
          height: 50,
          width: 350,
          child: ElevatedButton(
            onPressed: isLoading ? null : onLoginPress,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE82925),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              isLoading ? "Logging in..." : "Login",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFF272727),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF535353), width: 1.4),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white, width: 1.4),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}