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
        surfaceTintColor: Colors.white,
        leading: const Icon(Icons.search),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const AuthWrapper()),
                    (route) => false,
                  );
                }
              },
              icon: Image.asset(
                'assets/images/forward.png',
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/images/profile.png', height: 80, width: 80),
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
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildMenuTile(
              context,
              'My orders',
              'Already have ${orderProvider.ordersList.length} orders',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrderScreen()),
              ),
            ),
            _buildMenuTile(
              context,
              'Shipping Addresses',
              '03 Addresses',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ShoppingAddress()),
              ),
            ),
            _buildMenuTile(
              context,
              'Payment Method',
              'You have 2 cards',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PaymentMethods()),
              ),
            ),
            _buildMenuTile(
              context,
              'My reviews',
              'Reviews for 5 items',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RatingReviews()),
              ),
            ),
            _buildMenuTile(
              context,
              'Setting',
              'Notification, Password, FAQ, Contact',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Setting()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile(
    BuildContext context,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey.withAlpha(60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          onTap: onTap,
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
    );
  }
}
