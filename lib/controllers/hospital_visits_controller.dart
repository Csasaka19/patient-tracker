import 'package:get/get.dart';

class HospitalVisitController extends GetxController {
  var hospital_vists = [].obs;

  updateHospitalVisit(list) {
    this.hospital_vists.value = list;
  }
}
