import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/product_controller.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final productProvider = context.read<ProductProvider>();

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
            key: productProvider.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: productProvider.nameController,
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
                TextFormField(
                  controller: productProvider.priceController,
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
                TextFormField(
                  controller: productProvider.imageController,
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
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: Consumer<ProductProvider>(
                    builder: (context, provider, child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                        onPressed: provider.isLoading
                            ? null
                            : () => provider.addProduct(context),
                        child: provider.isLoading
                            ? SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: isDarkMode
                                      ? Colors.black
                                      : Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                'ADD PRODUCT',
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      );
                    },
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
