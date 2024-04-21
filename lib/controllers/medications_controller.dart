import 'package:get/get.dart';

class MedicationController extends GetxController{
  var medications = [].obs;

  updateMedications(list){
    this.medications.value = list;
  }
}