class OrderModel {
  final String orderNo;
  final String date;
  final String quantity;
  final String totalAmount;
  final String status;

  OrderModel({
    required this.orderNo,
    required this.date,
    required this.quantity,
    required this.totalAmount,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderNo': orderNo,
      'date': date,
      'quantity': quantity,
      'totalAmount': totalAmount,
      'status': status,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderNo: map['orderNo'] ?? '',
      date: map['date'] ?? '',
      quantity: map['quantity'] ?? '',
      totalAmount: map['totalAmount'] ?? '',
      status: map['status'] ?? '',
    );
  }
}
