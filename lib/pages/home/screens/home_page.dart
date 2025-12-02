import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animations/animations.dart';

import '../../../core/widgets/main_menu.dart';
import '../../../app/app_routes.dart';
import '../../../data/services/auth_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _userName;
  int _currentIndex = 0;
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(AuthApi.userKey);
    if (userJson == null) return;

    final Map<String, dynamic> user = jsonDecode(userJson);
    setState(() {
      _userName = user['username'] as String?;
    });
  }

  void _onMenuTap(int index) async {
    if (index == 3) {
      // Logout tab → clear storage + go login
      await AuthApi().logout();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
      return;
    }

    setState(() {
      _previousIndex = _currentIndex;
      _currentIndex = index;
    });
  }

  bool get _slideLeft => _currentIndex > _previousIndex;

  Widget _getPage() {
    switch (_currentIndex) {
      case 0:
        return const _HomeTab(key: ValueKey('home'));
      case 1:
        return const _CategoriesTab(key: ValueKey('categories'));
      case 2:
        return const _DocumentsTab(key: ValueKey('documents'));
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // *********** PAGE TRANSITION AREA ***********
          Positioned.fill(
            child: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation, secondaryAnimation) {
                final begin = Offset(_slideLeft ? 1 : -1, 0);
                const end = Offset.zero;

                return SlideTransition(
                  position: animation.drive(
                    Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: Curves.easeOut)),
                  ),
                  child: child,
                );
              },
              // 👇 key is important so it knows page actually changed
              child: _getPage(),
            ),
          ),

          // *********** FIXED OVERLAY MENU ***********
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: MainMenu(currentIndex: _currentIndex, onTap: _onMenuTap),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// TAB SUB-PAGES
// ------------------------------------------------------------

class _HomeTab extends StatelessWidget {
  const _HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Home content here',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

class _CategoriesTab extends StatelessWidget {
  const _CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Categories content here',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

class _DocumentsTab extends StatelessWidget {
  const _DocumentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Documents content here',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
