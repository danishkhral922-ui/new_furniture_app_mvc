import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_furiniture_app_mvc/models/favourite_model.dart';

class FavouriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<FavouriteModel>> getFavouriteStream() {
    return _firestore.collection('favourites').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return FavouriteModel.fromFirestore(doc.id, doc.data());
      }).toList();
    });
  }

  Future<void> addToFavourite({
    required String name,
    required String price,
    required String image,
  }) async {
    await _firestore.collection('favourites').add({
      'name': name,
      'price': price,
      'image': image,
    });
  }

  Future<void> removeFavourite(String id) async {
    await _firestore.collection('favourites').doc(id).delete();
  }
}
