import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/models/product_model.dart';
import 'package:new_furiniture_app_mvc/services/product_services.dart';

class ProductController extends GetxController {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final imageController = TextEditingController();
  final ProductServices _services = ProductServices();

  Stream<List<ProductModel>> get productsStream =>
      _services.getProductsStream();

  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  Future<void> addProduct() async {
    if (nameController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      await _services.saveProductToFirestore(
        name: nameController.text.trim(),
        price: double.tryParse(priceController.text.trim()) ?? 0.0,
        image: imageController.text.trim(),
      );

      nameController.clear();
      priceController.clear();
      imageController.clear();

      Get.back();

      Get.snackbar(
        'Success',
        'Product Added Successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _services.deleteProductFromFirestore(productId);
      Get.snackbar(
        'Deleted',
        'Product deleted successfully',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete product: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> SetEditfields(ProductModel product) async {
    nameController.text = product.name;
    priceController.text = product.price.toString();
    imageController.text = product.image;
  }

  Future<void> updateProduct(String ProductId) async {
    if (nameController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    try {
      isLoading.value = true;
      await _services.updateProductinfirestore(
        productId: ProductId,
        name: nameController.text.trim(),
        price: double.tryParse(priceController.text.trim()) ?? 0.0,
        image: imageController.text.trim(),
      );
      nameController.clear();
      priceController.clear();
      imageController.clear();
      Get.back();
      Get.snackbar(
        'Success',
        'Product updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
