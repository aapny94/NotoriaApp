// lib/pages/home/widget/home_widget.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/services/auth_api.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final userStr = prefs.getString(AuthApi.userKey);
    if (userStr == null) return;

    final user = jsonDecode(userStr) as Map<String, dynamic>;

    setState(() {
      // Adjust key if Strapi uses different field (e.g. 'username' or 'email')
      _username = user['username'] as String?;
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _username ?? 'User';

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: const Color.fromARGB(0, 19, 19, 19),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 26.0,
                top: 16.0,
                right: 16.0,
              ),
              child: const Text(
                'Welcome back,',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'Helvetica',
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 26.0,
                right: 16.0,
              ),
              child: Text(
                '$displayName,',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          const Center(
            child: Text('Home', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}