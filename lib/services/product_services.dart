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
}
