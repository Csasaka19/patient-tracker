import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_tracker/core/theme/app_theme.dart';
import 'package:patient_tracker/widgets/common/theme_switch.dart';
import 'package:patient_tracker/core/data/mock_data.dart';

class Profile_screen extends StatelessWidget {
  const Profile_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final userData = MockUser.userData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: ThemeSwitchIcon(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32),
              width: double.infinity,
              child: Column(
                children: [
                  // Profile Image
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).colorScheme.primary),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                            )
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: AssetImage("assets/logos/man.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 2,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: IconButton(
                            icon:
                                const Icon(Icons.camera_alt_rounded, size: 20),
                            color: Theme.of(context).colorScheme.onPrimary,
                            onPressed: () {
                              // Image picking functionality would go here
                              Get.snackbar(
                                'Feature Coming Soon',
                                'Profile picture update will be available in a future update.',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // User Name
                  Text(
                    "${userData['firstName']} ${userData['lastName']}",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  const SizedBox(height: 8),

                  // User Email
                  Text(
                    userData['email'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.7),
                        ),
                  ),

                  const SizedBox(height: 24),

                  // User Info Cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildInfoCard(
                          context,
                          icon: Icons.calendar_today_rounded,
                          title: "DOB",
                          value: userData['dob'],
                        ),
                        _buildInfoCard(
                          context,
                          icon: Icons.bloodtype_rounded,
                          title: "Blood Type",
                          value: userData['bloodType'],
                        ),
                        _buildInfoCard(
                          context,
                          icon: Icons.phone_rounded,
                          title: "Phone",
                          value: userData['phone'],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Profile Menu Items
            Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        "Menu",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildProfileMenuItem(
                      context,
                      icon: Icons.medical_services_rounded,
                      title: "Doctors and Appointments",
                      onTap: () => Get.toNamed('/doctors'),
                    ),
                    _buildProfileMenuItem(
                      context,
                      icon: Icons.medication_rounded,
                      title: "Medications",
                      onTap: () => Get.toNamed('/medication'),
                    ),
                    _buildProfileMenuItem(
                      context,
                      icon: Icons.folder_special_rounded,
                      title: "Medical Records",
                      onTap: () => Get.toNamed('/medical_records'),
                    ),
                    _buildProfileMenuItem(
                      context,
                      icon: Icons.local_hospital_rounded,
                      title: "Hospitals",
                      onTap: () => Get.toNamed('/hospitals'),
                    ),
                    _buildProfileMenuItem(
                      context,
                      icon: Icons.settings_rounded,
                      title: "Settings",
                      onTap: () {
                        Get.snackbar(
                          'Feature Coming Soon',
                          'Settings will be available in a future update.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                    ),
                    _buildProfileMenuItem(
                      context,
                      icon: Icons.help_outline_rounded,
                      title: "Help & Support",
                      onTap: () => Get.toNamed('/help'),
                    ),
                    const SizedBox(height: 8),
                    _buildProfileMenuItem(
                      context,
                      icon: Icons.logout_rounded,
                      title: "Log out",
                      color: AppTheme.error,
                      onTap: () => Get.toNamed('/login'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: color ?? Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
              ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
        ),
      ),
    );
  }
}
