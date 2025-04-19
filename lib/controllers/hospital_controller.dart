import 'package:get/get.dart';

class HospitalController extends GetxController {
  var hospitals = [].obs;

  updateHospital(list) {
    hospitals.value = list;
  }
}
