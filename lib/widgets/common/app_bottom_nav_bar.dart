import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_tracker/core/theme/app_theme.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDarkMode ? const Color(0xFF1E1E1E) : AppTheme.white;
    final selectedColor =
        isDarkMode ? AppTheme.accentBlue : AppTheme.primaryBlue;
    final unselectedColor =
        Theme.of(context).colorScheme.onSurface.withOpacity(0.6);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
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
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: backgroundColor,
          selectedItemColor: selectedColor,
          unselectedItemColor: unselectedColor,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 10,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.dashboard_rounded),
              activeIcon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: selectedColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.dashboard_rounded, color: selectedColor),
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.medical_services_outlined),
              activeIcon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: selectedColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.medical_services, color: selectedColor),
              ),
              label: 'Records',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.people_outline),
              activeIcon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: selectedColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.people, color: selectedColor),
              ),
              label: 'Doctors',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.local_hospital_outlined),
              activeIcon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: selectedColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.local_hospital, color: selectedColor),
              ),
              label: 'Hospitals',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: selectedColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person, color: selectedColor),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
