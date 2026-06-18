import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/shipping_controller.dart';
import 'package:provider/provider.dart';
import 'package:new_furiniture_app_mvc/views/shipping/add_shipping_address.dart';

class ShoppingAddress extends StatelessWidget {
  const ShoppingAddress({super.key});

  void showEditDialog(
    BuildContext context,
    int index,
    String currentName,
    String currentAddress,
  ) {
    final shippingProvider = context.read<ShippingProvider>();
    shippingProvider.editNameController.text = currentName;
    shippingProvider.editAddressController.text = currentAddress;
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
                controller: shippingProvider.editNameController,
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
                controller: shippingProvider.editAddressController,
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
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.white : Colors.black,
              ),
              onPressed: () {
                shippingProvider.updateExistingAddress(
                  context,
                  index,
                  currentName,
                );
                Navigator.pop(context);
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
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text(
          'Shipping Address',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Consumer<ShippingProvider>(
        builder: (context, provider, child) {
          if (provider.shippingAddresses.isEmpty) {
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
            itemCount: provider.shippingAddresses.length,
            itemBuilder: (context, index) {
              final addressItem = provider.shippingAddresses[index];
              final isSelected = provider.selectedAddressIndex == index;

              return Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isSelected,
                        activeColor: isDarkMode ? Colors.white : Colors.black,
                        checkColor: isDarkMode ? Colors.black : Colors.white,
                        onChanged: (value) {
                          if (value == true) {
                            provider.selectAddress(index);
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
                  SizedBox(
                    width: 335,
                    child: Card(
                      shadowColor: isDarkMode
                          ? Colors.black45
                          : Colors.grey.withAlpha(128),
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDarkMode ? Colors.white : Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddShippingAddress()),
          );
        },
        child: Icon(Icons.add, color: isDarkMode ? Colors.black : Colors.white),
      ),
    );
  }
}
