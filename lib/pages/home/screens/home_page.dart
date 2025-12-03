import 'package:flutter/material.dart';
import '../widget/home_widget.dart';
import '../widget/categories_widget.dart';
import '../../../core/widgets/main_menu.dart';
import '../../../app/app_routes.dart';
import '../../../data/services/auth_api.dart';
import '../../../core/widgets/bg_design_2.dart';
import '../../../core/constant/app_image.dart';
import '../widget/document_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onMenuTap(int index) async {
    if (index == 3) {
      await AuthApi().logout();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
      return;
    }
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.ease,
    );
  }

  void skipToFirstTab() {
    setState(() {
      _currentIndex = 0;
    });
    _pageController.jumpToPage(
      0,
    ); // Instantly jumps, no animation through tab 2
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      body: Stack(
        children: [
          Positioned.fill(
            child: Stack(
              children: [
                BgDesign2(),
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 30),
                  child: Image.asset(
                    AppImage.logoThumbnail,
                    fit: BoxFit.contain,
                  ),
                ), // Spacer
              ],
            ),
          ),
          Positioned.fill(
            child: PageView(
              controller: _pageController,
              physics: const ClampingScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: const [_HomeTab(), _CategoriesTab(), _DocumentsTab()],
            ),
          ),
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
    return const HomeWidget();
  }
}

class _CategoriesTab extends StatelessWidget {
  const _CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const CategoriesWidget();
  }
}

class _DocumentsTab extends StatelessWidget {
  const _DocumentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const DocumentWidget();
  }
}
