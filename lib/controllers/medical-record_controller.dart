import 'package:get/get.dart';

class MedicalRecordsController extends GetxController {
  var medical_records = [].obs;

  updateMedicalRecords(list) {
    this.medical_records.value = list;
  }
}
