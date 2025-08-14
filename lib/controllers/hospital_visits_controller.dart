import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HospitalVisitController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final searchText = ''.obs;

  Stream<QuerySnapshot> get hospitalVisitsStream {
    return _firestore.collection('hospital_visits').snapshots();
  }

  void search(String text) {
    searchText.value = text;
  }
}
