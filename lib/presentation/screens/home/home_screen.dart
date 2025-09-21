import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../widgets/restaurant_card.dart';
import '../../widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _currentLocation = 'جاري تحديد الموقع...';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() {
    // TODO: Implement location service
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _currentLocation = 'الرياض، المملكة العربية السعودية';
        });
      }
    });
  }

  Widget _buildDeliverySection() {
    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryGreen,
            AppTheme.lightGreen,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        boxShadow: AppTheme.elevatedShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                decoration: BoxDecoration(
                  color: AppTheme.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                ),
                child: const Icon(
                  Icons.delivery_dining,
                  color: AppTheme.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.productDelivery,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppTheme.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      AppStrings.orderFromAnywhere,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.white.withOpacity(0.9),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingL),
          Row(
            children: [
              Expanded(
                child: _buildDeliveryFeature(
                  icon: Icons.speed,
                  title: AppStrings.fastDelivery,
                  subtitle: AppStrings.within30Minutes,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: _buildDeliveryFeature(
                  icon: Icons.location_on,
                  title: AppStrings.safeDelivery,
                  subtitle: AppStrings.allAreas,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: _buildDeliveryFeature(
                  icon: Icons.payment,
                  title: AppStrings.securePayment,
                  subtitle: AppStrings.multiplePaymentMethods,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingL),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.go(AppRouter.productDelivery),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.white,
                foregroundColor: AppTheme.primaryGreen,
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(vertical: AppTheme.spacingM),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusL),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, size: 20),
                  const SizedBox(width: AppTheme.spacingS),
                  Text(
                    AppStrings.newDeliveryRequest,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryGreen,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryFeature({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppTheme.white,
          size: 24,
        ),
        const SizedBox(height: AppTheme.spacingXS),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.white,
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.white.withOpacity(0.8),
                fontSize: 10,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return CircleAvatar(
              backgroundImage: state.user?.photoUrl != null
                  ? NetworkImage(state.user!.photoUrl!)
                  : null,
              child: state.user?.photoUrl == null
                  ? const Icon(Icons.person)
                  : null,
            );
          },
        ),
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.deliveryTo,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  _currentLocation,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                ),
              ],
            ),
            SizedBox(
              width: 41,
            ),
            SizedBox(
              width: 70,
              height: 70,
              child: Image.asset('assets/images/logo.png'),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.grey100,
                  borderRadius: BorderRadius.circular(AppTheme.radiusL),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'ابحث عن المطاعم أو الأطباق',
                    hintStyle: TextStyle(color: AppTheme.textHint),
                    prefixIcon:
                        Icon(Icons.search, color: AppTheme.primaryGreen),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingM,
                      vertical: AppTheme.spacingM,
                    ),
                  ),
                  onTap: () => context.go('/search'),
                ),
              ),
            ),

            // Delivery Section
            _buildDeliverySection(),

            const SizedBox(height: 24),

            // Featured restaurants
            SectionHeader(
              title: AppStrings.featuredPartners,
              onSeeAll: () {
                // TODO: Navigate to featured restaurants
              },
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.defaultPadding),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: RestaurantCard(
                      name: 'مطعم الدجاج المقلي ${index + 1}',
                      location: 'الرياض، المملكة العربية السعودية',
                      rating: 4.5 + (index * 0.1),
                      deliveryTime: 20 + (index * 5),
                      onTap: () {
                        context.go('/restaurant/$index');
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Best picks
            SectionHeader(
              title: AppStrings.bestPick,
              onSeeAll: () {
                // TODO: Navigate to best picks
              },
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.defaultPadding),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: RestaurantCard(
                      name: 'مطعم الأطباق الشهية ${index + 1}',
                      location: 'جدة، المملكة العربية السعودية',
                      rating: 4.3 + (index * 0.1),
                      deliveryTime: 25 + (index * 5),
                      onTap: () {
                        context.go('/restaurant/${index + 5}');
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // All restaurants
            SectionHeader(
              title: AppStrings.allRestaurants,
              onSeeAll: () {
                // TODO: Navigate to all restaurants
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: RestaurantCard(
                    name: 'مطعم الأكلات الشعبية ${index + 1}',
                    location: 'الدمام، المملكة العربية السعودية',
                    rating: 4.0 + (index * 0.1),
                    deliveryTime: 30 + (index * 5),
                    isHorizontal: true,
                    onTap: () {
                      context.go('/restaurant/${index + 10}');
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
