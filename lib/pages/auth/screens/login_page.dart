import 'package:flutter/material.dart';
import '../../../app/app_routes.dart';
import '../../../core/widgets/bg_designe_1.dart';
import '../../../core/widgets/login_widget.dart';
import '../../../data/services/auth_api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  bool isLoading = false;
  String? errorMsg;

  Future<void> _attemptLogin() async {
    setState(() {
      isLoading = true;
      errorMsg = null;
    });

    final auth = AuthApi();

    try {
      await auth.login(
        username: usernameCtrl.text.trim(),
        password: passwordCtrl.text.trim(),
      );

      // Login OK → navigate to home
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    } catch (e) {
      // Login failed → show error
      setState(() {
        errorMsg = e.toString();
      });
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      body: Stack(
        children: [
          const Positioned.fill(child: BgDesign1()),
          Center(
            child: LoginWidgetA(
              usernameCtrl: usernameCtrl,
              passwordCtrl: passwordCtrl,
              onLoginPress: _attemptLogin,
              isLoading: isLoading,
              errorMessage: errorMsg,
            ),
          ),
        ],
      ),
    );
  }
}