import 'package:get/get.dart';
import 'package:patient_tracker/views/mobile.dart';
import 'package:patient_tracker/views/home.dart';
import 'package:patient_tracker/views/login.dart';
import 'package:patient_tracker/views/onboarding.dart';
import 'package:patient_tracker/views/profile.dart';
import 'package:patient_tracker/views/registration.dart';
import 'package:patient_tracker/views/settings.dart';
import 'package:patient_tracker/views/welcome.dart';

class Routes {
  static var routes = [
    GetPage(name: '/login', page: () => Login()),
    GetPage(name: '/registration', page: () => Registration()),
    GetPage(name: '/mobile', page: () => const MobileScaffold()),
    GetPage(name: '/home', page: () => Home()),
    GetPage(name: '/profile', page: () => Profile_screen()),
    GetPage(name: '/settings', page: () => Settings()),
    GetPage(name: '/welcome', page: () => const WelcomeView()),
    GetPage(name: '/onboarding', page: () =>  OnboardingView()),
  ];
}
