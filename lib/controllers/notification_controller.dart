import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/models/notification_model.dart';
import 'package:new_furiniture_app_mvc/services/notification_services.dart';

class NotificationController extends GetxController {
  final NotificationService _notificationService = NotificationService();

  var notificationList = <NotificationModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;

      var rawData = await _notificationService.fetchNotifications();
      var convertedNotifications = rawData
          .map((json) => NotificationModel.fromJson(json))
          .toList();

      notificationList.assignAll(convertedNotifications);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Notifications Screen is not Load: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> MarkNotificationAsread(int index, int id) async {
    try {
      var Updatedata = await _notificationService.updatenotificationstatus(
        id,
        true,
      );
      NotificationModel olditem = notificationList[index];
      notificationList[index] = NotificationModel(
        id: olditem.id,
        title: Updatedata['title'] ?? olditem.title,
        description: 'Status successsfully Updated via PUT APi',
        imageUrl: olditem.imageUrl,
        isRead: true,
      );
      Get.snackbar(
        'PUT Success',
        '  Notification ID:$id marked as read on server',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'PUT Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> removeNotification(int index, int id) async {
    try {
      bool isDeleted = await _notificationService.deleteNotificationfromserver(
        id,
      );

      if (isDeleted) {
        notificationList.removeAt(index);
        Get.snackbar(
          'Notification',
          'Notification ID:$id permanently deleted from server',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
