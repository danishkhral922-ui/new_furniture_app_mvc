import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_furiniture_app_mvc/models/product_model.dart';

class HomeProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Box<ProductModel> _productsBox;

  List<ProductModel> _productsList = [];
  List<ProductModel> _filteredProducts = [];
  bool _isLoading = true;
  String _searchQuery = '';
  String _selectedCategory = 'Popular';
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
  _productsSubscription;

  List<ProductModel> get productsList => _productsList;
  List<ProductModel> get filteredProducts => _filteredProducts;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

  HomeProvider() {
    _productsBox = Hive.box<ProductModel>('products_box');
    loadOfflineProducts();
    listenToProducts();
  }

  void loadOfflineProducts() {
    if (_productsBox.isNotEmpty) {
      _productsList = _productsBox.values.toList();
      _filterProductsLogic();
      _isLoading = false;
      notifyListeners();
    }
  }

  void listenToProducts() {
    try {
      _productsSubscription = _firestore
          .collection('products')
          .snapshots()
          .listen(
            (snapshot) async {
              List<ProductModel> temp = [];
              for (var doc in snapshot.docs) {
                Map<String, dynamic> data = doc.data();
                temp.add(ProductModel.fromFirestore(doc.id, data));
              }

              _productsList = temp;
              _filterProductsLogic();
              _isLoading = false;
              notifyListeners();

              await _productsBox.clear();
              await _productsBox.addAll(temp);
            },
            onError: (error) {
              _isLoading = false;
              notifyListeners();
            },
          );
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  void changeCategory(String categoryName) {
    _selectedCategory = categoryName;
    _filterProductsLogic();
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _filterProductsLogic();
    notifyListeners();
  }

  void _filterProductsLogic() {
    List<ProductModel> tempProducts = [];

    if (_selectedCategory == 'Popular') {
      tempProducts = List.from(_productsList);
    } else {
      tempProducts = _productsList
          .where(
            (product) => product.name.toLowerCase().contains(
              _selectedCategory.toLowerCase(),
            ),
          )
          .toList();
    }

    if (_searchQuery.isEmpty) {
      _filteredProducts = tempProducts;
    } else {
      _filteredProducts = tempProducts
          .where(
            (product) =>
                product.name.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }
  }

  @override
  void dispose() {
    _productsSubscription?.cancel();
    super.dispose();
  }
}
