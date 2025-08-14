import 'package:get/get.dart';
import 'package:patient_tracker/views/doctor_records.dart';
import 'package:patient_tracker/views/help.dart';
import 'package:patient_tracker/views/hospital_visits.dart';
import 'package:patient_tracker/views/recommendations.dart';
import 'package:patient_tracker/views/dashboard.dart';
import 'package:patient_tracker/views/doctors.dart';
import 'package:patient_tracker/views/home.dart';
import 'package:patient_tracker/views/hospitals.dart';
import 'package:patient_tracker/views/login.dart';
import 'package:patient_tracker/views/medical_records.dart';
import 'package:patient_tracker/views/medications.dart';
import 'package:patient_tracker/views/onboarding.dart';
import 'package:patient_tracker/views/profile.dart';
import 'package:patient_tracker/views/registration.dart';
import 'package:patient_tracker/views/welcome.dart';
import 'package:patient_tracker/views/help_support.dart';
import 'package:patient_tracker/views/appointments.dart';
import 'package:patient_tracker/views/settings.dart';
import 'package:patient_tracker/views/health_overview.dart';
import 'package:patient_tracker/widgets/common/page_wrapper.dart';

class Routes {
  static var routes = [
    GetPage(name: '/login', page: () => const Login()),
    GetPage(name: '/registration', page: () => const Registration()),
    GetPage(
        name: '/dashboard', page: () => const PageWrapper(child: Dashboard())),
    GetPage(name: '/home', page: () => const Home()),
    GetPage(
        name: '/profile',
        page: () => const PageWrapper(child: Profile_screen())),
    GetPage(name: '/welcome', page: () => const WelcomeView()),
    GetPage(name: '/onboarding', page: () => OnboardingView()),
    GetPage(
        name: '/medication',
        page: () => const PageWrapper(child: MedicationPage())),
    GetPage(
        name: '/medical_records',
        page: () => const PageWrapper(child: MedicalRecordsPage())),
    GetPage(
        name: '/doctors', page: () => const PageWrapper(child: DoctorPage())),
    GetPage(
        name: '/hospitals',
        page: () => const PageWrapper(child: HospitalPage())),
    GetPage(
        name: '/recommendations',
        page: () => const PageWrapper(child: RecommendationPage())),
    GetPage(
        name: '/doctor_records',
        page: () => const PageWrapper(child: DoctorRecordsPage())),
    GetPage(
        name: '/hospital_visits',
        page: () => const PageWrapper(child: HospitalVisitPage())),
    GetPage(
        name: '/help', page: () => const PageWrapper(child: UserGuidePage())),
    GetPage(name: '/help_support', page: () => const HelpSupportPage()),
    GetPage(
        name: '/appointments',
        page: () => const PageWrapper(child: AppointmentsPage())),
    GetPage(
        name: '/settings',
        page: () => const PageWrapper(child: SettingsPage())),
    GetPage(
        name: '/health_overview',
        page: () => const PageWrapper(child: HealthOverviewPage())),
  ];
}
