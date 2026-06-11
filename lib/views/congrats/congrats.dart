import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/views/home/home.dart';
import 'package:new_furiniture_app_mvc/views/orders/orders.dart';

class Congrats extends StatelessWidget {
  const Congrats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Center(
              child: Text(
                'Success!',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset('assets/images/sucesspic1.png'),
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: Image.asset('assets/images/sucesspic.png'),
                  ),
                  Positioned(
                    bottom: -30,
                    right: 110,
                    child: Image.asset('assets/images/checkmark.png'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Your order will be delivered soon. Thank you for choosing our app!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 60,
              width: 335,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.black,
                  elevation: 0,
                ),
                onPressed: () => Get.to(() => OrderScreen()),
                child: const Text(
                  'Track Your Orders',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 60,
              width: 335,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(color: Colors.black),
                  backgroundColor: Colors.white,
                ),
                onPressed: () => Get.offAll(() => Home()),
                child: const Text(
                  'BACK TO HOME',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
