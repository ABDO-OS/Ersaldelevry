import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';

class RestaurantCard extends StatelessWidget {
  final String name;
  final String location;
  final double rating;
  final int deliveryTime;
  final bool isHorizontal;
  final VoidCallback? onTap;

  const RestaurantCard({
    super.key,
    required this.name,
    required this.location,
    required this.rating,
    required this.deliveryTime,
    this.isHorizontal = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return _buildHorizontalCard(context);
    } else {
      return _buildVerticalCard(context);
    }
  }

  Widget _buildVerticalCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.grey200,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppTheme.radiusL),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.restaurant,
                  size: 48,
                  color: AppTheme.grey500,
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: AppTheme.warningOrange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      // const SizedBox(width: 8),
                      // Icon(
                      //   Icons.access_time,
                      //   size: 16,
                      //   color: AppTheme.grey600,
                      // ),
                      // const SizedBox(width: 4),
                      // Text(
                      //   '$deliveryTime دقيقة',
                      //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      //         color: AppTheme.grey600,
                      //       ),
                      // ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Row(
          children: [
            // Image placeholder
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(12),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.restaurant,
                  size: 32,
                  color: Colors.grey,
                ),
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      location,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$deliveryTime دقيقة',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
