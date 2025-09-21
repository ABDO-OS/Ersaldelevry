import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';

class MainNavigationScreen extends StatefulWidget {
  final Widget child;

  const MainNavigationScreen({
    super.key,
    required this.child,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: AppStrings.home,
      route: AppRouter.home,
    ),
    NavigationItem(
      icon: Icons.search_outlined,
      activeIcon: Icons.search,
      label: AppStrings.search,
      route: AppRouter.search,
    ),
    NavigationItem(
      icon: Icons.shopping_bag_outlined,
      activeIcon: Icons.shopping_bag,
      label: AppStrings.orders,
      route: AppRouter.orders,
    ),
    NavigationItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: AppStrings.profile,
      route: AppRouter.profile,
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _updateSelectedIndex();
  }

  // void _updateSelectedIndex() {
  //   final String location = GoRouter.of(context).location;
  //   for (int i = 0; i < _navigationItems.length; i++) {
  //     if (location.startsWith(_navigationItems[i].route)) {
  //       if (_currentIndex != i) {
  //         setState(() {
  //           _currentIndex = i;
  //         });
  //       }
  //       break;
  //     }
  //   }
  // }

  void _onItemTapped(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
      context.go(_navigationItems[index].route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          boxShadow: AppTheme.elevatedShadow,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                _navigationItems.length,
                (index) => _buildNavItem(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final item = _navigationItems[index];
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryGreen.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? item.activeIcon : item.icon,
              color: isSelected ? AppTheme.primaryGreen : AppTheme.grey600,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                color: isSelected ? AppTheme.primaryGreen : AppTheme.grey600,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;

  const NavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
  });
}
