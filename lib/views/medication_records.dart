import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/customs/customtext.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.person),
                title: const CustomText(
                  label: 'Personal Information',
                  fontSize: 16,
                  italic: true,
                  labelColor: blackColor,
                ),
                subtitle: const CustomText(
                  label: 'Edit your personal information',
                  fontSize: 14,
                  labelColor: primaryColor,
                ),
                onTap: () {
                  // Personal Information Edit page
                },
              ),

              const SizedBox(height: 40),

              ListTile(
                leading: const Icon(Icons.medical_services),
                title: const CustomText(
                  label: 'Medical History',
                  fontSize: 16,
                  italic: true,
                  labelColor: blackColor,
                ),
                subtitle: const CustomText(
                  label: 'View and update your medical history',
                  fontSize: 14,
                  labelColor: primaryColor,
                ),
                onTap: () {
                  // Medical History Edit page
                },
              ),

              const SizedBox(height: 40),

              ListTile(
                leading: const Icon(Icons.healing),
                title: const CustomText(
                  label: 'Medication and Allergies',
                  fontSize: 16,
                  italic: true,
                  labelColor: blackColor,
                ),
                subtitle: const CustomText(
                  label: 'Manage your medication and allergies',
                  fontSize: 14,
                  labelColor: primaryColor,
                ),
                onTap: () {
                  // Medication and Allergies Edit page
                },
              ),

              const SizedBox(height: 40),

              ListTile(
                leading: const Icon(Icons.settings),
                title: const CustomText(
                  label: 'App Settings',
                  fontSize: 16,
                  italic: true,
                  labelColor: blackColor,
                ),
                subtitle: const CustomText(
                  label: 'Configure app settings',
                  fontSize: 14,
                  labelColor: primaryColor,
                ),
                onTap: () {
                  // App Settings page
                },
              ),

              const SizedBox(height: 40),

              ListTile(
                leading: const Icon(Icons.notifications),
                title: const CustomText(
                  label: 'Notifications',
                  fontSize: 16,
                  italic: true,
                  labelColor: blackColor,
                ),
                subtitle: const CustomText(
                  label: 'Manage notification settings',
                  fontSize: 14,
                  labelColor: primaryColor,
                ),
                onTap: () {
                  // Notifications page
                },
              ),

              const SizedBox(height: 40),

              ListTile(
                leading: const Icon(Icons.logout),
                title: const CustomText(
                  label: 'Logout',
                  fontSize: 16,
                  italic: true,
                  labelColor: blackColor,
                ),
                subtitle: const CustomText(
                  label: 'Logout from your account',
                  fontSize: 14,
                  labelColor: primaryColor,
                ),
                onTap: () {
                  // logout functionality here
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}