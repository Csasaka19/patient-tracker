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
  String _searchText = "";

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
        title:
            const Text('Medications', style: TextStyle(color: appbartextColor)),
        backgroundColor: blackColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    scrollPhysics: const BouncingScrollPhysics(),
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search for medications",
                      prefixIcon: const Icon(
                        Icons.search,
                        color: appbartextColor,
                      ),
                      suffixIcon: const Icon(
                        Icons.filter_list,
                        color: appbartextColor,
                      ),
                      filled: true,
                      fillColor: appbartextColor.withOpacity(0.3),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(child: _buildMedicationsGridView()),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchMedications,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
        backgroundColor: appbartextColor,
      ),
    );
  }

  Widget _buildMedicationsGridView() {
    return Obx(() {
      if (medicationController.medications.isEmpty) {
        return const Center(
          child: Text(
            'No medications available',
            style: TextStyle(color: appbartextColor),
          ),
        );
      } else {
        var displayedMedications = medicationController.medications
            .where((medication) => medication.name.contains(_searchText))
            .toList();

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: displayedMedications.length,
          itemBuilder: (context, index) {
            return _buildMedicationContainer(
                index, displayedMedications as List<Medication>);
          },
        );
      }
    });
  }

  Widget _buildMedicationContainer(int index, List<Medication> medications) {
    final medication = medications[index];
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: _buildMedicationImage(index, medications),
          ),
          Text(
            'Medication Name: ${medication.name}',
            style: const TextStyle(color: appbartextColor),
          ),
          Text(
            'Medication Description: ${medication.description}',
            style: const TextStyle(color: appbartextColor),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationImage(int index, List<Medication> medications) {
    final medication = medications[index];
    return medication.image.isNotEmpty
        ? Image.network(
            "http://acs314flutter.xyz/Patient-tracker/images/${medication.image}",
            fit: BoxFit.cover,
          )
        : const Placeholder(
            fallbackHeight: 50,
            fallbackWidth: 50,
          );
  }
}
