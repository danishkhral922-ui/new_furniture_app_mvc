import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/controllers/cart_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/order_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/payment_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/shipping_controller.dart';
import 'package:new_furiniture_app_mvc/views/congrats/congrats.dart';
import 'package:new_furiniture_app_mvc/views/payment/add_pament.dart';
import 'package:new_furiniture_app_mvc/views/shipping/add_shipping_address.dart';

class Checkout extends StatelessWidget {
  Checkout({super.key});

  final CartController controller = Get.put(CartController());
  final ShippingController shippingController = Get.put(ShippingController());
  final PaymentController paymentController = Get.put(PaymentController());
  final OrderController ordercontroller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Check Out',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Shipping Address',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.to(() => AddShippingAddress()),
                          child: Image.asset(
                            'assets/images/edit.png',
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 127,
                      width: 335,
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Text(
                                  shippingController
                                          .currentShipping
                                          .value
                                          ?.fullName ??
                                      'Click edit to add name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color:
                                        shippingController
                                                .currentShipping
                                                .value ==
                                            null
                                        ? Colors.red[300]
                                        : (isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                  ),
                                ),
                              ),
                              Divider(color: Colors.grey[200], thickness: 2),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Obx(
                                  () => Text(
                                    shippingController
                                            .currentShipping
                                            .value
                                            ?.address ??
                                        'No Shipping Address Added Yet',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Payment',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.to(() => AddPayment()),
                          child: Image.asset(
                            'assets/images/edit.png',
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 68,
                      width: 335,
                      child: Card(
                        elevation: 4,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Image.asset(
                                'assets/images/card.png',
                                color: isDarkMode ? Colors.white : null,
                              ),
                            ),
                            Obx(() {
                              final paymentVal =
                                  paymentController.currentPayment.value;
                              final isEmpty =
                                  paymentVal == null ||
                                  paymentVal.cardNumber.isEmpty;
                              return Text(
                                isEmpty
                                    ? 'Click edit to add card details'
                                    : paymentVal.cardNumber,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: isEmpty
                                      ? Colors.red[300]
                                      : (isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Delivery Methods',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Image.asset(
                          'assets/images/edit.png',
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 68,
                      width: 335,
                      child: Card(
                        elevation: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Image.asset('assets/images/dhl.png'),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              'Fast (2-3 days)',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 135,
                      width: 335,
                      child: Card(
                        elevation: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    ' Order :',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    ' Delivery: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    ' Total:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Obx(
                                    () => Text(
                                      '\$ ${controller.totalPrice().toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '\$ 5.00',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      '\$ ${(controller.totalPrice() + 5).toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              height: 60,
              width: 335,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: isDarkMode ? Colors.white : Colors.black,
                ),
                onPressed: () async {
                  if (shippingController.currentShipping.value == null) {
                    Get.snackbar(
                      'Missing Address',
                      'Please add your shipping address details first.',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  final paymentVal = paymentController.currentPayment.value;
                  if (paymentVal == null || paymentVal.cardNumber.isEmpty) {
                    Get.snackbar(
                      'Missing Payment',
                      'Please add your card information details first.',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  try {
                    await ordercontroller.placeNewOrder(
                      totalQty: controller.cartItems.length.toString(),
                      finalAmount: controller.totalPrice() + 5,
                    );

                    Get.offAll(() => const Congrats());
                  } catch (e) {
                    Get.snackbar(
                      'Error',
                      'Something went wrong: $e',
                      backgroundColor: Colors.orange,
                      colorText: Colors.white,
                    );
                  }
                },
                child: Text(
                  'SUBMIT ORDER',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
