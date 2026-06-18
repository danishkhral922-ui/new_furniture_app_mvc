import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/product_controller.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  final String productId;
  final String oldName;
  final String oldPrice;
  final String oldImage;

  const EditProduct({
    super.key,
    required this.productId,
    required this.oldName,
    required this.oldPrice,
    required this.oldImage,
  });

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ProductProvider>();
      provider.nameController.text = widget.oldName;
      provider.priceController.text = widget.oldPrice;
      provider.imageController.text = widget.oldImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Provider ko access karna
    final provider = context.read<ProductProvider>();
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
            TextField(
              controller: provider.nameController,
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
            TextField(
              controller: provider.priceController,
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
            TextField(
              controller: provider.imageController,
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
            Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: isDarkMode ? Colors.white : Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: productProvider.isLoading
                      ? null
                      : () {
                          productProvider.updateProduct(
                            context,
                            widget.productId,
                          );
                        },
                  child: productProvider.isLoading
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
