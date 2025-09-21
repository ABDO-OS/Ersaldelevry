import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../components/order_card.dart';
import 'order_details_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Sample orders data
  final List<Map<String, dynamic>> _allOrders = [
    {
      'restaurantName': 'مطعم الدجاج المقلي الشهير',
      'orderId':
          'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
      'orderDate': 'منذ ساعة',
      'status': 'في الطريق',
      'totalAmount': 145.75,
    },
    {
      'restaurantName': 'مطعم البيتزا الإيطالي',
      'orderId':
          'ORD-${(DateTime.now().millisecondsSinceEpoch - 1000000).toString().substring(8)}',
      'orderDate': 'منذ 3 ساعات',
      'status': 'تم التسليم',
      'totalAmount': 89.50,
    },
    {
      'restaurantName': 'مطعم البرجر الأمريكي',
      'orderId':
          'ORD-${(DateTime.now().millisecondsSinceEpoch - 2000000).toString().substring(8)}',
      'orderDate': 'منذ يوم',
      'status': 'تم التسليم',
      'totalAmount': 67.25,
    },
    {
      'restaurantName': 'مطعم الشاورما التركي',
      'orderId':
          'ORD-${(DateTime.now().millisecondsSinceEpoch - 3000000).toString().substring(8)}',
      'orderDate': 'منذ 3 أيام',
      'status': 'تم التسليم',
      'totalAmount': 112.00,
    },
    {
      'restaurantName': 'مطعم السوشي الياباني',
      'orderId':
          'ORD-${(DateTime.now().millisecondsSinceEpoch - 4000000).toString().substring(8)}',
      'orderDate': 'منذ أسبوع',
      'status': 'تم التسليم',
      'totalAmount': 234.75,
    },
    {
      'restaurantName': 'مطعم المأكولات البحرية',
      'orderId':
          'ORD-${(DateTime.now().millisecondsSinceEpoch - 5000000).toString().substring(8)}',
      'orderDate': 'منذ أسبوعين',
      'status': 'ملغي',
      'totalAmount': 189.50,
    },
    {
      'restaurantName': 'مطعم الشاورما التركي',
      'orderId':
          'ORD-${(DateTime.now().millisecondsSinceEpoch - 6000000).toString().substring(8)}',
      'orderDate': 'منذ شهر',
      'status': 'ملغي',
      'totalAmount': 78.25,
    },
  ];

  List<Map<String, dynamic>> _getOrdersByStatus(String status) {
    return _allOrders.where((order) => order['status'] == status).toList();
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return OrderCard(
      restaurantName: order['restaurantName'],
      orderId: order['orderId'],
      orderDate: order['orderDate'],
      status: order['status'],
      totalAmount: order['totalAmount'],
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(order: order),
          ),
        );
      },
      onReorder: order['status'] == 'تم التسليم'
          ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم إضافة الطلب إلى السلة'),
                  backgroundColor: AppTheme.primaryGreen,
                ),
              );
            }
          : null,
    );
  }

  Widget _buildEmptyState(String status) {
    String message = '';
    switch (status) {
      case 'في الطريق':
        message = 'لا توجد طلبات في الطريق حالياً';
        break;
      case 'تم التسليم':
        message = 'لا توجد طلبات مكتملة بعد';
        break;
      case 'ملغي':
        message = 'لا توجد طلبات ملغية';
        break;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            size: 64,
            color: AppTheme.grey500,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppTheme.grey600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'اطلب من مطعمك المفضل وستظهر طلباتك هنا',
            style: TextStyle(
              color: AppTheme.grey600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.orders),
        centerTitle: true,
        bottom: TabBar(
          dividerHeight: 0,
          controller: _tabController,
          indicator: BoxDecoration(
            color: AppTheme.primaryGreen,
            borderRadius: BorderRadius.circular(AppTheme.radiusL),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.symmetric(
            horizontal: AppConstants.smallPadding,
            vertical: AppConstants.smallPadding,
          ),
          labelColor: AppTheme.white,
          unselectedLabelColor: AppTheme.grey600,
          labelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          tabs: const [
            Tab(text: 'في الطريق'),
            Tab(text: 'تم التسليم'),
            Tab(text: 'ملغي'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // في الطريق tab
          _getOrdersByStatus('في الطريق').isEmpty
              ? _buildEmptyState('في الطريق')
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.defaultPadding,
                  ),
                  itemCount: _getOrdersByStatus('في الطريق').length,
                  itemBuilder: (context, index) {
                    final order = _getOrdersByStatus('في الطريق')[index];
                    return _buildOrderCard(order);
                  },
                ),

          // تم التسليم tab
          _getOrdersByStatus('تم التسليم').isEmpty
              ? _buildEmptyState('تم التسليم')
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.defaultPadding,
                  ),
                  itemCount: _getOrdersByStatus('تم التسليم').length,
                  itemBuilder: (context, index) {
                    final order = _getOrdersByStatus('تم التسليم')[index];
                    return _buildOrderCard(order);
                  },
                ),

          // ملغي tab
          _getOrdersByStatus('ملغي').isEmpty
              ? _buildEmptyState('ملغي')
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.defaultPadding,
                  ),
                  itemCount: _getOrdersByStatus('ملغي').length,
                  itemBuilder: (context, index) {
                    final order = _getOrdersByStatus('ملغي')[index];
                    return _buildOrderCard(order);
                  },
                ),
        ],
      ),
    );
  }
}
