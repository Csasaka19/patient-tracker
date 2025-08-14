import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HospitalController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final searchText = ''.obs;

  Stream<QuerySnapshot> get hospitalsStream {
    return _firestore.collection('hospitals').snapshots();
  }

  void search(String text) {
    searchText.value = text;
  }
}
