import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_furiniture_app_mvc/models/product_model.dart';

class ProductServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<ProductModel>> getProductsStream() {
    return _db.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromFirestore(doc.id, doc.data());
      }).toList();
    });
  }

  Future<void> saveProductToFirestore({
    required String name,
    required double price,
    required String image,
  }) async {
    await _db.collection('products').add({
      "name": name,
      "price": price,
      "image": image.isEmpty ? '' : image,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteProductFromFirestore(String productId) async {
    await _db.collection('products').doc(productId).delete();
  }

  Future<void> updateProductinfirestore({
    required String productId,
    required String name,
    required double price,
    required String image,
  }) async {
    await _db.collection('products').doc(productId).update({
      "name": name,
      "price": price,
      "image": image.isEmpty ? '' : image,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }
}
