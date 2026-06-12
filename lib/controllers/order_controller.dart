import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import '../models/order_model.dart';
import '../services/order_services.dart';

class OrderController extends GetxController {
  final OrderService _orderService = OrderService();
  var ordersList = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    ordersList.bindStream(_orderService.getOrdersStream());
  }

  Future<void> placeNewOrder({
    required String totalQty,
    required double finalAmount,
  }) async {
    try {
      String randomOrderNo =
          'Order No. ${Random().nextInt(900000000) + 100000000}';
      String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

      OrderModel newOrder = OrderModel(
        orderNo: randomOrderNo,
        date: currentDate,
        quantity: totalQty,
        totalAmount: finalAmount.toString(),
        status: 'Processing',
      );

      await _orderService.saveOrder(newOrder);
      Get.snackbar(
        'Success',
        'Order Placed Successfully',
        colorText: Colors.white,
        backgroundColor: Colors.green[400],
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to place order: $e',
        colorText: Colors.white,
        backgroundColor: Colors.red[400],
        snackPosition: SnackPosition.TOP,
      );
      rethrow;
    }
  }
}
