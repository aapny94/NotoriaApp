import 'package:flutter/material.dart';
import 'app_nav.dart';
import 'app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notoria Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.start,      // 👈 app starts at /start
      onGenerateRoute: AppNav.generateRoute,
    );
  }
}