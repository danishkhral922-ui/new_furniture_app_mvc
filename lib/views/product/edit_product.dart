import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/controllers/product_controller.dart';

class EditProduct extends StatelessWidget {
  final String productId;
  final String oldName;
  final String oldPrice;
  final String oldImage;

  EditProduct({
    super.key,
    required this.productId,
    required this.oldName,
    required this.oldPrice,
    required this.oldImage,
  }) {
    final ProductController controller = Get.find<ProductController>();
    controller.nameController.text = oldName;
    controller.priceController.text = oldPrice;
    controller.imageController.text = oldImage;
  }

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Edit Product',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Product Name Field
            TextField(
              controller: controller.nameController,
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.grey[700]! : Colors.grey,
                  ),
                ),
                labelText: 'Edit Product Name',
                labelStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 10),

            // Price Field
            TextField(
              controller: controller.priceController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.grey[700]! : Colors.grey,
                  ),
                ),
                labelText: 'Edit Price',
                labelStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 10),

            // Image URL Field
            TextField(
              controller: controller.imageController,
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.grey[700]! : Colors.grey,
                  ),
                ),
                labelText: 'Edit Image URL',
                labelStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),

            // Update Button
            Obx(
              () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: isDarkMode ? Colors.white : Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        controller.updateProduct(productId);
                      },
                child: controller.isLoading.value
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: isDarkMode ? Colors.black : Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'UPDATE PRODUCT',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.black : Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
