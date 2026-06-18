import 'package:flutter/material.dart';

class AppthemeProvider with ChangeNotifier {
  bool _islightMode = true;
  bool get islightMode => _islightMode;
  ThemeData get currentTheme {
    return _islightMode
        ? ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white)
        : ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.grey[900]);
  }

  void toggleTheme() {
    _islightMode = !_islightMode;
    notifyListeners();
  }
}
