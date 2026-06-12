import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var userName = 'Loading...'.obs;
  var userEmail = 'Loading...'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() {
    String? uid = _auth.currentUser?.uid;
    if (uid != null) {
      userEmail.value = _auth.currentUser?.email ?? 'No Email';

      _firestore.collection('users').doc(uid).snapshots().listen((snapshot) {
        if (snapshot.exists && snapshot.data() != null) {
          userName.value = snapshot.data()?['name'] ?? 'No Name';
        } else {
          userName.value = _auth.currentUser?.displayName ?? 'User';
        }
      }, onError: (error) {});
    }
  }

  Future<void> updateProfile(String newName) async {
    try {
      String? uid = _auth.currentUser?.uid;
      if (uid != null) {
        await _firestore.collection('users').doc(uid).set({
          'name': newName,
          'email': userEmail.value,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        await _auth.currentUser?.updateDisplayName(newName);

        userName.value = newName;

        Get.snackbar(
          'Success',
          'Profile updated successfully!',
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save data: $e',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
