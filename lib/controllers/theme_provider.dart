import 'package:flutter/material.dart';

class AppThemeProvider with ChangeNotifier {
  bool _isLightMode = true;

  bool get isLightMode => _isLightMode;

  ThemeData get currentTheme {
    return _isLightMode
        ? ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white)
        : ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.grey[900]);
  }

  void toggleTheme() {
    _isLightMode = !_isLightMode;
    notifyListeners();
  }
}
