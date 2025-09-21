import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تاريخ الطلبات"),
      ),
      body: const Center(
        child: Text("تاريخ الطلبات"),
      ),
    );
  }
}
