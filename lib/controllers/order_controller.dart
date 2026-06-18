import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/order_model.dart';
import '../services/order_services.dart';

class OrderProvider extends ChangeNotifier {
  final OrderService _orderService = OrderService();

  List<OrderModel> _ordersList = [];
  StreamSubscription<List<OrderModel>>? _ordersSubscription;

  OrderProvider() {
    _initOrdersStream();
  }

  List<OrderModel> get ordersList => _ordersList;

  void _initOrdersStream() {
    _ordersSubscription = _orderService.getOrdersStream().listen(
      (orders) {
        _ordersList = orders;
        notifyListeners();
      },
      onError: (error) {
        debugPrint('Error in orders stream: $error');
      },
    );
  }

  Future<void> placeNewOrder({
    required String totalQty,
    required double finalAmount,
  }) async {
    try {
      final String randomOrderNo =
          'Order No. ${Random().nextInt(900000000) + 100000000}';
      final String currentDate = DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.now());

      final OrderModel newOrder = OrderModel(
        orderNo: randomOrderNo,
        date: currentDate,
        quantity: totalQty,
        totalAmount: finalAmount.toString(),
        status: 'Processing',
      );

      await _orderService.saveOrder(newOrder);
    } catch (e) {
      debugPrint('Failed to place order: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    _ordersSubscription?.cancel();
    super.dispose();
  }
}
