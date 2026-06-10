import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/controllers/shipping_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/switch_controller.dart';

class AddShippingAddress extends StatelessWidget {
  AddShippingAddress({super.key});

  final SwitchController switchController = Get.put(SwitchController());
  final ShippingController shippingcontroller = Get.put(ShippingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text(
          'Add shipping address',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
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
                      hint: 'Ex: Bruno Pham',
                      controller: shippingcontroller.nameController,
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: 'Address',
                      hint: 'Ex: 25 Robert Latouche Street',
                      controller: shippingcontroller.addressController,
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
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  if (shippingcontroller.nameController.text.trim().isEmpty ||
                      shippingcontroller.addressController.text
                          .trim()
                          .isEmpty) {
                    Get.snackbar(
                      "Required",
                      "Please fill name and address fields",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }

                  shippingcontroller.fullname.value = shippingcontroller
                      .nameController
                      .text
                      .trim();
                  shippingcontroller.address.value = shippingcontroller
                      .addressController
                      .text
                      .trim();
                  shippingcontroller.saveShippingAddress();
                },
                child: const Text(
                  'SAVE ADDRESS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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
    IconData? suffixIcon,
    bool isWhiteBg = false,
  }) {
    return Container(
      width: 335,
      height: 80,
      decoration: BoxDecoration(
        border: isWhiteBg ? Border.all(color: Colors.grey[300]!) : null,
        borderRadius: BorderRadius.circular(8),
        color: isWhiteBg ? Colors.white : Colors.grey[100],
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
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
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
