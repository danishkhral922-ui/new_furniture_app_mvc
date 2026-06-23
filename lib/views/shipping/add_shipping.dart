import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/shipping_controller.dart';
import 'package:provider/provider.dart';
import 'package:new_furiniture_app_mvc/views/shipping/add_shipping_address.dart';

class ShoppingAddress extends StatelessWidget {
  const ShoppingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text(
          'Shipping Address',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Consumer<ShippingProvider>(
        builder: (context, provider, _) {
          if (provider.shippingAddresses.isEmpty) {
            return const Center(
              child: Text(
                'No Shipping Address Added Yet!',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: provider.shippingAddresses.length,
            itemBuilder: (context, index) {
              final item = provider.shippingAddresses[index];
              final isSelected = provider.selectedAddressIndex == index;

              return Column(
                children: [
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: isSelected,
                    title: Text(
                      'Use as the shipping address',
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    onChanged: (val) =>
                        val == true ? provider.selectAddress(index) : null,
                  ),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.fullName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit, size: 20),
                                onPressed: () => _showEditDialog(
                                  context,
                                  index,
                                  item.fullName,
                                  item.address,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Text(
                            item.address,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
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
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddShippingAddress()),
        ),
        child: Icon(
          Icons.add,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
        ),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    int index,
    String name,
    String address,
  ) {
    final provider = context.read<ShippingProvider>();
    provider.editNameController.text = name;
    provider.editAddressController.text = address;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Shipping Address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: provider.editNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: provider.editAddressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(color: isDark ? Colors.white : Colors.black),
              backgroundColor: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () {
              provider.updateExistingAddress(context, index, name);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
