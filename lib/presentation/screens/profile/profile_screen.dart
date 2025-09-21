import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../widgets/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profile),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              children: [
                // User info
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: AppTheme.cardShadow,
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: state.user?.photoUrl != null
                            ? NetworkImage(state.user!.photoUrl!)
                            : null,
                        child: state.user?.photoUrl == null
                            ? const Icon(Icons.person, size: 40)
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.user?.displayName ?? 'المستخدم',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.user?.email ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Menu items
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: AppTheme.cardShadow,
                  ),
                  child: Column(
                    children: [
                      ProfileMenuItem(
                        icon: Icons.shopping_bag_outlined,
                        title: 'طلباتي',
                        subtitle: 'عرض جميع طلباتك',
                        onTap: () {
                          // TODO: Navigate to orders
                        },
                      ),
                      const Divider(height: 1),
                      ProfileMenuItem(
                        icon: Icons.favorite_outline,
                        title: 'المفضلة',
                        subtitle: 'المطاعم والأطباق المفضلة',
                        onTap: () {
                          // TODO: Navigate to favorites
                        },
                      ),
                      const Divider(height: 1),
                      ProfileMenuItem(
                        icon: Icons.location_on_outlined,
                        title: 'العناوين',
                        subtitle: 'إدارة عناوين التوصيل',
                        onTap: () {
                          // TODO: Navigate to addresses
                        },
                      ),
                      const Divider(height: 1),
                      ProfileMenuItem(
                        icon: Icons.payment_outlined,
                        title: 'طرق الدفع',
                        subtitle: 'إدارة طرق الدفع',
                        onTap: () {
                          // TODO: Navigate to payment methods
                        },
                      ),
                      const Divider(height: 1),
                      ProfileMenuItem(
                        icon: Icons.help_outline,
                        title: 'المساعدة',
                        subtitle: 'الأسئلة الشائعة والدعم',
                        onTap: () {
                          // TODO: Navigate to help
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Sign out button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<AuthCubit>().signOut();
                      context.go(AppRouter.signIn);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text(AppStrings.signOut),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.errorRed.withOpacity(0.1),
                      foregroundColor: AppTheme.errorRed,
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
