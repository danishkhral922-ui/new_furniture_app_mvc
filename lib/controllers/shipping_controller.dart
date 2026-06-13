import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/shipping_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShippingController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Box<ShippingModel> _shippingBox = Hive.box<ShippingModel>(
    'shipping_box',
  );

  final nameController = TextEditingController();
  final addressController = TextEditingController();

  final editNameController = TextEditingController();
  final editAddressController = TextEditingController();

  var fullname = ''.obs;
  var address = ''.obs;

  var shippingAddresses = <ShippingModel>[].obs;
  var selectedAddressIndex = 0.obs;
  var currentShipping = Rxn<ShippingModel>();

  @override
  void onInit() {
    super.onInit();
    if (_shippingBox.isNotEmpty) {
      shippingAddresses.assignAll(_shippingBox.values.toList());
      selectAddress(0);
    }

    fetchCurrentAddress();
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
            shippingAddresses.add(ShippingModel.fromMap(doc.data()!));
          }
        }
        await _shippingBox.clear();
        await _shippingBox.addAll(shippingAddresses);

        if (shippingAddresses.isNotEmpty) {
          selectAddress(0);
        }
      }
    } catch (e) {
      debugPrint("Error fetching address: $e");
    }
  }

  Future<void> saveShippingAddress() async {
    if (nameController.text.isEmpty || addressController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
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

      Get.back();

      String docId = _firestore.collection('shipping_addresses').doc().id;

      await _firestore
          .collection('shipping_addresses')
          .doc(docId)
          .set(newAddress.toMap());

      shippingAddresses.add(newAddress);

      selectAddress(shippingAddresses.length - 1);

      nameController.clear();
      addressController.clear();

      Get.back();
      Get.snackbar(
        'Success',
        'Address updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save address',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> updateExistingAddress(int index, String oldFullName) async {
    if (editNameController.text.isEmpty || editAddressController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Fields cannot be empty',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      ShippingModel updatedAddress = ShippingModel(
        fullName: editNameController.text,
        address: editAddressController.text,
      );
      await _shippingBox.putAt(index, updatedAddress);
      shippingAddresses[index] = updatedAddress;

      if (selectedAddressIndex.value == index) {
        currentShipping.value = updatedAddress;
      }
      Get.back();

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

        if (selectedAddressIndex.value == index) {
          currentShipping.value = updatedAddress;
        }

        Get.back();
        Get.snackbar(
          'Success',
          'Address updated successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update address',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void selectAddress(int index) {
    if (index >= 0 && index < shippingAddresses.length) {
      selectedAddressIndex.value = index;
      currentShipping.value = shippingAddresses[index];
      shippingAddresses.refresh();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
    editNameController.dispose();
    editAddressController.dispose();
    super.onClose();
  }
}
