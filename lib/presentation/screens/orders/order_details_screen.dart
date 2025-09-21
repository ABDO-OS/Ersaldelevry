import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> order;

  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  double _rating = 0.0;
  final TextEditingController _feedbackController = TextEditingController();
  bool _isSubmittingRating = false;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitRating() async {
    if (_rating == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إعطاء تقييم للطلب'),
          backgroundColor: AppTheme.errorRed,
        ),
      );
      return;
    }

    setState(() {
      _isSubmittingRating = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isSubmittingRating = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إرسال التقييم بنجاح'),
          backgroundColor: AppTheme.primaryGreen,
        ),
      );

      Navigator.of(context).pop();
    }
  }

  Widget _buildOrderHeader() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppTheme.radiusL),
          bottomRight: Radius.circular(AppTheme.radiusL),
        ),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(widget.order['status'])
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                ),
                child: Text(
                  widget.order['status'],
                  style: TextStyle(
                    color: _getStatusColor(widget.order['status']),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                widget.order['orderId'],
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.grey600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.order['restaurantName'],
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.order['orderDate'],
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.grey600,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المجموع',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                '${widget.order['totalAmount']} ريال',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreen,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItems() {
    return Container(
      margin: const EdgeInsets.all(AppConstants.defaultPadding),
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تفاصيل الطلب',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildOrderItem(
            name: 'دجاج مقلي مع الأرز',
            quantity: 2,
            price: 45.50,
          ),
          const Divider(height: 24),
          _buildOrderItem(
            name: 'سلطة خضار طازجة',
            quantity: 1,
            price: 15.25,
          ),
          const Divider(height: 24),
          _buildOrderItem(
            name: 'مشروب غازي',
            quantity: 2,
            price: 8.00,
          ),
          const Divider(height: 24),
          _buildOrderItem(
            name: 'رسوم التوصيل',
            quantity: 1,
            price: 10.00,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem({
    required String name,
    required int quantity,
    required double price,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'الكمية: $quantity',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.grey600,
                    ),
              ),
            ],
          ),
        ),
        Text(
          '${price.toStringAsFixed(2)} ريال',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryGreen,
              ),
        ),
      ],
    );
  }

  Widget _buildDeliveryInfo() {
    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معلومات التوصيل',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.location_on,
            title: 'عنوان التوصيل',
            value: 'شارع الملك فهد، الرياض 12345',
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            icon: Icons.access_time,
            title: 'وقت التوصيل المتوقع',
            value: '30-45 دقيقة',
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            icon: Icons.payment,
            title: 'طريقة الدفع',
            value: 'نقداً عند الاستلام',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppTheme.primaryGreen,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.grey600,
                    ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Container(
      margin: const EdgeInsets.all(AppConstants.defaultPadding),
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تقييم الطلب',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Center(
            child: _buildStarRating(),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _feedbackController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'اكتب تعليقك عن الطلب (اختياري)',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryGreen),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isSubmittingRating ? null : _submitRating,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: AppTheme.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusL),
                ),
              ),
              child: _isSubmittingRating
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppTheme.white),
                      ),
                    )
                  : const Text(
                      'إرسال التقييم',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _rating = (index + 1).toDouble();
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(
              index < _rating ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: 32,
            ),
          ),
        );
      }),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'في الطريق':
        return Colors.orange;
      case 'تم التسليم':
        return AppTheme.primaryGreen;
      case 'ملغي':
        return AppTheme.errorRed;
      default:
        return AppTheme.grey600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الطلب'),
        centerTitle: true,
        backgroundColor: AppTheme.white,
        foregroundColor: AppTheme.textPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildOrderHeader(),
            const SizedBox(height: 16),
            _buildOrderItems(),
            const SizedBox(height: 16),
            _buildDeliveryInfo(),
            const SizedBox(height: 16),
            if (widget.order['status'] == 'تم التسليم') _buildRatingSection(),
          ],
        ),
      ),
    );
  }
}
