import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/order_controller.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final orderProvider = context.watch<OrderProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'My Orders',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          if (orderProvider.ordersList.isEmpty) {
            return const Center(
              child: Text(
                'No orders placed yet.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orderProvider.ordersList.length,
            itemBuilder: (context, index) {
              final order = orderProvider.ordersList[index];
              return Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            order.orderNo,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            order.date,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity: ${order.quantity}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Total: \$${order.totalAmount}',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            order.status,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
