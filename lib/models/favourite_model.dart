class FavouriteModel {
  final String id;
  final String name;
  final String price;
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
