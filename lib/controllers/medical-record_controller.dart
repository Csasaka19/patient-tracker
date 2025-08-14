import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MedicalRecordsController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final searchText = ''.obs;

  Stream<QuerySnapshot> get medicalRecordsStream {
    return _firestore.collection('medical_records').snapshots();
  }

  void search(String text) {
    searchText.value = text;
  }
}
