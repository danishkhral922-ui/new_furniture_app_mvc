import 'package:flutter/material.dart';

class SwitchProvider extends ChangeNotifier {
  bool switch1 = true;
  bool switch2 = false;

  void toggleSwitch1() {
    switch1 = !switch1;
    notifyListeners();
  }

  void toggleSwitch2() {
    switch2 = !switch2;
    notifyListeners();
  }

  void setSwitch1(bool value) {}
}
