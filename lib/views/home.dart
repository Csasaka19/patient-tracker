import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/views/dashboard.dart';
import 'package:patient_tracker/views/doctors.dart';
import 'package:patient_tracker/views/hospitals.dart';
import 'package:patient_tracker/views/login.dart';
import 'package:patient_tracker/views/profile.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:patient_tracker/controllers/screen_controller.dart';
import 'package:get/get.dart';


ScreenController screenController = Get.put(ScreenController());

var screens = [
  Dashboard(),
  const Profile_screen(),
  HospitalPage(),
  DoctorPage(),
  const Login(),
];

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => SalomonBottomBar(
            backgroundColor: lightBlue,
            currentIndex: screenController.selectedScreen.value,
            onTap: (index) => screenController.updatePage(index),
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home_outlined, color: blackColor,),
                title: const Text("Home", style:  TextStyle(color: primaryColor),),
                selectedColor: secondaryColor,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.person_2_outlined, color: blackColor,),
                title: const Text("Profile",style:  TextStyle(color: primaryColor)),
                selectedColor: pinkColor,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.medical_services_outlined, color: blackColor,),
                title: const Text("Hospitals", style: TextStyle(color: primaryColor)),
                selectedColor:orangeColor,
              ),
              SalomonBottomBarItem(
                icon: const Icon(
                  Icons.people_alt_outlined,
                  color: blackColor,
                ),
                title: const Text("Doctors", style: TextStyle(color: primaryColor)),
                selectedColor: orangeColor,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.help_outline_outlined),
                title: const Text("Help", style: TextStyle(color: primaryColor)),
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
