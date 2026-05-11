import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/color_schemes.dart';

class MainShell extends StatefulWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<_NavItem> _navItems = [
    _NavItem(Icons.home_outlined, Icons.home, '/home', 'Home'),
    _NavItem(Icons.terminal_outlined, Icons.terminal, '/terminal', 'Terminal'),
    _NavItem(Icons.cloud_outlined, Icons.cloud, '/linux', 'Linux'),
    _NavItem(Icons.inventory_2_outlined, Icons.inventory_2, '/packages', 'Packages'),
    _NavItem(Icons.folder_outlined, Icons.folder, '/files', 'Files'),
    _NavItem(Icons.settings_outlined, Icons.settings, '/settings', 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    _currentIndex = _navItems.indexWhere((item) => location == item.path);
    if (_currentIndex < 0) _currentIndex = 0;

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ColorSchemes.surface,
          border: Border(
            top: BorderSide(
              color: ColorSchemes.surfaceVariant.withOpacity(0.5),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                _navItems.length,
                (index) => _buildNavItem(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final item = _navItems[index];
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = index);
        context.go(item.path);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected 
              ? ColorSchemes.primary.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? item.activeIcon : item.icon,
              color: isSelected ? ColorSchemes.primary : ColorSchemes.textSecondary,
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                item.label,
                style: TextStyle(
                  color: ColorSchemes.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String path;
  final String label;

  _NavItem(this.icon, this.activeIcon, this.path, this.label);
}