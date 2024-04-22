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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchMedications();
  }

  Future<void> _fetchMedications() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          "http://acs314flutter.xyz/Patient-tracker/get_medications.php"));

      if (response.statusCode == 200) {
        var serverResponse = json.decode(response.body);
        var medications = serverResponse['medications'];
        var medicationsList = medications
            .map<Medication>((medication) => Medication.fromJson(medication))
            .toList();
        medicationController.updateMedications(medicationsList);
      } else {
        throw Exception('Failed to load medications from API');
      }
    } catch (e) {
      print('Error fetching medications: $e');
      _showErrorSnackBar();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorSnackBar() {
    Get.snackbar(
      'Error',
      'Failed to fetch medications. Please try again later.',
      backgroundColor: pinkColor,
      colorText: appbartextColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: const Text('Medications'),
        backgroundColor: appbartextColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildMedicationsListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchMedications,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
        backgroundColor: appbartextColor,
      ),
    );
  }

  Widget _buildMedicationsListView() {
    return Obx(() {
      if (medicationController.medications.isEmpty) {
        return const Center(
          child: Text(
            'No medications available',
            style: TextStyle(color: appbartextColor),
          ),
        );
      } else {
        return ListView.builder(
          itemCount: medicationController.medications.length,
          itemBuilder: (context, index) {
            return _buildMedicationListTile(index);
          },
        );
      }
    });
  }

  Widget _buildMedicationListTile(int index) {
    final medication = medicationController.medications[index];
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: ListTile(
        leading: SizedBox(
          width: 60,
          height: 150,
          child: _buildMedicationImage(index),
        ),
        title: Text(
          'Medication Name: ${medication.name}',
          style: const TextStyle(color: appbartextColor),
        ),
        subtitle: Text(
          'Medication Description: ${medication.description}',
          style: const TextStyle(color: appbartextColor),
        ),
      ),
    );
  }

  Widget _buildMedicationImage(int index) {
    final medication = medicationController.medications[index];
    return medication.image.isNotEmpty
        ? Image.network(
            medication.image,
            fit: BoxFit.cover,
          )
        : const Placeholder(
            fallbackHeight: 50,
            fallbackWidth: 50,
          );
  }
}
