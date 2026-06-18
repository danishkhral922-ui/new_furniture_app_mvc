import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/shipping_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShippingProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Box<ShippingModel> _shippingBox = Hive.box<ShippingModel>(
    'shipping_box',
  );

  final nameController = TextEditingController();
  final addressController = TextEditingController();

  final editNameController = TextEditingController();
  final editAddressController = TextEditingController();

  String fullname = '';
  String address = '';

  List<ShippingModel> shippingAddresses = [];
  int selectedAddressIndex = 0;
  ShippingModel? currentShipping;

  ShippingProvider() {
    if (_shippingBox.isNotEmpty) {
      shippingAddresses = _shippingBox.values.toList();
      selectAddress(0);
    }
    fetchCurrentAddress();
  }

  void _showSnackBar(
    BuildContext context,
    String title,
    String message,
    Color bgColor,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title: $message'),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void fetchCurrentAddress() async {
    try {
      var querySnapshot = await _firestore
          .collection('shipping_addresses')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        shippingAddresses.clear();
        for (var doc in querySnapshot.docs) {
          if (doc.data() != null) {
            shippingAddresses.add(ShippingModel.fromMap(doc.data()));
          }
        }
        await _shippingBox.clear();
        await _shippingBox.addAll(shippingAddresses);

        if (shippingAddresses.isNotEmpty) {
          selectAddress(0);
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error fetching address: $e");
    }
  }

  Future<void> saveShippingAddress(BuildContext context) async {
    if (nameController.text.isEmpty || addressController.text.isEmpty) {
      _showSnackBar(context, 'Error', 'Please fill all fields', Colors.red);
      return;
    }

    try {
      ShippingModel newAddress = ShippingModel(
        fullName: nameController.text,
        address: addressController.text,
      );
      await _shippingBox.add(newAddress);
      shippingAddresses.add(newAddress);

      selectAddress(shippingAddresses.length - 1);
      nameController.clear();
      addressController.clear();

      if (context.mounted) {
        Navigator.pop(context);
      }

      String docId = _firestore.collection('shipping_addresses').doc().id;

      await _firestore
          .collection('shipping_addresses')
          .doc(docId)
          .set(newAddress.toMap());

      shippingAddresses.add(newAddress);
      selectAddress(shippingAddresses.length - 1);

      nameController.clear();
      addressController.clear();

      if (context.mounted) {
        Navigator.pop(context);
        _showSnackBar(
          context,
          'Success',
          'Address updated successfully',
          Colors.green,
        );
      }
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        _showSnackBar(context, 'Error', 'Failed to save address', Colors.red);
      }
    }
  }

  Future<void> updateExistingAddress(
    BuildContext context,
    int index,
    String oldFullName,
  ) async {
    if (editNameController.text.isEmpty || editAddressController.text.isEmpty) {
      _showSnackBar(context, 'Error', 'Fields cannot be empty', Colors.red);
      return;
    }

    try {
      ShippingModel updatedAddress = ShippingModel(
        fullName: editNameController.text,
        address: editAddressController.text,
      );
      await _shippingBox.putAt(index, updatedAddress);
      shippingAddresses[index] = updatedAddress;

      if (selectedAddressIndex == index) {
        currentShipping = updatedAddress;
      }

      if (context.mounted) {
        Navigator.pop(context);
      }

      var querySnapshot = await _firestore
          .collection('shipping_addresses')
          .where('fullName', isEqualTo: oldFullName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String docId = querySnapshot.docs.first.id;
        await _firestore
            .collection('shipping_addresses')
            .doc(docId)
            .update(updatedAddress.toMap());

        shippingAddresses[index] = updatedAddress;

        if (selectedAddressIndex == index) {
          currentShipping = updatedAddress;
        }

        if (context.mounted) {
          Navigator.pop(context);
          _showSnackBar(
            context,
            'Success',
            'Address updated successfully',
            Colors.green,
          );
        }
        notifyListeners();
      }
    } catch (e) {
      if (context.mounted) {
        _showSnackBar(context, 'Error', 'Failed to update address', Colors.red);
      }
    }
  }

  void selectAddress(int index) {
    if (index >= 0 && index < shippingAddresses.length) {
      selectedAddressIndex = index;
      currentShipping = shippingAddresses[index];
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    editNameController.dispose();
    editAddressController.dispose();
    super.dispose();
  }
}
