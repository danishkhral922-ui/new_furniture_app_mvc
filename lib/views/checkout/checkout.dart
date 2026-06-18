import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/cart_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/order_controller.dart';
import 'package:provider/provider.dart';
import 'package:new_furiniture_app_mvc/controllers/shipping_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/payment_controller.dart';
import 'package:new_furiniture_app_mvc/views/congrats/congrats.dart';
import 'package:new_furiniture_app_mvc/views/shipping/add_shipping_address.dart';
import 'package:new_furiniture_app_mvc/views/payment/add_pament.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cartProvider = context.watch<CartProvider>();
    final shippingProvider = context.watch<ShippingProvider>();
    final paymentProvider = context.watch<PaymentProvider>();
    final orderProvider = context.read<OrderProvider>();

    final shippingVal = shippingProvider.currentShipping;
    final paymentVal = paymentProvider.currentPayment;

    final isShippingEmpty = shippingVal == null;
    final isPaymentEmpty = paymentVal == null || paymentVal.cardNumber.isEmpty;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddShippingAddress(),
                              ),
                            );
                          },
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
                              Text(
                                isShippingEmpty
                                    ? 'Click edit to add name'
                                    : shippingVal.fullName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: isShippingEmpty
                                      ? Colors.red[300]
                                      : (isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                                ),
                              ),
                              Divider(color: Colors.grey[200], thickness: 2),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  isShippingEmpty
                                      ? 'No Shipping Address Added Yet'
                                      : shippingVal.address,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.grey,
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddPayment(),
                              ),
                            );
                          },
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
                            Text(
                              isPaymentEmpty
                                  ? 'Click edit to add card details'
                                  : paymentVal.cardNumber,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: isPaymentEmpty
                                    ? Colors.red[300]
                                    : (isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                              ),
                            ),
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
                                  Text(
                                    '\$ ${cartProvider.totalPrice().toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
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
                                  Text(
                                    '\$ ${(cartProvider.totalPrice() + 5).toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
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
                  if (isShippingEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please add your shipping address details first.',
                        ),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }

                  if (isPaymentEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please add your card information details first.',
                        ),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }

                  try {
                    await orderProvider.placeNewOrder(
                      totalQty: cartProvider.cartItems.length.toString(),
                      finalAmount: cartProvider.totalPrice() + 5,
                    );

                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Congrats(),
                        ),
                        (route) => false,
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Something went wrong: $e'),
                          backgroundColor: Colors.orange,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
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
