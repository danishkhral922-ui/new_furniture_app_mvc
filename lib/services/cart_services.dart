import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_furiniture_app_mvc/models/cart_model.dart';

class CartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<CartModel>> getCartStream() {
    return _firestore.collection('cart').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CartModel.fromFirestore(doc.id, doc.data());
      }).toList();
    });
  }

  Future<void> addToCart({
    required String name,
    required String price,
    required String image,
  }) async {
    await _firestore.collection('cart').add({
      'name': name,
      'price': price,
      'image': image,
      'quantity': 1,
    });
  }

  Future<void> updateQuantity(String id, int quantity) async {
    await _firestore.collection('cart').doc(id).update({'quantity': quantity});
  }

  Future<void> deleteItem(String id) async {
    await _firestore.collection('cart').doc(id).delete();
  }
}
