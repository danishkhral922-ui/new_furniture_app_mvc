import 'package:get/get.dart';

class CheckController extends GetxController {
  RxBool check1 = true.obs;
  RxBool check2 = false.obs;
  RxBool check3 = false.obs;

  void changeSelection(int index) {
    check1.value = index == 1;
    check2.value = index == 2;
    check3.value = index == 3;
  }
}
