class ShippingModel {
  String fullName;
  String address;

  ShippingModel({required this.fullName, required this.address});

  factory ShippingModel.fromMap(Map<String, dynamic> map) {
    return ShippingModel(
      fullName: map['fullName'] ?? '',
      address: map['address'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'fullName': fullName, 'address': address};
  }
}
