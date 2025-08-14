import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_tracker/configs/firebase_options.dart';
import 'package:patient_tracker/core/controllers/main_controller.dart';
import 'package:patient_tracker/core/theme/app_theme.dart';
import 'package:patient_tracker/utils/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AfyaYanguApp());
}

class AfyaYanguApp extends StatelessWidget {
  const AfyaYanguApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Initialize main controller which handles all other controllers
    Get.put(MainController());
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return GetMaterialApp(
          title: 'Afya Yangu',
          initialRoute: snapshot.hasData ? "/home" : "/welcome",
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system, // Default to system theme
          getPages: Routes.routes,
        );
      },
    );
  }
}
