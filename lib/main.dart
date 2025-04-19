import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_tracker/core/controllers/main_controller.dart';
import 'package:patient_tracker/core/theme/app_theme.dart';
import 'package:patient_tracker/utils/routes/routes.dart';

void main() {
  runApp(const AfyaYanguApp());
}

class AfyaYanguApp extends StatelessWidget {
  const AfyaYanguApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize main controller which handles all other controllers
    Get.put(MainController());

    return GetMaterialApp(
      title: 'Afya Yangu',
      initialRoute: "/welcome",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Default to system theme
      getPages: Routes.routes,
    );
  }
}
