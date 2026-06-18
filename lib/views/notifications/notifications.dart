import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/notification_controller.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.search),
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).iconTheme.color,
              ),
            );
          }

          if (provider.notificationList.isEmpty) {
            return const Center(
              child: Text(
                'No new notifications available',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.notificationList.length,
            itemBuilder: (context, index) {
              final notification = provider.notificationList[index];

              return Dismissible(
                key: Key(notification.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  final success = await context
                      .read<NotificationProvider>()
                      .removeNotification(index, notification.id);
                  return success;
                },
                child: GestureDetector(
                  onTap: () {
                    context.read<NotificationProvider>().markNotificationAsRead(
                      index,
                      notification.id,
                    );
                  },
                  child: NotificationTile(
                    title: notification.title,
                    description: notification.description,
                    isRead: notification.isRead,
                    imageUrl: notification.imageUrl,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final bool isRead;

  const NotificationTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 1),
      color: isRead
          ? Colors.transparent
          : (isDarkMode ? Colors.grey[800] : Colors.grey[200]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
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
