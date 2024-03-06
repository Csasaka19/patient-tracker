
import 'package:get/get.dart';

class ScreenController extends GetxController {
  var selectedScreen = 0.obs;

  updatePage(int pageIndex) => selectedScreen.value = pageIndex;
}