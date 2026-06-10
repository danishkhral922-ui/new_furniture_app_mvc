import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/shipping_model.dart';

class ShippingController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Text Editing Controllers jo UI fields ke saath map honge
  final nameController = TextEditingController();
  final addressController = TextEditingController();

  // Observable variable text updates ke liye
  var fullname = ''.obs;
  var address = ''.obs;

  // Current shipping address state holder
  var currentShipping = Rxn<ShippingModel>();

  @override
  void onInit() {
    super.onInit();
    fetchCurrentAddress();
  }

  // Firebase se data lane ka function
  void fetchCurrentAddress() async {
    try {
      var doc = await _firestore
          .collection('shipping_addresses')
          .doc('user_id_yahan_likhein')
          .get();
      if (doc.exists && doc.data() != null) {
        var shippingData = ShippingModel.fromMap(doc.data()!);
        currentShipping.value = shippingData;

        // Fields ko autofill karne ke liye jab screen load ho
        nameController.text = shippingData.fullName;
        addressController.text = shippingData.address;
      }
    } catch (e) {
      debugPrint("Error fetching address: $e");
    }
  }

  // Firebase mein save karne ka function
  Future<void> saveShippingAddress() async {
    if (nameController.text.isEmpty || addressController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      ShippingModel newAddress = ShippingModel(
        fullName: nameController.text,
        address: addressController.text,
      );

      await _firestore
          .collection('shipping_addresses')
          .doc('user_id_yahan_likhein')
          .set(newAddress.toMap());

      // Local value instant update karein taake Checkout screen refresh ho jaye
      currentShipping.value = newAddress;

      Get.back();
      Get.snackbar(
        'Success',
        'Address updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save address',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
