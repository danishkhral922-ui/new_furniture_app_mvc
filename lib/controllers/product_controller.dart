import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/models/product_model.dart';
import 'package:new_furiniture_app_mvc/services/product_services.dart';

class ProductProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final imageController = TextEditingController();
  final ProductServices _services = ProductServices();

  Stream<List<ProductModel>> get productsStream =>
      _services.getProductsStream();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _showSnackBar(
    BuildContext context,
    String title,
    String message,
    Color bgColor,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title: $message'),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> addProduct(BuildContext context) async {
    if (nameController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty) {
      _showSnackBar(
        context,
        'Error',
        'Please fill all required fields',
        Colors.red,
      );
      return;
    }

    try {
      isLoading = true;
      notifyListeners();

      await _services.saveProductToFirestore(
        name: nameController.text.trim(),
        price: double.tryParse(priceController.text.trim()) ?? 0.0,
        image: imageController.text.trim(),
      );

      nameController.clear();
      priceController.clear();
      imageController.clear();

      if (context.mounted) {
        Navigator.pop(context);
        _showSnackBar(
          context,
          'Success',
          'Product Added Successfully',
          Colors.green,
        );
      }
    } catch (e) {
      if (context.mounted) {
        _showSnackBar(context, 'Error', 'Something went wrong: $e', Colors.red);
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(BuildContext context, String productId) async {
    try {
      await _services.deleteProductFromFirestore(productId);
      if (context.mounted) {
        _showSnackBar(
          context,
          'Deleted',
          'Product deleted successfully',
          Colors.orange,
        );
      }
    } catch (e) {
      if (context.mounted) {
        _showSnackBar(
          context,
          'Error',
          'Failed to delete product: $e',
          Colors.red,
        );
      }
    }
  }

  Future<void> setEditFields(ProductModel product) async {
    nameController.text = product.name;
    priceController.text = product.price.toString();
    imageController.text = product.image;
    notifyListeners();
  }

  Future<void> updateProduct(BuildContext context, String productId) async {
    if (nameController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty) {
      _showSnackBar(
        context,
        'Error',
        'Please fill all required fields',
        Colors.red,
      );
      return;
    }
    try {
      isLoading = true;
      notifyListeners();

      await _services.updateProductinfirestore(
        productId: productId,
        name: nameController.text.trim(),
        price: double.tryParse(priceController.text.trim()) ?? 0.0,
        image: imageController.text.trim(),
      );

      nameController.clear();
      priceController.clear();
      imageController.clear();

      if (context.mounted) {
        Navigator.pop(context);
        _showSnackBar(
          context,
          'Success',
          'Product updated successfully',
          Colors.green,
        );
      }
    } catch (e) {
      if (context.mounted) {
        _showSnackBar(context, 'Error', 'Something went wrong: $e', Colors.red);
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    imageController.dispose();
    super.dispose();
  }
}
