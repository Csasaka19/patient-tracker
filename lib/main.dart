import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_tracker/utils/routes/routes.dart';
import 'package:patient_tracker/views/dashboards/desktop.dart';
import 'package:patient_tracker/views/dashboards/mobile.dart';
import 'package:patient_tracker/views/dashboards/responsive_layout.dart';
import 'package:patient_tracker/views/dashboards/tablet.dart';
import 'package:patient_tracker/views/login.dart';
import 'package:patient_tracker/views/registration.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: "/login",
    debugShowCheckedModeBanner: false,
    getPages: Routes.routes,
  ));
}
