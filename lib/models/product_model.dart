import 'package:hive_flutter/hive_flutter.dart';
part 'product_model.g.dart';

@HiveType(typeId: 2)
class ProductModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String price;
  @HiveField(3)
  final String image;
  @HiveField(4)
  final String description;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  factory ProductModel.fromFirestore(String id, Map<String, dynamic> data) {
    String rawDescription = data['description'] ?? '';

    return ProductModel(
      id: id,
      name: data['name'] ?? '',
      price: data['price'] != null ? data['price'].toString() : '',
      image: data['image'] ?? '',

      description: rawDescription.trim().isEmpty
          ? 'Minimal Stand is made of natural wood. The design is very simple and minimal and a Nice Furniture that can be used in every home with comfortable and easy to setup with the easy pricing and used in every room and place'
          : rawDescription,
    );
  }
}
