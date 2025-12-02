import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  final int currentIndex;              // which tab is active
  final void Function(int) onTap;      // what to do when a tab is tapped

  const MainMenu({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF4A4A4A),
          width: 1,
        ),
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
            activeColor: const Color(0xFFE26635),
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
  final Color activeColor;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.activeColor = const Color(0xFFE26635),
  });

  @override
  Widget build(BuildContext context) {
    final Color baseColor = Colors.white;
    final Color iconBg = isActive ? activeColor : Colors.transparent;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: baseColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: baseColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}