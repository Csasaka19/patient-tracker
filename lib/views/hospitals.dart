import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/controllers/hospital_controller.dart';
import 'package:patient_tracker/models/hospital-model.dart';

HospitalController hospitalController = Get.put(HospitalController());

class HospitalPage extends StatefulWidget {
  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  bool _isLoading = false;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _fetchHospitals();
  }

  Future<void> _fetchHospitals() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          "http://acs314flutter.xyz/Patient-tracker/get_hospitals.php"));

      if (response.statusCode == 200) {
        var serverResponse = json.decode(response.body);
        var hospitals = serverResponse['hospitals'];
        var hospitalsList = hospitals
            .map<Hospital>((hospital) => Hospital.fromJson(hospital))
            .toList();
        hospitalController.updateHospital(hospitalsList);
      } else {
        throw Exception('Failed to load hospitals from API');
      }
    } catch (e) {
      print('Error fetching hospitals: $e');
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
      'Failed to fetch hospitals. Please try again later.',
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
            const Text('Hospitals', style: TextStyle(color: appbartextColor)),
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
                      hintText: "Search for hospitals near you...",
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
                Expanded(child: _buildHospitalsGridView()),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchHospitals,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
        backgroundColor: appbartextColor,
      ),
    );
  }

  Widget _buildHospitalsGridView() {
    return Obx(() {
      if (hospitalController.hospitals.isEmpty) {
        return const Center(
          child: Text(
            'No hospitals available',
            style: TextStyle(color: appbartextColor),
          ),
        );
      } else {
        var displayedHospitals = hospitalController.hospitals
            .where((hospital) => hospital.name.contains(_searchText))
            .toList();

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: displayedHospitals.length,
          itemBuilder: (context, index) {
            return _buildHospitalContainer(
                index, displayedHospitals as List<Hospital>);
          },
        );
      }
    });
  }

  Widget _buildHospitalContainer(int index, List<Hospital> hospitals) {
    final hospital = hospitals[index];
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: _buildHospitalImage(index, hospitals),
          ),
          Text(
            'Hospital Name: ${hospital.name}',
            style: const TextStyle(color: appbartextColor),
          ),
          Text(
            'Hospital Location: ${hospital.address}',
            style: const TextStyle(color: appbartextColor),
          ),
        ],
      ),
    );
  }

  Widget _buildHospitalImage(int index, List<Hospital> hospitals) {
    final hospital = hospitals[index];
    return hospital.image.isNotEmpty
        ? Image.network(
            "http://acs314flutter.xyz/Patient-tracker/images/${hospital.image}",
            fit: BoxFit.cover,
          )
        : const Placeholder(
            fallbackHeight: 50,
            fallbackWidth: 50,
          );
  }
}
