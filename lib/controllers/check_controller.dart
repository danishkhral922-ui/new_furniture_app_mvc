import 'package:flutter/material.dart';

class CheckProvider extends ChangeNotifier {
  bool _check1 = true;
  bool _check2 = false;
  bool _check3 = false;

  bool get check1 => _check1;
  bool get check2 => _check2;
  bool get check3 => _check3;

  void changeSelection(int index) {
    _check1 = index == 1;
    _check2 = index == 2;
    _check3 = index == 3;
    notifyListeners();
  }
}
