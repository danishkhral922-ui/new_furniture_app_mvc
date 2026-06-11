import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/models/product_model.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var productsList = <ProductModel>[].obs;
  var filteredProducts = <ProductModel>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;
  var selectedCategory = 'Popular'.obs;

  @override
  void onInit() {
    listenToProducts();
    super.onInit();
  }

  void listenToProducts() {
    isLoading.value = true;
    try {
      _firestore.collection('products').snapshots().listen((snapshot) {
        List<ProductModel> temp = [];
        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data();
          temp.add(
            ProductModel(
              id: doc.id,
              name: data['name'] ?? '',
              price: (data['price'] ?? 0).toString(),
              image: data['image'] ?? '',
              description: '',
            ),
          );
        }
        productsList.assignAll(temp);
        filterProducts(searchQuery.value);
        isLoading.value = false;
      });
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }

  void changeCategory(String categoryName) {
    selectedCategory.value = categoryName;
    filterProducts(searchQuery.value);
  }

  void filterProducts(String query) {
    searchQuery.value = query;
    List<ProductModel> tempProducts = [];

    if (selectedCategory.value == 'Popular') {
      tempProducts = List.from(productsList);
    } else {
      tempProducts = productsList
          .where(
            (product) => product.name.toLowerCase().contains(
              selectedCategory.value.toLowerCase(),
            ),
          )
          .toList();
    }

    if (query.isEmpty) {
      filteredProducts.assignAll(tempProducts);
    } else {
      filteredProducts.assignAll(
        tempProducts
            .where(
              (product) =>
                  product.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList(),
      );
    }
  }
}
