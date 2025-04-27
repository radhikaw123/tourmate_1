import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('Account'),
          _buildCard([
            _buildSettingItem(Icons.person, 'Edit profile'),
            _buildSettingItem(Icons.security, 'Security'),
            _buildSettingItem(Icons.notifications, 'Notifications'),
            _buildSettingItem(Icons.lock, 'Privacy'),
          ]),
          const SizedBox(height: 20),
          _buildSectionTitle('Support & About'),
          _buildCard([
            _buildSettingItem(Icons.subscriptions, 'My Subscription'),
            _buildSettingItem(Icons.help_outline, 'Help & Support'),
            _buildSettingItem(Icons.info_outline, 'Terms and Policies'),
          ]),
          const SizedBox(height: 20),
          _buildSectionTitle('Cache & cellular'),
          _buildCard([
            _buildSettingItem(Icons.delete_outline, 'Free up space'),
            _buildSettingItem(Icons.data_usage, 'Data Saver'),
          ]),
          const SizedBox(height: 20),
          _buildSectionTitle('Actions'),
          _buildCard([
            _buildSettingItem(
              Icons.report_problem_outlined,
              'Report a problem',
            ),
            _buildSettingItem(Icons.person_add_alt, 'Add account'),
            _buildSettingItem(Icons.logout, 'Log out'),
          ]),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Card(
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(children: children),
    );
  }

  Widget _buildSettingItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: () {
        // No action for now
      },
    );
  }
}
