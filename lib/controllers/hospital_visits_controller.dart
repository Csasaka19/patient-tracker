import 'package:get/get.dart';

class HospitalVisitController extends GetxController {
  var hospital_visits = [].obs;

  updateHospitalVisit(list) {
    this.hospital_visits.value = list;
  }
}
