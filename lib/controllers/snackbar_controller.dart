import 'package:flutter/material.dart';

class SnackProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void login(BuildContext context) {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar(context, 'Error', 'Please fill all fields', Colors.red);
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      _showSnackBar(
        context,
        'Invalid Email',
        'Please enter valid email',
        Colors.red,
      );
      return;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
