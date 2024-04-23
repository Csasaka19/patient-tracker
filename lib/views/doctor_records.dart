import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/controllers/doctor_records_controller.dart';
import 'package:patient_tracker/models/doctor_records-model.dart';

DoctorRecordsController doctorRecordsController = Get.put(DoctorRecordsController());

class DoctorRecordsPage extends StatefulWidget {
  @override
  _DoctorRecordsPageState createState() => _DoctorRecordsPageState();
}

class _DoctorRecordsPageState extends State<DoctorRecordsPage> {
  bool _isLoading = false;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _fetchDoctorRecords();
  }

  Future<void> _fetchDoctorRecords() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          "http://acs314flutter.xyz/Patient-tracker/get_doctor_records.php?user_id=1"));

      if (response.statusCode == 200) {
        var serverResponse = json.decode(response.body);
        var doctorRecordsData = serverResponse['doctor_records'];
        var doctorRecordsList = doctorRecordsData
            .map<DoctorRecords>(
                (doctorRecord) => DoctorRecords.fromJson(doctorRecord))
            .toList();
        doctorRecordsController.updateDoctorRecords(doctorRecordsList);
      } else {
        throw Exception('Failed to load doctor records from API');
      }
    } catch (e) {
      print('Error fetching doctor records: $e');
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
      'Failed to fetch doctor records. Please try again later.',
      backgroundColor: pinkColor,
      colorText: appbartextColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: const Text('Your Doctor Records',
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
                      hintText: "Search for your doctor records...",
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
                Expanded(child: _buildDoctorRecordsListView()),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchDoctorRecords,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
        backgroundColor: appbartextColor,
      ),
    );
  }

  Widget _buildDoctorRecordsListView() {
    return Obx(() {
      if (doctorRecordsController.doctor_records.isEmpty) {
        return const Center(
          child: Text(
            'No doctor records available',
            style: TextStyle(color: appbartextColor),
          ),
        );
      } else {
        var displayedDoctorRecords = doctorRecordsController.doctor_records
            .where((record) => record.description.contains(_searchText))
            .toList();

        return ListView.builder(
          itemCount: displayedDoctorRecords.length,
          itemBuilder: (context, index) {
            return _buildDoctorRecordCard(
                index, displayedDoctorRecords as List<DoctorRecords>);
          },
        );
      }
    });
  }

  Widget _buildDoctorRecordCard(int index, List<DoctorRecords> doctorRecords) {
    final doctorRecord = doctorRecords[index];
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              'Record ID: ${doctorRecord.id}',
              style: const TextStyle(color: appbartextColor),
            ),
            Text(
              'Record Date: ${doctorRecord.record_date}',
              style: const TextStyle(color: appbartextColor),
            ),
            Text(
              'Record Description: ${doctorRecord.description}',
              style: const TextStyle(color: appbartextColor),
            ),
          ],
        ),
      ),
    );
  }
}
