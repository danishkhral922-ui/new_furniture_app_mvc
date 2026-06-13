import 'package:hive/hive.dart';
part 'shipping_model.g.dart';

@HiveType(typeId: 1)
class ShippingModel {
  @HiveField(0)
  String fullName;
  @HiveField(1)
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
