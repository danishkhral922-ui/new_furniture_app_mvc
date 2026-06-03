import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/views/congrats/congrats.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: const Icon(Icons.search),
        centerTitle: true,
        title: GestureDetector(
          onTap: () => Get.to(() => const Congrats()),
          child: const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: ListView(
        children: const [
          NotificationTile(
            imagePath: 'assets/images/minimalstand2.png',
            title: 'Your order #123456789 has been confirmed',
            isRead: false,
          ),
          NotificationTile(
            imagePath: 'assets/images/minimallamp2.png',
            title: 'Your order #123456789 has been Canceled',
            isRead: true,
          ),
          NotificationTile(
            title: 'Discover hot sale furnitures this week.',
            isRead: false,
            hasImage: false,
          ),
          NotificationTile(
            imagePath: 'assets/images/coffeetable2.png',
            title: 'Your order #123456789 has been Shipped Successfully',
            isRead: true,
          ),
          NotificationTile(
            imagePath: 'assets/images/coffeetable2.png',
            title: 'Your order #123456789 has been Confirmed',
            isRead: true,
          ),
          NotificationTile(
            imagePath: 'assets/images/minimaldesk2.png',
            title: 'Your order #123456789 has been Canceled',
            isRead: true,
          ),
          NotificationTile(
            imagePath: 'assets/images/coffeetable2.png',
            title: 'Your order #123456789 has been shipped Successfully',
            isRead: true,
          ),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String? imagePath;
  final String title;
  final bool isRead;
  final bool hasImage;

  const NotificationTile({
    super.key,
    this.imagePath,
    required this.title,
    required this.isRead,
    this.hasImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 1),
      color: isRead ? Colors.white : Colors.grey[200],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasImage && imagePath != null) ...[
            SizedBox(
              height: 70,
              width: 70,
              child: Image.asset(imagePath!, fit: BoxFit.cover),
            ),
            const SizedBox(width: 10),
          ] else ...[
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Turpis pretium et in arcu adipiscing nec. Turpis pretium et in arcu adipiscing nec.',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
