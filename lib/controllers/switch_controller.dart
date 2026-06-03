import 'package:get/get.dart';

class SwitchController extends GetxController {
  RxBool switch1 = true.obs;
  RxBool switch2 = false.obs;

  void toggleSwitch1() => switch1.toggle();
  void toggleSwitch2() => switch2.toggle();
}
