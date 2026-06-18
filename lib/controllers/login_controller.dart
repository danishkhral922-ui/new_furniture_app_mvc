import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isHidden = true;

  bool get isHidden => _isHidden;

  void togglePassword() {
    _isHidden = !_isHidden;
    notifyListeners();
  }
}
