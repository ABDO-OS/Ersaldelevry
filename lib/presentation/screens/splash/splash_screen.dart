import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../cubits/auth/auth_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  Future<void> _initializeApp() async {
    // Wait for minimum splash duration
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      // Check authentication status
      context.read<AuthCubit>().getCurrentUser();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryGreen,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.isAuthenticated) {
            context.go(AppRouter.home);
          } else if (state.status == AuthStatus.unauthenticated) {
            context.go(AppRouter.userTypeSelection);
          }
        },
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.restaurant,
                  size: 100,
                  color: AppTheme.white,
                ),
                const SizedBox(height: 24),
                Text(
                  AppStrings.appName,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppTheme.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  'تطبيق الطعام المفضل لديك',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.white.withOpacity(0.7),
                      ),
                ),
                const SizedBox(height: 48),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
