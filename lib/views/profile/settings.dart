import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_furiniture_app_mvc/controllers/switch_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/profile_controller.dart';

class Setting extends StatelessWidget {
  Setting({super.key});

  final controller = Get.put(SwitchController());
  final profileController = Get.isRegistered<ProfileController>()
      ? Get.find<ProfileController>()
      : Get.put(ProfileController());

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
              _buildSectionHeader(
                'Personal Information',
                hasEdit: true,
                onEditTap: () => _showEditNameDialog(context),
              ),
              const SizedBox(height: 10),
              Obx(
                () => _buildInfoCard('Name', profileController.userName.value),
              ),
              const SizedBox(height: 15),
              Obx(
                () =>
                    _buildInfoCard('Email', profileController.userEmail.value),
              ),
              const SizedBox(height: 20),
              _buildSectionHeader('Password', hasEdit: true, onEditTap: () {}),
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

  Widget _buildSectionHeader(
    String title, {
    bool hasEdit = false,
    VoidCallback? onEditTap,
  }) {
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
        if (hasEdit)
          GestureDetector(
            onTap: onEditTap,
            child: Image.asset('assets/images/edit.png', color: Colors.grey),
          ),
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

  void _showEditNameDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController(
      text: profileController.userName.value,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Edit Name',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('CANCEL', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () async {
                if (nameController.text.trim().isNotEmpty) {
                  await profileController.updateProfile(
                    nameController.text.trim(),
                  );
                  Get.back();
                } else {
                  Get.snackbar(
                    'Error',
                    'Name cannot be empty',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: const Text('SAVE', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
