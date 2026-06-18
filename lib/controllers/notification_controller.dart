import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/models/notification_model.dart';
import 'package:new_furiniture_app_mvc/services/notification_services.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();

  List<NotificationModel> _notificationList = [];
  bool _isLoading = true;

  NotificationProvider() {
    fetchNotifications();
  }

  List<NotificationModel> get notificationList => _notificationList;
  bool get isLoading => _isLoading;

  Future<void> fetchNotifications() async {
    try {
      _isLoading = true;
      notifyListeners();

      final rawData = await _notificationService.fetchNotifications();
      _notificationList = rawData
          .map((json) => NotificationModel.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint('Error loading notifications: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> markNotificationAsRead(int index, int id) async {
    try {
      final updateData = await _notificationService.updatenotificationstatus(
        id,
        true,
      );

      final oldItem = _notificationList[index];
      _notificationList[index] = NotificationModel(
        id: oldItem.id,
        title: updateData['title'] ?? oldItem.title,
        description: 'Status successfully Updated via PUT API',
        imageUrl: oldItem.imageUrl,
        isRead: true,
      );

      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error updating notification status: $e');
      return false;
    }
  }

  Future<bool> removeNotification(int index, int id) async {
    try {
      final isDeleted = await _notificationService.deleteNotificationfromserver(
        id,
      );

      if (isDeleted) {
        _notificationList.removeAt(index);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error deleting notification: $e');
      return false;
    }
  }
}
