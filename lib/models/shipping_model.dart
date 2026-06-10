class ShippingModel {
  String fullName;
  String address;

  ShippingModel({required this.fullName, required this.address});

  // Map (Firebase JSON) ko Model object mein convert karne ke liye
  factory ShippingModel.fromMap(Map<String, dynamic> map) {
    return ShippingModel(
      fullName: map['fullName'] ?? '',
      address: map['address'] ?? '',
    );
  }

  // Model object ko Map (Firebase JSON) mein convert karne ke liye
  Map<String, dynamic> toMap() {
    return {'fullName': fullName, 'address': address};
  }
}
