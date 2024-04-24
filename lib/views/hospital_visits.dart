import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/controllers/hospital_visits_controller.dart';
import 'package:patient_tracker/models/hospital_visit-model.dart';


HospitalVisitController hospitalVisitController = Get.put(HospitalVisitController());

class HospitalVisitPage extends StatefulWidget {
  @override
  _HospitalVisitPageState createState() => _HospitalVisitPageState();
}

class _HospitalVisitPageState extends State<HospitalVisitPage> {
  bool _isLoading = false;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _fetchHospitalVisits();
  }

  Future<void> _fetchHospitalVisits() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          "http://acs314flutter.xyz/Patient-tracker/get_hospital_visits.php?user_id=1"));

      if (response.statusCode == 200) {
        var serverResponse = json.decode(response.body);
        var hospitalVisitsData = serverResponse['hospital_visits'];
        var hospitalVisitList = hospitalVisitsData
            .map<HospitalVisit>(
                (hospitalVisit) => HospitalVisit.fromJson(hospitalVisit))
            .toList();
        hospitalVisitController.updateHospitalVisit(hospitalVisitList);
      } else {
        throw Exception('Failed to load hospital visits from API');
      }
    } catch (e) {
      print('Error fetching hospital visits: $e');
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
      'Failed to fetch hospital visits. Please try again later.',
      backgroundColor: pinkColor,
      colorText: appbartextColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: const Text('Your Hospital Visits',
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
                      hintText: "Search for your hospital visits...",
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
                Expanded(child: _buildHospitalVisitListView()),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchHospitalVisits,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
        backgroundColor: appbartextColor,
      ),
    );
  }

  Widget _buildHospitalVisitListView() {
    return Obx(() {
      if (hospitalVisitController.hospital_visits.isEmpty) {
        return const Center(
          child: Text(
            'No hospital visits available',
            style: TextStyle(color: appbartextColor),
          ),
        );
      } else {
        var displayedHospitalVisits = hospitalVisitController.hospital_visits
            .where((hospitalVisit) => hospitalVisit.description.contains(_searchText))
            .toList();

        return ListView.builder(
          itemCount: displayedHospitalVisits.length,
          itemBuilder: (context, index) {
            return _buildHospitalVisitCard(
                index, displayedHospitalVisits as List<HospitalVisit>);
          },
        );
      }
    });
  }

  Widget _buildHospitalVisitCard(
      int index, List<HospitalVisit> hospital_visits) {
    final hospital_visit = hospital_visits[index];
    return Card(
      elevation: 5,
      color: appbartextColor.withOpacity(0.6),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(
                  Icons.sentiment_very_satisfied_outlined,
                  color: primaryColor,
                ),
                SizedBox(width: 5),
              ],
            ),
            Text(
              'Hospital Visit ID: ${hospital_visit.id}',
              style: const TextStyle(color: primaryColor),
            ),
            Text(
              'Hospital Visit Date: ${hospital_visit.visit_date}',
              style: const TextStyle(color: primaryColor),
            ),
            Text(
              'Description: ${hospital_visit.description}',
              style: const TextStyle(color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
