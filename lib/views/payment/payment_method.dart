import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/check_controller.dart';
import 'package:provider/provider.dart';
import 'package:new_furiniture_app_mvc/views/payment/add_pament.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final checkProvider = context.watch<CheckProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text(
          'Payment Methods',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            children: [
              _buildPaymentCard(
                imagePath: 'assets/images/Paymentcard.png',
                checkValue: checkProvider.check1,
                context: context,
                onSelectionChanged: (value) {
                  if (value) {
                    checkProvider.changeSelection(1);
                  }
                },
              ),
              const SizedBox(height: 20),

              _buildPaymentCard(
                imagePath: 'assets/images/Paymentcard2.png',
                checkValue: checkProvider.check2,
                context: context,
                onSelectionChanged: (value) {
                  if (value) {
                    checkProvider.changeSelection(2);
                  }
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        elevation: 4,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPayment()),
          );
        },
        child: Icon(Icons.add, color: isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }

  Widget _buildPaymentCard({
    required String imagePath,
    required bool checkValue,
    required BuildContext context,
    required ValueChanged<bool> onSelectionChanged,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Image.asset(imagePath, width: double.infinity, fit: BoxFit.contain),
        const SizedBox(height: 8),
        Row(
          children: [
            Checkbox(
              value: checkValue,
              checkColor: isDarkMode ? Colors.black : Colors.white,
              activeColor: isDarkMode ? Colors.white : Colors.black,
              onChanged: (value) {
                if (value != null) {
                  onSelectionChanged(value);
                }
              },
            ),
            Text(
              'Use as default payment method',
              style: TextStyle(
                fontSize: 14,
                fontWeight: checkValue ? FontWeight.bold : FontWeight.normal,
                color: checkValue
                    ? (isDarkMode ? Colors.white : Colors.black)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
