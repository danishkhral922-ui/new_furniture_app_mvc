class PaymentModel {
  final String id;
  final String cardNumber;

  PaymentModel({required this.id, required this.cardNumber});

  factory PaymentModel.fromFirestore(String id, Map<String, dynamic> data) {
    return PaymentModel(
      id: id,
      cardNumber: data['cardNumber'] ?? '**** **** **** 0000',
    );
  }
}
