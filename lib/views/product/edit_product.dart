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
  bool _isVisible = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) setState(() => _isVisible = true);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ProductProvider>();
      provider.nameController.text = widget.oldName;
      provider.priceController.text = widget.oldPrice;
      provider.imageController.text = widget.oldImage;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 800),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: provider.nameController,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Edit Product Name',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: provider.priceController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Edit Price',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: provider.imageController,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Edit Image URL',
                ),
              ),
              const SizedBox(height: 30),
              Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
                  return AnimatedScale(
                    scale: _isPressed ? 0.95 : 1.0,
                    duration: const Duration(milliseconds: 100),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: isDarkMode
                            ? Colors.white
                            : Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: productProvider.isLoading
                          ? null
                          : () async {
                              setState(() => _isPressed = true);
                              await Future.delayed(
                                const Duration(milliseconds: 100),
                              );
                              setState(() => _isPressed = false);
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
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
