import 'package:get/get.dart';


class UserController extends GetxController {
  var user = [].obs;

  updateProfileDetails(list) {
    user.value = list;
  }
}