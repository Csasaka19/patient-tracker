import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/customs/custombutton.dart';
import 'package:patient_tracker/customs/customtext.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      appBar: AppBar(
        title: const CustomText(label: "Profile", fontSize: 20,),
      ),
      body:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center( 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/fit.png'),
                ),
                const SizedBox(height: 10),
                const CustomText(
                  label: 'Clive Sasaka',
                  fontSize: 16,
                  italic: true,
                  labelColor: blackColor,
                ),
                const SizedBox(height: 10),
                const CustomText(
                  label: 'dummyemail@gmail.com',
                  fontSize: 16,
                  italic: true,
                  labelColor: blackColor,
                ),
                const SizedBox(height: 20),
                // Add more relevant content here
                const CustomText(
                  label: 'Medical History',
                  fontSize: 16,
                  italic: true,
                  labelColor: blackColor,
                ),
                const SizedBox(height: 10),
                const CustomText(
                  label: 'Medication and allergies',
                  fontSize: 16,
                  italic: true,
                  labelColor: blackColor,
                ),
                const SizedBox(height: 20),
                customButton(
                  labelButton: 'Edit Profile',
                  backgroundColor: appbartextColor,
                  action: () => editProfile(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void editProfile() {
    Get.toNamed('/settings');
  }
}