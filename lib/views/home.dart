import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/views/dashboards/mobile.dart';
import 'package:patient_tracker/views/login.dart';
import 'package:patient_tracker/views/profile.dart';
import 'package:patient_tracker/views/settings.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:patient_tracker/controllers/screen_controller.dart';
import 'package:get/get.dart';


ScreenController screenController = Get.put(ScreenController());

var screens = [
  MobileScaffold(),
  ProfilePage(),
  Settings(),
  const Login(),
];

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => SalomonBottomBar(
            backgroundColor: green,
            currentIndex: screenController.selectedScreen.value,
            onTap: (index) => screenController.updatePage(index),
            items: [
              SalomonBottomBarItem(
                icon: Icon(Icons.home),
                title: const Text("Home"),
                selectedColor: primaryColor,
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.person),
                title: const Text("Profile"),
                selectedColor: pinkColor,
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.settings),
                title: const Text("Settings"),
                selectedColor:orangeColor,
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.logout),
                title: const Text("Logout"),
                selectedColor: purpleColor,
              ),
            ],
          )),
      body: Obx(() => Center(
            child: screens[screenController.selectedScreen.value],
          )),
    );
  }
}
