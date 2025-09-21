import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/auth/sign_in_screen.dart';
import '../../presentation/screens/auth/sign_up_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/search/search_screen.dart';
import '../../presentation/screens/orders/orders_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/restaurant_details/restaurant_details_screen.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/main_navigation/main_navigation_screen.dart';
import '../../presentation/screens/user_type_selection/user_type_selection_screen.dart';
import '../../presentation/screens/delivery/product_delivery_screen.dart';
import '../../presentation/screens/delivery/delivery_screen.dart';
import '../../presentation/screens/delivery/cubit/delivery_cubit.dart';

class AppRouter {
  static const String splash = '/';
  static const String userTypeSelection = '/user-type-selection';
  static const String onboarding = '/onboarding';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String home = '/home';
  static const String search = '/search';
  static const String orders = '/orders';
  static const String profile = '/profile';
  static const String restaurantDetails = '/restaurant';
  static const String productDelivery = '/product-delivery';
  static const String delivery = '/delivery';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: userTypeSelection,
        name: 'user-type-selection',
        builder: (context, state) => const UserTypeSelectionScreen(),
      ),
      GoRoute(
        path: onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: signIn,
        name: 'sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: signUp,
        name: 'sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainNavigationScreen(child: child),
        routes: [
          GoRoute(
            path: home,
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: search,
            name: 'search',
            builder: (context, state) => const SearchScreen(),
          ),
          GoRoute(
            path: orders,
            name: 'orders',
            builder: (context, state) => const OrdersScreen(),
          ),
          GoRoute(
            path: profile,
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/restaurant/:id',
        name: 'restaurant-details',
        builder: (context, state) {
          final restaurantId = state.pathParameters['id']!;
          return RestaurantDetailsScreen(restaurantId: restaurantId);
        },
      ),
      GoRoute(
        path: productDelivery,
        name: 'product-delivery',
        builder: (context, state) => const ProductDeliveryScreen(),
      ),
      GoRoute(
        path: delivery,
        name: 'delivery',
        builder: (context, state) => BlocProvider(
          create: (context) => DeliveryCubit(),
          child: const DeliveryScreen(),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'الصفحة غير موجودة',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'عذراً، الصفحة التي تبحث عنها غير موجودة',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(home),
              child: const Text('العودة للرئيسية'),
            ),
          ],
        ),
      ),
    ),
  );
}
