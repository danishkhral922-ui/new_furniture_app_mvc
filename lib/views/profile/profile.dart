import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/controllers/order_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/profile_controller.dart';
import 'package:new_furiniture_app_mvc/views/auth/auth_wrapper.dart';
import 'package:new_furiniture_app_mvc/views/orders/orders.dart';
import 'package:new_furiniture_app_mvc/views/payment/payment_method.dart';
import 'package:new_furiniture_app_mvc/views/profile/rating_reviews.dart';
import 'package:new_furiniture_app_mvc/views/profile/settings.dart';
import 'package:new_furiniture_app_mvc/views/shipping/add_shipping.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final ProfileController profileController = Get.put(ProfileController());
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.search),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Get.deleteAll();
                Get.offAll(() => const AuthWrapper());
              },
              child: Image.asset(
                'assets/images/forward.png',
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/images/profile.png'),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          profileController.userName.value,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          profileController.userEmail.value,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Obx(
                () => _buildMenuTile(
                  title: 'My orders',
                  subtitle:
                      'Already have ${orderController.ordersList.length} orders',
                  onTap: () => Get.to(() => OrderScreen()),
                ),
              ),
              const SizedBox(height: 15),
              _buildMenuTile(
                title: 'Shipping Addresses',
                subtitle: '03 Addresses',
                onTap: () => Get.to(() => ShoppingAddress()),
              ),
              const SizedBox(height: 15),
              _buildMenuTile(
                title: 'Payment Method',
                subtitle: 'You have 2 cards',
                onTap: () => Get.to(() => PaymentMethods()),
              ),
              const SizedBox(height: 15),
              _buildMenuTile(
                title: 'My reviews',
                subtitle: 'Reviews for 5 items',
                onTap: () => Get.to(() => const RatingReviews()),
              ),
              const SizedBox(height: 15),
              _buildMenuTile(
                title: 'Setting',
                subtitle: 'Notification, Password, FAQ, Contact',
                onTap: () => Get.to(() => Setting()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 80,
        width: 335,
        child: Card(
          shadowColor: Colors.grey.withAlpha(60),
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
