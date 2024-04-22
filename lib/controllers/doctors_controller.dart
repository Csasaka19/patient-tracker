import 'package:get/get.dart';

class DoctorController extends GetxController {
  var doctors = [].obs;

  updateDoctor(list) {
    this.doctors.value = list;
  }
}
