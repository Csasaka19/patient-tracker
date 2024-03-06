import 'package:get/get.dart';
import 'package:patient_tracker/views/dashboards/desktop.dart';
import 'package:patient_tracker/views/dashboards/mobile.dart';
import 'package:patient_tracker/views/dashboards/responsive_layout.dart';
import 'package:patient_tracker/views/dashboards/tablet.dart';
import 'package:patient_tracker/views/home.dart';
import 'package:patient_tracker/views/login.dart';
import 'package:patient_tracker/views/profile.dart';
import 'package:patient_tracker/views/registration.dart';
import 'package:patient_tracker/views/settings.dart';

class Routes {
  static var routes = [
    GetPage(name: '/login', page: () => Login()),
    GetPage(name: '/registration', page: () => Registration()),
    // Dashboard changes in accordance with the screen size
    GetPage(
        name: '/dashboard',
        page: () => ResponsiveLayout(
              mobileBody: const MobileScaffold(),
              tabletBody: const TabletScaffold(),
              desktopBody: const DesktopScaffold(),
            )),
    GetPage(name: '/desktop', page: () => const DesktopScaffold()),
    GetPage(name: '/tablet', page: () => const TabletScaffold()),
    GetPage(name: '/mobile', page: () => const MobileScaffold()),
    GetPage(name: '/home', page: () => Home()),
    GetPage(name: '/profile', page: () => ProfilePage()),
    GetPage(name: '/settings', page: () => Settings()),
  ];
}
