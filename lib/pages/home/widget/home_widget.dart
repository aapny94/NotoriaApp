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
  String username = "";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(AuthApi.userKey);

    if (userJson != null) {
      final user = jsonDecode(userJson);
      setState(() {
        username = user["username"] ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: const Color.fromARGB(0, 19, 19, 19),

      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 26, top: 16, right: 16),
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
              padding: const EdgeInsets.only(left: 26, right: 16),
              child: Text(
                username.isEmpty
                    ? "..."
                    : "${username[0].toUpperCase()}${username.substring(1)}!",
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