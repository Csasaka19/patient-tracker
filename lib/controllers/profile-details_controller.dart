import 'package:get/get.dart';


class UserController extends GetxController {
  var user = [].obs;

  updateProfileDetails(list) {
    this.user.value = list;
  }
}