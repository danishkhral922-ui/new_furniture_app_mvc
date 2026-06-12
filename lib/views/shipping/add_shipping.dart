import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/controllers/shipping_controller.dart';
import 'package:new_furiniture_app_mvc/views/shipping/add_shipping_address.dart';

class ShoppingAddress extends StatelessWidget {
  ShoppingAddress({super.key});

  final ShippingController shippingController = Get.put(ShippingController());

  void showEditDialog(
    BuildContext context,
    int index,
    String currentName,
    String currentAddress,
  ) {
    shippingController.editNameController.text = currentName;
    shippingController.editAddressController.text = currentAddress;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Edit Shipping Address',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: shippingController.editNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: shippingController.editAddressController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
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
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                shippingController.updateExistingAddress(index, currentName);
              },
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

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
          'Shipping Address',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
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
                Row(
                  children: [
                    Checkbox(
                      value: isSelected,
                      activeColor: Colors.black,
                      checkColor: Colors.white,
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
                        color: isSelected ? Colors.black : Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 335,
                  child: Card(
                    shadowColor: Colors.grey,
                    elevation: 8,
                    color: Colors.white,
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
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Colors.black,
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
                                child: Image.asset('assets/images/edit.png'),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.grey, thickness: 1),
                          const SizedBox(height: 5),
                          Text(
                            addressItem.address,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.grey,
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
        backgroundColor: Colors.white,
        onPressed: () {
          Get.to(() => AddShippingAddress());
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
