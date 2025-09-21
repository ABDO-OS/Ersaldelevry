import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final String restaurantId;

  const RestaurantDetailsScreen({
    super.key,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل المطعم'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRouter.home),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.grey200,
                borderRadius: BorderRadius.circular(AppTheme.radiusL),
              ),
              child: const Center(
                child: Icon(
                  Icons.restaurant,
                  size: 64,
                  color: AppTheme.grey500,
                ),
              ),
            ),

            // Restaurant info
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مطعم الدجاج المقلي $restaurantId',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'الرياض، المملكة العربية السعودية',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 16),

                  // Rating and delivery time
                  const Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppTheme.warningOrange,
                      ),
                      SizedBox(width: 4),
                      Text('4.5'),
                      SizedBox(width: 16),
                      Icon(
                        Icons.access_time,
                        color: AppTheme.grey600,
                      ),
                      SizedBox(width: 4),
                      Text('20 دقيقة'),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Menu items
                  Text(
                    'قائمة الطعام',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppTheme.grey200,
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusM),
                            ),
                            child: const Icon(
                              Icons.fastfood,
                              color: AppTheme.grey500,
                            ),
                          ),
                          title: Text('طبق ${index + 1}'),
                          subtitle: Text('وصف الطبق ${index + 1}'),
                          trailing: Text(
                            '${(index + 1) * 25} ر.س',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppTheme.primaryGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          onTap: () {
                            // TODO: Add to cart
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        decoration: BoxDecoration(
          color: AppTheme.white,
          boxShadow: AppTheme.elevatedShadow,
        ),
        child: ElevatedButton(
          onPressed: () {
            // TODO: Add to cart
          },
          child: const Text('إضافة إلى السلة'),
        ),
      ),
    );
  }
}
