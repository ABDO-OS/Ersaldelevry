import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection_container.dart' as di;
import '../../../data/datasources/location_remote_datasource.dart';
import '../../../data/models/location_model.dart';
import '../../widgets/restaurant_card.dart';
import '../../widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _currentLocation = 'جاري تحديد الموقع...';
  bool _isLoadingLocation = true;
  LocationModel? _currentLocationData;
  late final LocationRemoteDataSource _locationService;

  @override
  void initState() {
    super.initState();
    _locationService = di.sl<LocationRemoteDataSource>();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      setState(() {
        _isLoadingLocation = true;
        _currentLocation = 'جاري تحديد الموقع...';
      });

      final locationData = await _locationService.getCurrentLocation();

      if (mounted) {
        setState(() {
          _currentLocationData = locationData;
          _currentLocation = _formatLocationAddress(locationData);
          _isLoadingLocation = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _currentLocation = 'فشل في تحديد الموقع';
          _isLoadingLocation = false;
        });

        // Show error message with retry option
        _showLocationError(e.toString());
      }
    }
  }

  String _formatLocationAddress(LocationModel location) {
    if (location.address != null && location.address!.isNotEmpty) {
      return location.address!;
    }

    final parts = <String>[];
    if (location.city != null && location.city!.isNotEmpty) {
      parts.add(location.city!);
    }
    if (location.country != null && location.country!.isNotEmpty) {
      parts.add(location.country!);
    }

    return parts.isNotEmpty ? parts.join(', ') : 'موقع غير معروف';
  }

  void _showLocationError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('خطأ في تحديد الموقع: $error'),
        backgroundColor: AppTheme.errorRed,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'إعادة المحاولة',
          textColor: AppTheme.white,
          onPressed: _getCurrentLocation,
        ),
      ),
    );
  }

  Widget _buildDeliverySection() {
    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
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
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _getCurrentLocation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppStrings.deliveryTo,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.primaryGreen,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        if (_isLoadingLocation) ...[
                          const SizedBox(width: 8),
                          const SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppTheme.primaryGreen,
                              ),
                            ),
                          ),
                        ] else ...[
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.refresh,
                            size: 16,
                            color: AppTheme.primaryGreen,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _currentLocation,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (_currentLocationData != null &&
                        !_isLoadingLocation) ...[
                      const SizedBox(height: 2),
                      Text(
                        'دقة: ${_currentLocationData!.latitude.toStringAsFixed(4)}, ${_currentLocationData!.longitude.toStringAsFixed(4)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.grey600,
                              fontSize: 10,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
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
                  decoration: const InputDecoration(
                    hintText: 'ابحث عن المطاعم أو الأطباق',
                    hintStyle: TextStyle(color: AppTheme.textHint),
                    prefixIcon:
                        Icon(Icons.search, color: AppTheme.primaryGreen),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
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
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        backgroundColor: AppTheme.primaryGreen,
        child: _isLoadingLocation
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.white),
                ),
              )
            : const Icon(Icons.my_location, color: AppTheme.white),
      ),
    );
  }
}
