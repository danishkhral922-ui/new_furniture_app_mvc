import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/models/favourite_model.dart';
import 'package:new_furiniture_app_mvc/services/favourites_servies.dart';

class FavouriteController extends GetxController {
  final FavouriteService _favouriteService = FavouriteService();
  RxList<FavouriteModel> favouriteItems = <FavouriteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    favouriteItems.bindStream(_favouriteService.getFavouriteStream());
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
