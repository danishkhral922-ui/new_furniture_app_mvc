import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/models/product_model.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var productsList = <ProductModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() {
    try {
      _firestore.collection('products').snapshots().listen((snapshot) {
        productsList.clear();
        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data();
          productsList.add(
            ProductModel(
              id: doc.id,
              name: data['name'] ?? '',
              price: (data['price'] ?? 0).toString(),
              image: data['image'] ?? '',
              description: '',
            ),
          );
        }
        isLoading.value = false;
      });
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }
}
