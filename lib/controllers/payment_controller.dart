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
  void savepaymentdetails() {
    String rawcard = cardNumber.text.trim();
    String maskedcard = rawcard;

    if (rawcard.length == 16) {
      maskedcard = '**** **** **** ${rawcard.substring(12, 16)}';
    }
    currentPayment.value = PaymentModel(
      id: DateTime.now().toString(),
      cardNumber: maskedcard.isNotEmpty
          ? maskedcard
          : currentPayment.value.cardNumber,
    );
  }

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
