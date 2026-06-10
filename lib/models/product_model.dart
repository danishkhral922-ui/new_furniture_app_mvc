class ProductModel {
  final String id;
  final String name;
  final String price;
  final String image;
  final String description;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  factory ProductModel.fromFirestore(String id, Map<String, dynamic> data) {
    // Pehle check karein k description null ya empty to nahi
    String rawDescription = data['description'] ?? '';

    return ProductModel(
      id: id,
      name: data['name'] ?? '',
      price: data['price'] != null ? data['price'].toString() : '',
      image: data['image'] ?? '',
      // Agar description khali string bhi ho, tab bhi default text show hoga
      description: rawDescription.trim().isEmpty
          ? 'Minimal Stand is made of natural wood. The design is very simple and minimal.'
          : rawDescription,
    );
  }
}
