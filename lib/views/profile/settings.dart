import 'package:flutter/material.dart';
import 'package:new_furiniture_app_mvc/controllers/profile_controller.dart';
import 'package:new_furiniture_app_mvc/controllers/switch_controller.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _buildSectionHeader(
            'Personal Information',
            hasEdit: true,
            onEditTap: () => _showEditNameDialog(context),
          ),
          const SizedBox(height: 10),
          Consumer<ProfileProvider>(
            builder: (_, provider, _) =>
                _buildInfoCard('Name', provider.userName),
          ),
          const SizedBox(height: 10),
          Consumer<ProfileProvider>(
            builder: (_, provider, _) =>
                _buildInfoCard('Email', provider.userEmail),
          ),
          const SizedBox(height: 20),
          _buildSectionHeader('Password', hasEdit: true),
          const SizedBox(height: 10),
          _buildInfoCard('Password', '***************'),
          const SizedBox(height: 20),
          _buildSectionHeader('Notifications'),
          const SizedBox(height: 10),
          Consumer<SwitchProvider>(
            builder: (_, p, _) =>
                _buildSwitchCard('Sales', p.switch1, (v) => p.setSwitch1(v)),
          ),
          Consumer<SwitchProvider>(
            builder: (_, p, _) => _buildSwitchCard(
              'New arrivals',
              p.switch2,
              (v) => p.setSwitch1(v),
            ),
          ),
          _buildNavigationCard('Delivery status changes', () {}),
          const SizedBox(height: 20),
          _buildSectionHeader('Help Center'),
          const SizedBox(height: 10),
          _buildNavigationCard('FAQ', () {}),
        ],
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
          IconButton(
            onPressed: onEditTap,
            icon: const Icon(Icons.edit, size: 20, color: Colors.grey),
          ),
      ],
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildSwitchCard(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      child: SwitchListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        value: value,
        onChanged: onChanged,
        activeThumbColor: Colors.green,
      ),
    );
  }

  Widget _buildNavigationCard(String title, VoidCallback onTap) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showEditNameDialog(BuildContext context) {
    final provider = context.read<ProfileProvider>();
    final controller = TextEditingController(text: provider.userName);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Name'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Full Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                provider.updateProfile(context, controller.text.trim());
                Navigator.pop(context);
              }
            },
            child: Text(
              'Save',
              style: TextStyle(color: isDark ? Colors.black : Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
