import 'package:flutter/material.dart';
import '../../../app/app_routes.dart';
import 'package:package_info_plus/package_info_plus.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String version = "";

  @override
  void initState() {
    super.initState();

    // Load version from package_info_plus
    loadVersion();

    // Auto navigate to login after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    });
  }

  // Load version from logic
  Future<void> loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      version = "Version ${info.version}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE82925),
      body: SafeArea(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Image.asset(
                        'assets/images/logo_black.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    textAlign: TextAlign.center,

                    // Load version from package_info_plus
                    version.isEmpty ? "" : version,

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontFamily: 'Helvetica',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
