import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/shipping_controller.dart';
import 'package:provider/provider.dart';

class AddShippingAddress extends StatelessWidget {
  const AddShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final shippingProvider = context.read<ShippingProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text(
          'Add shipping address',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildInputField(
                      label: 'Full Name',
                      hint: 'Ex: Danish Abrar',
                      controller: shippingProvider.nameController,
                      context: context,
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: 'Address',
                      hint: 'Ex: Johar Town, Lahore',
                      controller: shippingProvider.addressController,
                      context: context,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 60,
              width: 335,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: isDarkMode ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  if (shippingProvider.nameController.text.trim().isEmpty ||
                      shippingProvider.addressController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Please fill name and address fields",
                        ),
                        backgroundColor: Colors.red[400],
                      ),
                    );
                    return;
                  }

                  shippingProvider.saveShippingAddress(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'SAVE ADDRESS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required BuildContext context,
    IconData? suffixIcon,
    bool isWhiteBg = false,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 335,
      height: 80,
      decoration: BoxDecoration(
        border: isWhiteBg
            ? Border.all(
                color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
              )
            : null,
        borderRadius: BorderRadius.circular(8),
        color: isWhiteBg
            ? (isDarkMode ? Colors.grey[850] : Colors.white)
            : (isDarkMode ? Colors.grey[900] : Colors.grey[100]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 44,
            width: 300,
            child: TextFormField(
              controller: controller,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
              decoration: InputDecoration(
                suffixIcon: suffixIcon != null
                    ? Icon(suffixIcon, color: Colors.grey)
                    : null,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: hint,
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
