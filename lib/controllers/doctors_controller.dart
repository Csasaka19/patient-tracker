import 'package:get/get.dart';

class DoctorController extends GetxController {
  var doctors = [].obs;

  updateMedications(list) {
    this.doctors.value = list;
  }
}
