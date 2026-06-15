import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_furiniture_app_mvc/models/favourite_model.dart';
import 'package:new_furiniture_app_mvc/services/favourites_servies.dart';

class FavouriteController extends GetxController {
  final FavouriteService _favouriteService = FavouriteService();
  RxList<FavouriteModel> favouriteItems = <FavouriteModel>[].obs;
  late Box<FavouriteModel> _favouriteBox;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initHiveAndStream();
  }

  Future<void> _initHiveAndStream() async {
    try {
      _favouriteBox = Hive.box<FavouriteModel>('favouritesBox');
    } catch (e) {
      _favouriteBox = await Hive.openBox<FavouriteModel>('favouritesBox');
    }

    _loadOfflineItems();

    favouriteItems.bindStream(_favouriteService.getFavouriteStream());

    ever(favouriteItems, (List<FavouriteModel> items) async {
      await _favouriteBox.clear();
      await _favouriteBox.addAll(items);
      isLoading.value = false;
    });
  }

  void _loadOfflineItems() {
    if (_favouriteBox.isNotEmpty) {
      favouriteItems.assignAll(_favouriteBox.values.toList());
      isLoading.value = false;
    }
  }

  Future<void> addToFavourite({
    required String name,
    required String price,
    required String image,
  }) async {
    await _favouriteService.addToFavourite(
      name: name,
      price: price,
      image: image,
    );
  }

  Future<void> removeFavourite(String id) async {
    await _favouriteService.removeFavourite(id);
  }

  bool isFavourite(String productName) {
    return favouriteItems.any((element) => element.name == productName);
  }

  Future<void> removeFromFavourite(String name) async {
    try {
      final item = favouriteItems.firstWhere((element) => element.name == name);
      await removeFavourite(item.id);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not remove from favourites',
        colorText: Colors.white,
        backgroundColor: Colors.red[400],
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
