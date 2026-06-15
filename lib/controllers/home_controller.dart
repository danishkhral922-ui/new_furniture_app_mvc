import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:new_furiniture_app_mvc/models/product_model.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Box<ProductModel> _productsBox;

  var productsList = <ProductModel>[].obs;
  var filteredProducts = <ProductModel>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;
  var selectedCategory = 'Popular'.obs;

  @override
  void onInit() {
    _productsBox = Hive.box<ProductModel>('products_box');
    loadOfflineProducts();
    listenToProducts();
    super.onInit();
  }

  void loadOfflineProducts() {
    if (_productsBox.isNotEmpty) {
      productsList.assignAll(_productsBox.values.toList());
      filterProducts(searchQuery.value);
      isLoading.value = false;
    }
  }

  void listenToProducts() {
    try {
      _firestore.collection('products').snapshots().listen((snapshot) {
        List<ProductModel> temp = [];
        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data();
          temp.add(ProductModel.fromFirestore(doc.id, data));
        }

        productsList.assignAll(temp);
        filterProducts(searchQuery.value);
        isLoading.value = false;

        _productsBox.clear().then((_) {
          _productsBox.addAll(temp);
        });
      });
    } catch (e) {
      if (productsList.isNotEmpty) {
        isLoading.value = false;
        Get.snackbar(
          'Offline Mode',
          'Displaying cached products.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange[300],
          colorText: Colors.white,
        );
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          e.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.red[400],
          snackPosition: SnackPosition.TOP,
        );
      }
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
