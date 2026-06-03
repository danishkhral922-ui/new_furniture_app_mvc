import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/controllers/switch_controller.dart';

class Setting extends StatelessWidget {
  Setting({super.key});

  final controller = Get.put(SwitchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              _buildSectionHeader('Personal Information', hasEdit: true),
              const SizedBox(height: 10),
              _buildInfoCard('Name', 'Bruno Pham'),
              const SizedBox(height: 15),
              _buildInfoCard('Email', 'bruno203@gmail.com'),
              const SizedBox(height: 20),
              _buildSectionHeader('Password', hasEdit: true),
              const SizedBox(height: 10),
              _buildInfoCard('Password', '***************'),
              const SizedBox(height: 20),
              _buildSectionHeader('Notifications'),
              const SizedBox(height: 10),
              _buildSwitchCard('Sales', controller.switch1),
              const SizedBox(height: 10),
              _buildSwitchCard('New arrivals', controller.switch2),
              const SizedBox(height: 10),
              _buildNavigationCard('Delivery status changes', onTap: () {}),
              const SizedBox(height: 20),
              _buildSectionHeader('Help Center'),
              const SizedBox(height: 10),
              _buildNavigationCard('FAQ', onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool hasEdit = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        if (hasEdit) Image.asset('assets/images/edit.png', color: Colors.grey),
      ],
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return SizedBox(
      height: 64,
      width: 335,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.grey.withAlpha(60),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchCard(String title, RxBool rxValue) {
    return SizedBox(
      height: 54,
      width: 335,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.grey.withAlpha(60),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Obx(
                () => Switch(
                  value: rxValue.value,
                  activeThumbColor: Colors.white,
                  activeTrackColor: Colors.green,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey[400],
                  onChanged: (value) => rxValue.value = value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationCard(String title, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 54,
        width: 335,
        child: Card(
          color: Colors.white,
          shadowColor: Colors.grey.withAlpha(60),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
