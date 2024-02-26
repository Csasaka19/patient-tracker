import 'package:get/get.dart';
import 'package:patient_tracker/views/dashboards/desktop.dart';
import 'package:patient_tracker/views/dashboards/mobile.dart';
import 'package:patient_tracker/views/dashboards/responsive_layout.dart';
import 'package:patient_tracker/views/dashboards/tablet.dart';
import 'package:patient_tracker/views/login.dart';
import 'package:patient_tracker/views/registration.dart';

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
  ];
}
