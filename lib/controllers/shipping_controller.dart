import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingController extends GetxController {
  final nameController = TextEditingController();
  final addressController = TextEditingController();

  var fullname = ''.obs;
  var address = ''.obs;

  Rxn<dynamic> get currentShipping => Rxn<dynamic>();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
