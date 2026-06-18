import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/order_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/profile_controller.dart';
import 'package:provider/provider.dart';
import 'package:new_furiniture_app_mvc/views/auth/auth_wrapper.dart';
import 'package:new_furiniture_app_mvc/views/orders/orders.dart';
import 'package:new_furiniture_app_mvc/views/payment/payment_method.dart';
import 'package:new_furiniture_app_mvc/views/profile/rating_reviews.dart';
import 'package:new_furiniture_app_mvc/views/profile/settings.dart';
import 'package:new_furiniture_app_mvc/views/shipping/add_shipping.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final profileProvider = context.watch<ProfileProvider>();
    final orderProvider = context.watch<OrderProvider>();

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
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthWrapper(),
                    ),
                    (route) => false,
                  );
                }
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
                      Text(
                        profileProvider.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        profileProvider.userEmail,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildMenuTile(
                title: 'My orders',
                subtitle:
                    'Already have ${orderProvider.ordersList.length} orders',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildMenuTile(
                title: 'Shipping Addresses',
                subtitle: '03 Addresses',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShoppingAddress()),
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildMenuTile(
                title: 'Payment Method',
                subtitle: 'You have 2 cards',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentMethods()),
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildMenuTile(
                title: 'My reviews',
                subtitle: 'Reviews for 5 items',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RatingReviews(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildMenuTile(
                title: 'Setting',
                subtitle: 'Notification, Password, FAQ, Contact',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Setting()),
                  );
                },
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
