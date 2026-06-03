import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/models/payment_model.dart';

class PaymentController extends GetxController {
  final cardHolderName = TextEditingController();
  final cardNumber = TextEditingController();
  final cvv = TextEditingController();
  final expiryDate = TextEditingController();

  var currentPayment = PaymentModel(
    id: '',
    cardNumber: '**** **** **** 3947',
  ).obs;

  void updatePayment(PaymentModel newPayment) {
    currentPayment.value = newPayment;
  }

  @override
  void onClose() {
    cardHolderName.dispose();
    cardNumber.dispose();
    cvv.dispose();
    expiryDate.dispose();
    super.onClose();
  }
}
