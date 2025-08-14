import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MedicationController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final searchText = ''.obs;

  Stream<QuerySnapshot> get medicationsStream {
    return _firestore.collection('medications').snapshots();
  }

  void search(String text) {
    searchText.value = text;
  }
}
