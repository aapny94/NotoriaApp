import 'package:flutter/material.dart';
import '../pages/start/screens/start_page.dart';
import '../pages/auth/screens/login_page.dart';
import '../pages/home/screens/home_page.dart';
import '../pages/profile/screens/profile_page.dart';
import 'app_routes.dart';

class AppNav {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.start:
        return MaterialPageRoute(
          builder: (_) => const StartPage(),
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );

      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfilePage(),
        );

      case AppRoutes.documents:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Documents'),
            ),
          ),
        );

      case AppRoutes.categories:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Categories'),
            ),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );

    }
  }
}