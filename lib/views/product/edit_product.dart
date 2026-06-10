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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Edit Product',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Edit Product Name',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller.priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Edit Price',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller.imageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Edit Image URL',
              ),
            ),
            const SizedBox(height: 30),
            Obx(
              () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        controller.updateProduct(productId);
                      },
                child: controller.isLoading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'UPDATE  PRODUCT',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
