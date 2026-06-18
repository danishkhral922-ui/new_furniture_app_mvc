import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/controllers/shipping_controller.dart';
import 'package:new_furiniture_app_mvc/views/shipping/add_shipping_address.dart';

class ShoppingAddress extends StatelessWidget {
  ShoppingAddress({super.key});

  final ShippingController shippingController = Get.put(ShippingController());

  // Edit Dialog box with dark mode optimization
  void showEditDialog(
    BuildContext context,
    int index,
    String currentName,
    String currentAddress,
  ) {
    shippingController.editNameController.text = currentName;
    shippingController.editAddressController.text = currentAddress;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
          title: Text(
            'Edit Shipping Address',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: shippingController.editNameController,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.grey[700]! : Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: shippingController.editAddressController,
                maxLines: 2,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.grey[700]! : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.white : Colors.black,
              ),
              onPressed: () {
                shippingController.updateExistingAddress(index, currentName);
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: isDarkMode ? Colors.black : Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text(
          'Shipping Address',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Obx(() {
        if (shippingController.shippingAddresses.isEmpty) {
          return const Center(
            child: Text(
              'No Shipping Address Added Yet!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: shippingController.shippingAddresses.length,
          itemBuilder: (context, index) {
            final addressItem = shippingController.shippingAddresses[index];
            final isSelected =
                shippingController.selectedAddressIndex.value == index;

            return Column(
              children: [
                // Selection Header Row
                Row(
                  children: [
                    Checkbox(
                      value: isSelected,
                      activeColor: isDarkMode ? Colors.white : Colors.black,
                      checkColor: isDarkMode ? Colors.black : Colors.white,
                      onChanged: (value) {
                        if (value == true) {
                          shippingController.selectAddress(index);
                        }
                      },
                    ),
                    Text(
                      'Use as the shipping address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected
                            ? (isDarkMode ? Colors.white : Colors.black)
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Address Card Details
                SizedBox(
                  width: 335,
                  child: Card(
                    shadowColor: isDarkMode
                        ? Colors.black45
                        : Colors.grey.withValues(alpha: 0.5),
                    elevation: 4,
                    color: isDarkMode ? Colors.grey[850] : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                addressItem.fullName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showEditDialog(
                                    context,
                                    index,
                                    addressItem.fullName,
                                    addressItem.address,
                                  );
                                },
                                child: Image.asset(
                                  'assets/images/edit.png',
                                  color: isDarkMode ? Colors.white : null,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: isDarkMode
                                ? Colors.grey[700]
                                : Colors.grey[300],
                            thickness: 1,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            addressItem.address,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: isDarkMode
                                  ? Colors.grey[400]
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDarkMode ? Colors.white : Colors.black,
        onPressed: () {
          Get.to(() => AddShippingAddress());
        },
        child: Icon(Icons.add, color: isDarkMode ? Colors.black : Colors.white),
      ),
    );
  }
}
