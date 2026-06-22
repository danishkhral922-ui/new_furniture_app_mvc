import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/views/home/home.dart';
import 'package:new_furiniture_app_mvc/views/orders/orders.dart';

class Congrats extends StatelessWidget {
  const Congrats({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Success!',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 40),
              _buildSuccessIllustration(),
              const SizedBox(height: 40),
              const Text(
                'Your order will be delivered soon. Thank you for choosing our app!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              _buildPrimaryButton(context, isDarkMode),
              const SizedBox(height: 20),
              _buildSecondaryButton(context, isDarkMode),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIllustration() {
    return Stack(
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
    );
  }

  Widget _buildPrimaryButton(BuildContext context, bool isDarkMode) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDarkMode ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrderScreen()),
          );
        },
        child: Text(
          'Track Your Orders',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context, bool isDarkMode) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(color: isDarkMode ? Colors.white : Colors.black),
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false,
          );
        },
        child: Text(
          'BACK TO HOME',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
