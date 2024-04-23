import 'package:get/get.dart';

class DoctorRecordsController extends GetxController {
  var doctor_records = [].obs;

  updateDoctorRecords(list) {
    this.doctor_records.value = list;
  }
}
