import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_tracker/core/theme/app_theme.dart';
import 'package:patient_tracker/views/dashboard.dart';
import 'package:patient_tracker/views/doctors.dart';
import 'package:patient_tracker/views/hospitals.dart';
import 'package:patient_tracker/views/medical_records.dart';
import 'package:patient_tracker/views/profile.dart';
import 'package:patient_tracker/widgets/common/theme_switch.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final selectedColor =
        isDarkMode ? AppTheme.accentBlue : AppTheme.primaryBlue;

    final screens = [
      const Dashboard(),
      MedicalRecordsPage(),
      DoctorPage(),
      HospitalPage(),
      const Profile_screen(),
    ];

    return Scaffold(
      body: Obx(() => screens[controller.selectedIndex.value]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: bgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, -3),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Obx(
          () => SalomonBottomBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changePage,
            selectedColorOpacity: 0.1,
            unselectedItemColor: Colors.grey.shade600,
            itemPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            items: [
              // Dashboard
              SalomonBottomBarItem(
                icon: const Icon(Icons.dashboard_rounded),
                title: const Text("Home"),
                selectedColor: selectedColor,
              ),

              // Records
              SalomonBottomBarItem(
                icon: const Icon(Icons.medical_services_outlined),
                title: const Text("Records"),
                selectedColor: selectedColor,
              ),

              // Doctors
              SalomonBottomBarItem(
                icon: const Icon(Icons.people_outline),
                title: const Text("Doctors"),
                selectedColor: selectedColor,
              ),

              // Hospitals
              SalomonBottomBarItem(
                icon: const Icon(Icons.local_hospital_outlined),
                title: const Text("Hospitals"),
                selectedColor: selectedColor,
              ),

              // Profile
              SalomonBottomBarItem(
                icon: const Icon(Icons.person_outline),
                title: const Text("Profile"),
                selectedColor: selectedColor,
              ),
            ],
          ),
        ),
      ),
      // FAB for theme toggle
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 60),
        child: const ThemeSwitchIcon(size: 20),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
