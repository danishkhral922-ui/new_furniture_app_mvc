import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/controllers/check_controller.dart';
import 'package:new_furiniture_app_mvc/views/shipping/add_shipping_address.dart';

class ShoppingAddress extends StatelessWidget {
  ShoppingAddress({super.key});

  final CheckController controller = Get.put(CheckController());

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Obx(
                () => Row(
                  children: [
                    Checkbox(
                      value: controller.check1.value,
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                      onChanged: (value) {
                        if (value == true) controller.changeSelection(1);
                      },
                    ),
                    Text(
                      'Use as the shipping address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: controller.check1.value
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: controller.check1.value
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 127,
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
                            const Text(
                              'Bruno Fernandes',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            Image.asset('assets/images/edit.png'),
                          ],
                        ),
                        const Divider(color: Colors.grey, thickness: 2),
                        const Text(
                          '25 rue Robert Latouche, Nice, 06200, Côte D’azur, France',
                          style: TextStyle(
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
              Obx(
                () => Row(
                  children: [
                    Checkbox(
                      value: controller.check2.value,
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                      onChanged: (value) {
                        if (value == true) controller.changeSelection(2);
                      },
                    ),
                    Text(
                      'Use as the shipping address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: controller.check2.value
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: controller.check2.value
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 127,
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
                            const Text(
                              'Bruno Fernandes',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            Image.asset('assets/images/edit.png'),
                          ],
                        ),
                        const Divider(color: Colors.grey, thickness: 2),
                        const Text(
                          '25 rue Robert Latouche, Nice, 06200, Côte D’azur, France',
                          style: TextStyle(
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
              Obx(
                () => Row(
                  children: [
                    Checkbox(
                      value: controller.check3.value,
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                      onChanged: (value) {
                        if (value == true) controller.changeSelection(3);
                      },
                    ),
                    Text(
                      'Use as the shipping address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: controller.check3.value
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: controller.check3.value
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 127,
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
                            const Text(
                              'Bruno Fernandes',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            Image.asset('assets/images/edit.png'),
                          ],
                        ),
                        const Divider(color: Colors.grey, thickness: 2),
                        const Text(
                          '25 rue Robert Latouche, Nice, 06200, Côte D’azur, France',
                          style: TextStyle(
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
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Get.to(AddShippingAddress());
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
