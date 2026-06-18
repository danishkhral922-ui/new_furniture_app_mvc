import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/controllers/check_controller.dart';
import 'package:new_furiniture_app_mvc/views/payment/add_pament.dart';

class PaymentMethods extends StatelessWidget {
  PaymentMethods({super.key});

  final CheckController controller = Get.put(CheckController());

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
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
              // First Payment Card
              _buildPaymentCard(
                imagePath: 'assets/images/Paymentcard.png',
                rxCheckValue: controller.check1,
                context: context,
                onSelectionChanged: (value) {
                  if (value) {
                    controller.check2.value = false;
                  }
                },
              ),
              const SizedBox(height: 20),

              // Second Payment Card
              _buildPaymentCard(
                imagePath: 'assets/images/Paymentcard2.png',
                rxCheckValue: controller.check2,
                context: context,
                onSelectionChanged: (value) {
                  if (value) {
                    controller.check1.value = false;
                  }
                },
              ),
              const SizedBox(height: 100), // Space for FAB
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        elevation: 4,
        shape: const CircleBorder(),
        onPressed: () => Get.to(() => AddPayment()),
        child: Icon(Icons.add, color: isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }

  // Reusable Payment Card Method - Free from hardcoded controller binds
  Widget _buildPaymentCard({
    required String imagePath,
    required RxBool rxCheckValue,
    required BuildContext context,
    required ValueChanged<bool> onSelectionChanged,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Image.asset(imagePath, width: double.infinity, fit: BoxFit.contain),
        const SizedBox(height: 8),
        Obx(
          () => Row(
            children: [
              Checkbox(
                value: rxCheckValue.value,
                checkColor: isDarkMode ? Colors.black : Colors.white,
                activeColor: isDarkMode ? Colors.white : Colors.black,
                onChanged: (value) {
                  if (value != null) {
                    rxCheckValue.value = value;
                    onSelectionChanged(value);
                  }
                },
              ),
              Text(
                'Use as default payment method',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: rxCheckValue.value
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: rxCheckValue.value
                      ? (isDarkMode ? Colors.white : Colors.black)
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
