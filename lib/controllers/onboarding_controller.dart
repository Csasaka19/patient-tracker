import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:patient_tracker/configs/onboarding_info.dart';

class OnboardingController extends GetxController{
  RxInt selectedPageIndex = 0.obs;
  bool get isLastScreen => selectedPageIndex.value == onboardingScreens.length - 1;

  PageController  pageController = PageController();

  fowardAction(){
    if(isLastScreen){
      Get.offAllNamed('/login');
    }else{
      pageController.nextPage(duration: const Duration(milliseconds: 12000), curve: Curves.ease);
    }
  }

  List<OnboardingInfo> onboardingScreens = [
    OnboardingInfo(
      'assets/onboarding/onboarding_1.jpg',
      'Welcome to the Patient Tracker Application!',
      'The best app to manage your patients',
    ),
    OnboardingInfo(
      'assets/onboarding/onboarding_2.jpg',
      'Get Started',
      'Create an account and start managing your patient records and appointments and every health related thing at the palm of you hand',
    ),
    OnboardingInfo(
      'assets/onboarding/onboarding_3.jpg',
      'Get Notified from anywhere',
      'Get notified when your appointments, medication and doctors need your urgent attention',
    ),
  ];
}