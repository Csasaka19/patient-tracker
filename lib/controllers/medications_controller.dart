import 'package:get/get.dart';

class MedicationController extends GetxController{
  var medications = [].obs;

  updateMedications(list){
    medications.value = list;
  }
}