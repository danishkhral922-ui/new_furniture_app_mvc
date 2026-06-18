import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/profile_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/switch_controller.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    final switchProvider = context.read<SwitchProvider>();
    final profileProvider = context.read<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              _buildSectionHeader(
                context,
                'Personal Information',
                hasEdit: true,
                onEditTap: () => _showEditNameDialog(context, profileProvider),
              ),
              const SizedBox(height: 10),
              Consumer<ProfileProvider>(
                builder: (context, provider, child) {
                  return _buildInfoCard('Name', provider.userName);
                },
              ),
              const SizedBox(height: 15),
              Consumer<ProfileProvider>(
                builder: (context, provider, child) {
                  return _buildInfoCard('Email', provider.userEmail);
                },
              ),
              const SizedBox(height: 20),
              _buildSectionHeader(
                context,
                'Password',
                hasEdit: true,
                onEditTap: () {},
              ),
              const SizedBox(height: 10),
              _buildInfoCard('Password', '***************'),
              const SizedBox(height: 20),
              _buildSectionHeader(context, 'Notifications'),
              const SizedBox(height: 10),
              Consumer<SwitchProvider>(
                builder: (context, provider, child) {
                  return _buildSwitchCard(
                    'Sales',
                    provider.switch1,
                    (value) => provider.setSwitch1(value),
                  );
                },
              ),
              const SizedBox(height: 10),
              Consumer<SwitchProvider>(
                builder: (context, provider, child) {
                  return _buildSwitchCard(
                    'New arrivals',
                    provider.switch2,
                    (value) => provider.setSwitch1(value),
                  );
                },
              ),
              const SizedBox(height: 10),
              _buildNavigationCard('Delivery status changes', onTap: () {}),
              const SizedBox(height: 20),
              _buildSectionHeader(context, 'Help Center'),
              const SizedBox(height: 10),
              _buildNavigationCard('FAQ', onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchCard(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SizedBox(
      height: 54,
      width: 335,
      child: Card(
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
                ),
              ),
              Switch(
                value: value,
                activeThumbColor: Colors.white,
                activeTrackColor: Colors.green,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey[400],
                onChanged: onChanged,
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
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditNameDialog(
    BuildContext context,
    ProfileProvider profileProvider,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final TextEditingController nameController = TextEditingController(
      text: profileProvider.userName,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
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
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.white : Colors.black,
              ),
              onPressed: () async {
                if (nameController.text.trim().isNotEmpty) {
                  await profileProvider.updateProfile(
                    context,
                    nameController.text.trim(),
                  );
                  if (context.mounted) Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Name cannot be empty'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text(
                'SAVE',
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
}
