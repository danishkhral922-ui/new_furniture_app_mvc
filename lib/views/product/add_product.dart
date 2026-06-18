import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/controllers/product_controller.dart';

class AddProduct extends StatelessWidget {
  AddProduct({super.key});

  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Product',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                // Product Name Field
                TextFormField(
                  controller: controller.nameController,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter product name' : null,
                  decoration: InputDecoration(
                    hintText: 'Product Name',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.grey[700]! : Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Price Field
                TextFormField(
                  controller: controller.priceController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter price' : null,
                  decoration: InputDecoration(
                    hintText: 'Price',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.grey[700]! : Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Image URL Field
                TextFormField(
                  controller: controller.imageController,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter image URL' : null,
                  decoration: InputDecoration(
                    hintText: 'Image URL',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.grey[700]! : Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                      onPressed: controller.isLoading.value
                          ? null
                          : () => controller.addProduct(),
                      child: controller.isLoading.value
                          ? SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: isDarkMode ? Colors.black : Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : Text(
                              'ADD PRODUCT',
                              style: TextStyle(
                                color: isDarkMode ? Colors.black : Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
