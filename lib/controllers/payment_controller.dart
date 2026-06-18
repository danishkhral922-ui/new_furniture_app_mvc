import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/models/payment_model.dart';

class PaymentProvider extends ChangeNotifier {
  final cardHolderName = TextEditingController();
  final cardNumber = TextEditingController();
  final cvv = TextEditingController();
  final expiryDate = TextEditingController();

  PaymentModel currentPayment = PaymentModel(
    id: '',
    cardNumber: '**** **** **** 3947',
  );

  void savePaymentDetails() {
    String rawCard = cardNumber.text.trim();
    String maskedCard = rawCard;

    if (rawCard.length == 16) {
      maskedCard = '**** **** **** ${rawCard.substring(12, 16)}';
    }

    currentPayment = PaymentModel(
      id: DateTime.now().toString(),
      cardNumber: maskedCard.isNotEmpty
          ? maskedCard
          : currentPayment.cardNumber,
    );

    notifyListeners();
  }

  void updatePayment(PaymentModel newPayment) {
    currentPayment = newPayment;
    notifyListeners();
  }

  @override
  void dispose() {
    cardHolderName.dispose();
    cardNumber.dispose();
    cvv.dispose();
    expiryDate.dispose();
    super.dispose();
  }
}
