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
    try {
      _favouriteBox = Hive.box<FavouriteModel>('favouritesBox');
    } catch (e) {
      _favouriteBox = await Hive.openBox<FavouriteModel>('favouritesBox');
    }
    _loadOfflineItems();
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

  void _loadOfflineItems() {
    if (_favouriteBox.isNotEmpty) {
      _favouriteItems = _favouriteBox.values.toList();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavourite({
    required BuildContext context,
    required String name,
    required String price,
    required String image,
  }) async {
    if (isFavourite(name)) {
      await removeFromFavourite(context, name);
    } else {
      await _favouriteService.addToFavourite(
        name: name,
        price: price,
        image: image,
      );
    }
    notifyListeners();
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
    return _favouriteItems.any((element) => element.name == productName);
  }

  Future<void> removeFromFavourite(BuildContext context, String name) async {
    try {
      final item = _favouriteItems.firstWhere(
        (element) => element.name == name,
      );
      await removeFavourite(item.id);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Could not remove from favourites'),
            backgroundColor: Colors.red[400],
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}
