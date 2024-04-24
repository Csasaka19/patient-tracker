import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/controllers/medical-record_controller.dart';
import 'package:patient_tracker/models/medical_records-model.dart';


MedicalRecordsController medicalController = Get.put(MedicalRecordsController());

class MedicalRecordsPage extends StatefulWidget {
  @override
  _MedicalRecordsPageState createState() => _MedicalRecordsPageState();
}

class _MedicalRecordsPageState extends State<MedicalRecordsPage> {
  bool _isLoading = false;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _fetchMedicalRecords();
  }

  Future<void> _fetchMedicalRecords() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          "http://acs314flutter.xyz/Patient-tracker/get_medical_records.php?user_id=1"));

      if (response.statusCode == 200) {
        var serverResponse = json.decode(response.body);
        var medicalRecordsData = serverResponse['medical_records'];
        var medicalRecordList = medicalRecordsData
            .map<MedicalRecord>(
                (medicalRecord) => MedicalRecord.fromJson(medicalRecord))
            .toList();
        medicalController.updateMedicalRecords(medicalRecordList);
      } else {
        throw Exception('Failed to load medical records from API');
      }
    } catch (e) {
      print('Error fetching medical records: $e');
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
      'Failed to fetch medical records. Please try again later.',
      backgroundColor: pinkColor,
      colorText: appbartextColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: const Text('Your Medical Records',
            style: TextStyle(color: appbartextColor)),
        backgroundColor: blackColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search for your medical records...",
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
                Expanded(child: _buildMedicalRecordListView()),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchMedicalRecords,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
        backgroundColor: appbartextColor,
      ),
    );
  }

  Widget _buildMedicalRecordListView() {
    return Obx(() {
      if (medicalController.medical_records.isEmpty) {
        return const Center(
          child: Text(
            'No medical records available',
            style: TextStyle(color: appbartextColor),
          ),
        );
      } else {
        var displayedMedicalRecords = medicalController.medical_records
            .where((medicalRecord) => medicalRecord.description.contains(_searchText))
            .toList();

        return ListView.builder(
          itemCount: displayedMedicalRecords.length,
          itemBuilder: (context, index) {
            return _buildMedicalRecordCard(
                index, displayedMedicalRecords as List<MedicalRecord>);
          },
        );
      }
    });
  }

  Widget _buildMedicalRecordCard(
      int index, List<MedicalRecord> medical_records) {
    final medical_record = medical_records[index];
    return Card(
      elevation: 5,
      color: greyColor,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(
                  Icons.info,
                  color: primaryColor,
                ),
                SizedBox(width: 5),
              ],
            ),
            Text(
              'Medical Record ID: ${medical_record.id}',
              style: const TextStyle(color: primaryColor),
            ),
            Text(
              'Medical Record Date: ${medical_record.record_date}',
              style: const TextStyle(color: primaryColor),
            ),
            Text(
              'Description: ${medical_record.description}',
              style: const TextStyle(color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
