import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_furiniture_app_mvc/views/home/home.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  void _showSnackBar(
    BuildContext context,
    String title,
    String message,
    Color bgColor,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title: $message'),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> signUp(BuildContext context) async {
    if (passwordController.text.trim() !=
        confirmpasswordController.text.trim()) {
      _showSnackBar(
        context,
        'Error',
        'Passwords do not match',
        Colors.red[400]!,
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

        _showSnackBar(
          context,
          'Success',
          'Account Created Successfully',
          Colors.green[400]!,
        );
      }
    } on FirebaseAuthException catch (e) {
      _showSnackBar(
        context,
        'Error',
        e.message ?? 'Something went wrong',
        Colors.red[400]!,
      );
    }
  }

  Future<void> login(BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      _showSnackBar(context, 'Success', 'Login Successful', Colors.green[400]!);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      _showSnackBar(
        context,
        'Error',
        e.message ?? 'Something Went Wrong',
        Colors.red[400]!,
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    await auth.signOut();
    _showSnackBar(context, 'Logout', 'User Logged Out', Colors.orange[400]!);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }
}
