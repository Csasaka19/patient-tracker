import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/controllers/medications_controller.dart';
import 'package:patient_tracker/models/medications_model.dart';

MedicationController medicationController = Get.put(MedicationController());

class MedicationPage extends StatefulWidget {
  @override
  _MedicationPageState createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: const Text('Medications'),
        backgroundColor: appbartextColor,
      ),
      body: Obx(() {
        if (medicationController.medications.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
             itemCount: medicationController.medications.length,
             itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(
                    medicationController.medications[index].image),
                title: Text(
                    'Medication Name: ${medicationController.medications[index].name}',
                    style: const TextStyle(color: appbartextColor)),
                subtitle: Text(
                    'Medication Description: ${medicationController.medications[index].description}',
                    style: const TextStyle(color: appbartextColor)),
              );
            },
          );
        }
      }),
    );
  }

  Future<void> fetchMedications() async {
    http.Response response;
    response = await http.get(Uri.parse("http://acs314flutter.xyz/Patient-tracker/get_medications.php"));

    if(response.statusCode == 200) {
      var serverResponse = json.decode(response.body);
      var medications = serverResponse['medications'];
      var medicationsLIst = medications.map<Medication>((medication) => Medication.fromJson(medication)).toList();
      medicationController.updateMedications(medicationsLIst);
    } else {
      throw Exception('Failed to load medications from API');
    }
  }
}
