import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';

class UserTypeSelectionScreen extends StatefulWidget {
  const UserTypeSelectionScreen({super.key});

  @override
  State<UserTypeSelectionScreen> createState() =>
      _UserTypeSelectionScreenState();
}

class _UserTypeSelectionScreenState extends State<UserTypeSelectionScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  int _selectedUserType = 0; // Default to العميل

  final List<UserType> _userTypes = [
    const UserType(
      title: AppStrings.admin,
      subtitle: 'إدارة النظام والمطاعم',
      icon: Icons.admin_panel_settings,
      color: AppTheme.primaryGreen,
    ),
    const UserType(
      title: AppStrings.delivery,
      subtitle: 'توصيل الطلبات',
      icon: Icons.delivery_dining,
      color: AppTheme.warningOrange,
    ),
    const UserType(
      title: AppStrings.customer,
      subtitle: 'طلب الطعام',
      icon: Icons.person,
      color: AppTheme.lightGreen,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectUserType(int index) {
    setState(() {
      _selectedUserType = index;
    });
  }

  void _proceedToAuth() {
    if (_selectedUserType == 0) {
      // الأدارة - go to login
      context.go(AppRouter.signIn);
    } else if (_selectedUserType == 1) {
      // المندوب - go to delivery screen
      context.go(AppRouter.delivery);
    } else {
      // العميل - go to onboarding
      context.go(AppRouter.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.grey50,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingL),
              child: Column(
                children: [
                  const SizedBox(height: AppTheme.spacingXXL),

                  // App Logo and Title
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen,
                      shape: BoxShape.circle,
                      boxShadow: AppTheme.elevatedShadow,
                    ),
                    child: const Icon(
                      Icons.restaurant,
                      size: 60,
                      color: AppTheme.white,
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacingL),

                  Text(
                    'مرحباً بك في تطبيق الطعام',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppTheme.spacingS),

                  Text(
                    AppStrings.selectUserType,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppTheme.spacingXXL),

                  // User Type Selection
                  Expanded(
                    child: ListView.builder(
                      itemCount: _userTypes.length,
                      itemBuilder: (context, index) {
                        final userType = _userTypes[index];
                        final isSelected = _selectedUserType == index;

                        return Padding(
                          padding:
                              const EdgeInsets.only(bottom: AppTheme.spacingM),
                          child: GestureDetector(
                            onTap: () => _selectUserType(index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              padding: const EdgeInsets.all(AppTheme.spacingL),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? userType.color.withOpacity(0.1)
                                    : AppTheme.white,
                                borderRadius:
                                    BorderRadius.circular(AppTheme.radiusL),
                                border: Border.all(
                                  color: isSelected
                                      ? userType.color
                                      : AppTheme.grey300,
                                  width: isSelected ? 2 : 1,
                                ),
                                boxShadow: isSelected
                                    ? AppTheme.elevatedShadow
                                    : AppTheme.cardShadow,
                              ),
                              child: Row(
                                children: [
                                  // Icon
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? userType.color
                                          : userType.color.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      userType.icon,
                                      size: 30,
                                      color: isSelected
                                          ? AppTheme.white
                                          : userType.color,
                                    ),
                                  ),

                                  const SizedBox(width: AppTheme.spacingM),

                                  // Content
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userType.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: isSelected
                                                    ? userType.color
                                                    : AppTheme.textPrimary,
                                              ),
                                        ),
                                        const SizedBox(
                                            height: AppTheme.spacingXS),
                                        Text(
                                          userType.subtitle,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: AppTheme.textSecondary,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Selection Indicator
                                  if (isSelected)
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: userType.color,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        size: 16,
                                        color: AppTheme.white,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacingL),

                  // Proceed Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _proceedToAuth,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _userTypes[_selectedUserType].color,
                        foregroundColor: AppTheme.white,
                        elevation: AppTheme.elevationS,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusL),
                        ),
                      ),
                      child: Text(
                        AppStrings.proceed,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.white,
                                ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacingM),

                  // Change User Type Button
                  TextButton(
                    onPressed: () {
                      // This will be handled by the sliding bar
                    },
                    child: Text(
                      AppStrings.changeUserType,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.primaryGreen,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),

                  const SizedBox(height: AppTheme.spacingL),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserType {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const UserType({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}
