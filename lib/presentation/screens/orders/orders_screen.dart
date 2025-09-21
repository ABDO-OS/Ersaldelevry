import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.orders),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 64,
              color: AppTheme.grey500,
            ),
            SizedBox(height: 16),
            Text(
              'لا توجد طلبات بعد',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppTheme.grey600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'اطلب من مطعمك المفضل وستظهر طلباتك هنا',
              style: TextStyle(
                color: AppTheme.grey600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
