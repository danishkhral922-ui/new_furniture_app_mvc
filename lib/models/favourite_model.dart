import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class FavouriteModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String price;
  @HiveField(3)
  final String image;

  FavouriteModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory FavouriteModel.fromFirestore(String id, Map<String, dynamic> data) {
    return FavouriteModel(
      id: id,
      name: data['name'] ?? '',
      price: data['price'] ?? '',
      image: data['image'] ?? '',
    );
  }
}
