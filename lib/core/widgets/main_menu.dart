import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  final int currentIndex; // which tab is active
  final void Function(int) onTap; // what to do when a tab is tapped

  const MainMenu({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(34),
        border: Border.all(color: const Color(0xFF4A4A4A), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _MenuItem(
            icon: Icons.home_outlined,
            label: 'Home',
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _MenuItem(
            icon: Icons.brush_outlined,
            label: 'Categories',
            isActive: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _MenuItem(
            icon: Icons.description_outlined,
            label: 'Documents',
            isActive: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          _MenuItem(
            icon: Icons.logout,
            label: 'Logout',
            isActive: currentIndex == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color activeColor = Color(0xFFE82925);
    const Color inactiveColor = Colors.white;

    final Color itemColor = isActive ? activeColor : inactiveColor;

    // 🔴 SPECIAL CASE: Logout button should be a square button
    if (label == 'Logout') {
      return Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: InkWell(
          borderRadius: BorderRadius.circular(1),
          onTap: onTap,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: activeColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 35, color: Colors.white),
                const SizedBox(height: 1),
                const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    fontFamily: "Helvetica",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // 🔵 Normal menu items
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 35, color: itemColor),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: itemColor,
                  fontFamily: 'Helvetica',
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
