import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/order_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/theme_provider.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<AppThemeProvider>();
    final orderProvider = context.watch<OrderProvider>();

    return Scaffold(
      backgroundColor: themeProvider.isLightMode
          ? Colors.white
          : Colors.grey[900],
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: themeProvider.isLightMode
            ? Colors.white
            : Colors.grey[900],
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: themeProvider.isLightMode ? Colors.black : Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Orders',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: themeProvider.isLightMode ? Colors.black : Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: orderProvider.ordersList.isEmpty
          ? const Center(
              child: Text(
                'No orders placed yet.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orderProvider.ordersList.length,
              itemBuilder: (context, index) {
                final order = orderProvider.ordersList[index];
                return Card(
                  color: themeProvider.isLightMode
                      ? Colors.white
                      : Colors.grey[800],
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
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
                                color: themeProvider.isLightMode
                                    ? Colors.black
                                    : Colors.white,
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
                        Divider(
                          color: Colors.grey[400],
                          height: 20,
                          thickness: 0.5,
                        ),
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
                                color: themeProvider.isLightMode
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
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
                  ),
                );
              },
            ),
    );
  }
}
