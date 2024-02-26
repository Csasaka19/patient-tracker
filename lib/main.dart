import 'package:flutter/material.dart';
import 'package:patient_tracker/views/dashboards/desktop.dart';
import 'package:patient_tracker/views/dashboards/mobile.dart';
import 'package:patient_tracker/views/dashboards/responsive_layout.dart';
import 'package:patient_tracker/views/dashboards/tablet.dart';
import 'package:patient_tracker/views/login.dart';
import 'package:patient_tracker/views/registration.dart';


void main() {
  runApp(   MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ResponsiveLayout(
      mobileBody: const MobileScaffold(),
      tabletBody: const TabletScaffold(),
      desktopBody: const DesktopScaffold(),
    ),
  ));
}
