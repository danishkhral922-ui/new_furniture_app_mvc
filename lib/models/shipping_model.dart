class ShippingModel {
  final String id;
  final String fullName;
  final String address;

  ShippingModel({
    required this.id,
    required this.fullName,
    required this.address,
  });

  factory ShippingModel.fromFirestore(String id, Map<String, dynamic> data) {
    return ShippingModel(
      id: id,
      fullName: data['fullName'] ?? '',
      address: data['address'] ?? '',
    );
  }
}
