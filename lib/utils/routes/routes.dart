import 'package:get/get.dart';
import 'package:patient_tracker/views/appointments.dart';
import 'package:patient_tracker/views/dashboard.dart';
import 'package:patient_tracker/views/doctors.dart';
import 'package:patient_tracker/views/home.dart';
import 'package:patient_tracker/views/login.dart';
import 'package:patient_tracker/views/medical_records.dart';
import 'package:patient_tracker/views/medications.dart';
import 'package:patient_tracker/views/onboarding.dart';
import 'package:patient_tracker/views/profile.dart';
import 'package:patient_tracker/views/registration.dart';
import 'package:patient_tracker/views/settings.dart';
import 'package:patient_tracker/views/welcome.dart';

class Routes {
  static var routes = [
    GetPage(name: '/login', page: () => Login()),
    GetPage(name: '/registration', page: () => Registration()),
    GetPage(name: '/dashboard', page: () => const Dashboard()),
    GetPage(name: '/home', page: () => Home()),
    GetPage(name: '/profile', page: () => Profile_screen()),
    GetPage(name: '/settings', page: () => Settings()),
    GetPage(name: '/welcome', page: () => const WelcomeView()),
    GetPage(name: '/onboarding', page: () =>  OnboardingView()),
    GetPage(name: '/medication', page: () => MedicationPage()),
    GetPage(name: '/medical_records', page: () => MedicalRecordsPage()),
    GetPage(name: '/appointments', page: () => AppointmentsPage()),
    GetPage(name: '/doctors', page: () => DoctorPage()),
  ];
}
