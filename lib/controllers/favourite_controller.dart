import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_furiniture_app_mvc/models/favourite_model.dart';
import 'package:new_furiniture_app_mvc/services/favourites_servies.dart';

class FavouriteProvider extends ChangeNotifier {
  final FavouriteService _favouriteService = FavouriteService();
  List<FavouriteModel> _favouriteItems = [];
  late Box<FavouriteModel> _favouriteBox;
  bool _isLoading = true;
  StreamSubscription<List<FavouriteModel>>? _streamSubscription;

  List<FavouriteModel> get favouriteItems => _favouriteItems;
  bool get isLoading => _isLoading;

  FavouriteProvider() {
    _initHiveAndStream();
  }

  Future<void> _initHiveAndStream() async {
    _favouriteBox = await Hive.openBox<FavouriteModel>('favouritesBox');
    _favouriteItems = _favouriteBox.values.toList();
    _isLoading = false;
    notifyListeners();

    _streamSubscription = _favouriteService.getFavouriteStream().listen((
      items,
    ) async {
      _favouriteItems = items;
      await _favouriteBox.clear();
      await _favouriteBox.addAll(items);
      _isLoading = false;
      notifyListeners();
    });
  }

  bool isFavourite(String name) {
    return _favouriteItems.any((item) => item.name == name);
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
    notifyListeners();
  }

  Future<void> removeFavourite(String id) async {
    try {
      await _favouriteService.removeFavourite(id);
      _favouriteItems.removeWhere((item) => item.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  Future<void> removeFromFavourite(BuildContext context, String name) async {}
}
