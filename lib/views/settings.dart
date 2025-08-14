import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_tracker/widgets/common/theme_switch.dart';

class SettingsController extends GetxController {
  final notificationsEnabled = true.obs;
  final appointmentReminders = true.obs;
  final medicationReminders = true.obs;
  final healthTips = false.obs;
  final dataSync = true.obs;
  final biometricAuth = false.obs;
  final autoBackup = true.obs;
  final selectedLanguage = 'English'.obs;
  final selectedDateFormat = 'DD/MM/YYYY'.obs;
  final selectedTimeFormat = '12 Hour'.obs;

  final List<String> languages = ['English', 'Swahili', 'French', 'Spanish'];
  final List<String> dateFormats = ['DD/MM/YYYY', 'MM/DD/YYYY', 'YYYY-MM-DD'];
  final List<String> timeFormats = ['12 Hour', '24 Hour'];

  void toggleNotifications(bool value) => notificationsEnabled.value = value;
  void toggleAppointmentReminders(bool value) =>
      appointmentReminders.value = value;
  void toggleMedicationReminders(bool value) =>
      medicationReminders.value = value;
  void toggleHealthTips(bool value) => healthTips.value = value;
  void toggleDataSync(bool value) => dataSync.value = value;
  void toggleBiometricAuth(bool value) => biometricAuth.value = value;
  void toggleAutoBackup(bool value) => autoBackup.value = value;

  void setLanguage(String language) => selectedLanguage.value = language;
  void setDateFormat(String format) => selectedDateFormat.value = format;
  void setTimeFormat(String format) => selectedTimeFormat.value = format;
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: ThemeSwitchIcon(),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Account Settings Section
          _buildSectionHeader(context, 'Account Settings'),
          _buildSettingsCard(
            context,
            children: [
              _buildSettingsTile(
                context,
                icon: Icons.person_outline,
                title: 'Edit Profile',
                subtitle: 'Update your personal information',
                onTap: () => Get.toNamed('/profile'),
              ),
              _buildDivider(),
              _buildSettingsTile(
                context,
                icon: Icons.lock_outline,
                title: 'Change Password',
                subtitle: 'Update your account password',
                onTap: () {
                  _showChangePasswordDialog(context);
                },
              ),
            ],
          ),

          // Notifications Section
          _buildSectionHeader(context, 'Notifications'),
          _buildSettingsCard(
            context,
            children: [
              Obx(() => _buildSwitchTile(
                    context,
                    icon: Icons.notifications_outlined,
                    title: 'Enable Notifications',
                    subtitle: 'Receive app notifications',
                    value: controller.notificationsEnabled.value,
                    onChanged: controller.toggleNotifications,
                  )),
              _buildDivider(),
              Obx(() => _buildSwitchTile(
                    context,
                    icon: Icons.calendar_today_outlined,
                    title: 'Appointment Reminders',
                    subtitle: 'Get notified about upcoming appointments',
                    value: controller.appointmentReminders.value,
                    onChanged: controller.toggleAppointmentReminders,
                  )),
              _buildDivider(),
              Obx(() => _buildSwitchTile(
                    context,
                    icon: Icons.medication_outlined,
                    title: 'Medication Reminders',
                    subtitle: 'Get reminded to take your medications',
                    value: controller.medicationReminders.value,
                    onChanged: controller.toggleMedicationReminders,
                  )),
            ],
          ),

          // Preferences Section
          _buildSectionHeader(context, 'Preferences'),
          _buildSettingsCard(
            context,
            children: [
              Obx(() => _buildDropdownTile(
                    context,
                    icon: Icons.language_outlined,
                    title: 'Language',
                    subtitle: 'Choose your preferred language',
                    value: controller.selectedLanguage.value,
                    items: controller.languages,
                    onChanged: controller.setLanguage,
                  )),
              _buildDivider(),
              Obx(() => _buildDropdownTile(
                    context,
                    icon: Icons.date_range_outlined,
                    title: 'Date Format',
                    subtitle: 'Select date display format',
                    value: controller.selectedDateFormat.value,
                    items: controller.dateFormats,
                    onChanged: controller.setDateFormat,
                  )),
            ],
          ),

          // Support Section
          _buildSectionHeader(context, 'Support'),
          _buildSettingsCard(
            context,
            children: [
              _buildSettingsTile(
                context,
                icon: Icons.help_outline,
                title: 'Help & Support',
                subtitle: 'Get help and contact support',
                onTap: () => Get.toNamed('/help_support'),
              ),
              _buildDivider(),
              _buildSettingsTile(
                context,
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'App version and information',
                onTap: () {
                  _showAboutDialog(context);
                },
              ),
            ],
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context,
      {required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? titleColor,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: titleColor ?? Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: titleColor,
            ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDropdownTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(subtitle),
      trailing: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, indent: 56);
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.snackbar(
                'Success',
                'Password changed successfully',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Afya Yangu'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Afya Yangu Patient Tracker'),
            SizedBox(height: 8),
            Text('Version: 1.0.0'),
            SizedBox(height: 8),
            Text('Your comprehensive health management solution.'),
            SizedBox(height: 16),
            Text('© 2024 Afya Yangu. All rights reserved.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
