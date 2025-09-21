import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/constants/app_constants.dart';

class OrderCard extends StatelessWidget {
  final String restaurantName;
  final String orderId;
  final String orderDate;
  final String status;
  final double totalAmount;
  final String? imageUrl;
  final VoidCallback? onTap;
  final VoidCallback? onReorder;

  const OrderCard({
    super.key,
    required this.restaurantName,
    required this.orderId,
    required this.orderDate,
    required this.status,
    required this.totalAmount,
    this.imageUrl,
    this.onTap,
    this.onReorder,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
      case 'تم التسليم':
        return AppTheme.successGreen;
      case 'preparing':
      case 'قيد التحضير':
        return AppTheme.warningOrange;
      case 'on the way':
      case 'في الطريق':
        return AppTheme.primaryGreen;
      case 'cancelled':
      case 'ملغي':
        return AppTheme.errorRed;
      default:
        return AppTheme.grey600;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
      case 'تم التسليم':
        return Icons.check_circle;
      case 'preparing':
      case 'قيد التحضير':
        return Icons.restaurant;
      case 'on the way':
      case 'في الطريق':
        return Icons.delivery_dining;
      case 'cancelled':
      case 'ملغي':
        return Icons.cancel;
      default:
        return Icons.shopping_bag;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.smallPadding,
      ),
      elevation: AppTheme.elevationS,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with restaurant name and status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      restaurantName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.smallPadding,
                      vertical: 4,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getStatusIcon(status),
                          size: 16,
                          color: _getStatusColor(status),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          status,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor(status),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppConstants.smallPadding),

              // Order details row
              Row(
                children: [
                  const Icon(
                    Icons.receipt_long,
                    size: 16,
                    color: AppTheme.grey600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'طلب رقم: $orderId',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.grey600,
                        ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: AppTheme.grey600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    orderDate,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.grey600,
                        ),
                  ),
                ],
              ),

              const SizedBox(height: AppConstants.smallPadding),

              // Total amount and reorder button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'المجموع: ${totalAmount.toStringAsFixed(2)} ر.س',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryGreen,
                        ),
                  ),
                  if (onReorder != null)
                    TextButton(
                      onPressed: onReorder,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding,
                          vertical: AppConstants.smallPadding,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusM),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.refresh,
                            size: 16,
                            color: AppTheme.primaryGreen,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'إعادة الطلب',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
