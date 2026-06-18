import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/models/cart_model.dart';
import 'package:new_furiniture_app_mvc/services/cart_services.dart';

class CartProvider extends ChangeNotifier {
  final CartService _cartService = CartService();
  List<CartModel> _cartItems = [];

  List<CartModel> get cartItems => _cartItems;

  CartProvider() {
    _cartService.getCartStream().listen((items) {
      _cartItems = items;
      notifyListeners();
    });
  }

  Future<void> addToCart({
    required String name,
    required String price,
    required String image,
  }) async {
    await _cartService.addToCart(name: name, price: price, image: image);
  }

  Future<void> increaseQuantity(String id) async {
    final item = _cartItems.firstWhere((element) => element.id == id);
    int quantity = item.quantity + 1;
    await _cartService.updateQuantity(id, quantity);
  }

  Future<void> decreaseQuantity(String id) async {
    final item = _cartItems.firstWhere((element) => element.id == id);
    if (item.quantity > 1) {
      int quantity = item.quantity - 1;
      await _cartService.updateQuantity(id, quantity);
    }
  }

  Future<void> deleteItem(String id) async {
    await _cartService.deleteItem(id);
  }

  double totalPrice() {
    double total = 0;
    for (var item in _cartItems) {
      String priceString = item.price.replaceAll('\$', '');
      double price = double.tryParse(priceString) ?? 0;
      total += price * item.quantity;
    }
    return total;
  }
}
