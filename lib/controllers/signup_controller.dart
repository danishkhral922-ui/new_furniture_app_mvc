import 'package:flutter/material.dart';

class SignupProvider extends ChangeNotifier {
  bool passwordHidden = true;
  bool confirmPasswordHidden = true;

  void togglePassword() {
    passwordHidden = !passwordHidden;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    confirmPasswordHidden = !confirmPasswordHidden;
    notifyListeners();
  }
}
