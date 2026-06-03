import 'package:get/get.dart';

class SignupController extends GetxController {
  RxBool passwordHidden = true.obs;

  RxBool confirmPasswordHidden = true.obs;

  void togglePassword() {
    passwordHidden.value = !passwordHidden.value;
  }

  void toggleConfirmPassword() {
    confirmPasswordHidden.value = !confirmPasswordHidden.value;
  }
}
