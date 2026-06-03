class CartModel {
  final String id;
  final String name;
  final String price;
  final String image;
  final int quantity;

  CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory CartModel.fromFirestore(String id, Map<String, dynamic> data) {
    return CartModel(
      id: id,
      name: data['name'] ?? '',
      price: data['price'] ?? '',
      image: data['image'] ?? '',
      quantity: data['quantity'] ?? 1,
    );
  }
}
