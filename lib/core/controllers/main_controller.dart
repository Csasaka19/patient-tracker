import 'package:get/get.dart';
import 'package:patient_tracker/core/controllers/theme_controller.dart';

class MainController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _initControllers();
  }

  void _initControllers() {
    // Initialize all necessary controllers here
    Get.put(ThemeController(), permanent: true);
  }
}
