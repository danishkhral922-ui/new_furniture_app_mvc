import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/cart_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/order_controller.dart';
import 'package:provider/provider.dart';
import 'package:new_furiniture_app_mvc/views/congrats/congrats.dart';
import 'package:new_furiniture_app_mvc/views/shipping/add_shipping_address.dart';
import 'package:new_furiniture_app_mvc/views/payment/add_pament.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Check Out',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              centerTitle: true,
            ),
            body: _buildBody(context, isDarkMode),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, bool isDarkMode) {
    final cartProvider = context.watch<CartProvider>();
    final orderProvider = context.read<OrderProvider>();

    final double subtotal = cartProvider.totalPrice();
    final double total = subtotal + 5.00;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildSectionTitle('Shipping Address'),
                _buildInfoCard(
                  context,
                  'Bruno Fernandes',
                  '25 rue Robert Latouche, Nice, 06200, Côte D’azur, France',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddShippingAddress(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildSectionTitle('Payment'),
                _buildInfoCard(
                  context,
                  '**** **** **** 3947',
                  'Mastercard',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddPayment()),
                  ),
                ),
                const SizedBox(height: 20),
                _buildSectionTitle('Order Summary'),
                _buildSummaryRow('Order:', '\$ ${subtotal.toStringAsFixed(2)}'),
                _buildSummaryRow('Delivery:', '\$ 5.00'),
                _buildSummaryRow('Total:', '\$ ${total.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.white : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                await orderProvider.placeNewOrder(
                  totalQty: cartProvider.cartItems.length.toString(),
                  finalAmount: total,
                );
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const Congrats()),
                  );
                }
              },
              child: Text(
                'SUBMIT ORDER',
                style: TextStyle(
                  color: isDarkMode ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: IconButton(
          icon: const Icon(Icons.edit, size: 18),
          onPressed: onTap,
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
