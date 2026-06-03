import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_furiniture_app_mvc/views/home/home.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  Future<void> signUp() async {
    if (passwordController.text.trim() !=
        confirmpasswordController.text.trim()) {
      Get.snackbar(
        'Error',
        'Passwords do no match',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    try {
      User? user = (await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )).user;

      if (user != null) {
        await firestore.collection('users').doc(user.uid).set({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'uid': user.uid,
        });

        Get.snackbar(
          'Success',
          'Account Created Successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'Something went wrong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> login() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Get.snackbar(
        'Success',
        'Login Successful',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAll(Home());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'Something went wrong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    Get.snackbar(
      'Logout',
      'User Logged Out',
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmpasswordController.dispose();
    super.onClose();
  }
}
