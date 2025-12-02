import 'package:flutter/material.dart';
import '../constant/app_image.dart'; // adjust if your path is different

class LoginWidgetA extends StatelessWidget {
  final VoidCallback onLoginSuccess;

  const LoginWidgetA({
    super.key,
    required this.onLoginSuccess,
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
            child: Image.asset(
              AppImage.logoWhite,
              fit: BoxFit.contain,
            ),
          ),
        ),

        const SizedBox(height: 50),
        const Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),

        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(top: 0, right: 70, left: 70),
          child: Text(
            'Please enter your credentials to access the admin panel.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),

        const SizedBox(height: 30),
        SizedBox(
          height: 50,
          width: 350,
          child: TextField(
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF272727),

              labelText: 'Username',
              labelStyle: const TextStyle(color: Colors.white),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF535353),
                  width: 1.4,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 1.4,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),

        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          width: 350,
          child: TextField(
            obscureText: true,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF272727),

              labelText: 'Password',
              labelStyle: const TextStyle(color: Colors.white),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF535353),
                  width: 1.4,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 1.4,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),

        const SizedBox(height: 60),
        SizedBox(
          height: 50,
          width: 350,
          child: ElevatedButton(
            onPressed: onLoginSuccess,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE82925),
              foregroundColor: Colors.white,
              elevation: 0,
              side: const BorderSide(
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}