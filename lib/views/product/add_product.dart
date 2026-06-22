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
        padding: const EdgeInsets.all(20),
        child: Form(
          key: productProvider.formKey,
          child: Column(
            children: [
              _buildTextField(
                productProvider.nameController,
                'Product Name',
                TextInputAction.next,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                productProvider.priceController,
                'Price',
                TextInputAction.next,
                isNumber: true,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                productProvider.imageController,
                'Image URL',
                TextInputAction.done,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: Consumer<ProductProvider>(
                  builder: (context, provider, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? Colors.white
                            : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: provider.isLoading
                          ? null
                          : () => provider.addProduct(context),
                      child: provider.isLoading
                          ? CircularProgressIndicator(
                              color: isDarkMode ? Colors.black : Colors.white,
                            )
                          : Text(
                              'ADD PRODUCT',
                              style: TextStyle(
                                color: isDarkMode ? Colors.black : Colors.white,
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
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    TextInputAction action, {
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      textInputAction: action,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: (value) =>
          (value == null || value.trim().isEmpty) ? 'Please enter $hint' : null,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
