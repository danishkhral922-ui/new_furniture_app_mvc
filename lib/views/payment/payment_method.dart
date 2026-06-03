import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/controllers/check_controller.dart';
import 'package:new_furiniture_app_mvc/views/payment/add_pament.dart';

class PaymentMethods extends StatelessWidget {
  PaymentMethods({super.key});

  final CheckController controller = Get.put(CheckController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text(
          'Payment Methods',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
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
              ),
              const SizedBox(height: 20),

              // Second Payment Card
              _buildPaymentCard(
                imagePath: 'assets/images/Paymentcard2.png',
                rxCheckValue: controller.check2,
              ),
              const SizedBox(height: 100), // FAB ke liye safe bottom space
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 4,
        shape: const CircleBorder(),
        onPressed: () => Get.to(() => AddPayment()),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  // Reusable Payment Card Method
  Widget _buildPaymentCard({
    required String imagePath,
    required RxBool rxCheckValue,
  }) {
    return Column(
      children: [
        Image.asset(imagePath, width: double.infinity, fit: BoxFit.contain),
        const SizedBox(height: 8),
        Obx(
          () => Row(
            children: [
              Checkbox(
                value: rxCheckValue.value,
                checkColor: Colors.white,
                activeColor: Colors.black,
                onChanged: (value) {
                  if (value != null) {
                    rxCheckValue.value = value;
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
                  color: rxCheckValue.value ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
