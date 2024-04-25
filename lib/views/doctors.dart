import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/controllers/doctors_controller.dart';
import 'package:patient_tracker/models/doctor_model.dart';

DoctorController doctorController = Get.put(DoctorController());

class DoctorPage extends StatefulWidget {
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  bool _isLoading = false;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          "http://acs314flutter.xyz/Patient-tracker/get_doctors.php"));

      if (response.statusCode == 200) {
        var serverResponse = json.decode(response.body);
        var doctors = serverResponse['doctors'];
        var doctorsList =
            doctors.map<Doctor>((doctor) => Doctor.fromJson(doctor)).toList();
        doctorController.updateDoctor(doctorsList);
      } else {
        throw Exception('Failed to load doctors from API');
      }
    } catch (e) {
      print('Error fetching doctors: $e');
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
      'Failed to fetch doctors. Please try again later.',
      backgroundColor: pinkColor,
      colorText: appbartextColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: const Text('Doctors', style: TextStyle(color: appbartextColor)),
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
                      hintText: "Search for doctors",
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
                Expanded(child: _buildDoctorsGridView()),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchDoctors,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
        backgroundColor: appbartextColor,
      ),
    );
  }

  Widget _buildDoctorsGridView() {
    return Obx(() {
      if (doctorController.doctors.isEmpty) {
        return const Center(
          child: Text(
            'No doctors available',
            style: TextStyle(color: appbartextColor),
          ),
        );
      } else {
        var displayedDoctors = doctorController.doctors
            .where((doctor) => doctor.name.contains(_searchText))
            .toList();

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: displayedDoctors.length,
          itemBuilder: (context, index) {
            return _buildDoctorContainer(
                index, displayedDoctors as List<Doctor>);
          },
        );
      }
    });
  }

  Widget _buildDoctorContainer(int index, List<Doctor> doctors) {
    final doctor = doctors[index];
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: _buildDoctorImage(index, doctors),
          ),
          Text(
            'Medic Name: ${doctor.name}',
            style: const TextStyle(color: appbartextColor),
          ),
          Text(
            'Area of specialization: ${doctor.specialization}',
            style: const TextStyle(color: appbartextColor),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorImage(int index, List<Doctor> doctors) {
    final doctor = doctors[index];
    return doctor.image.isNotEmpty
        ? Image.network(
            "http://acs314flutter.xyz/Patient-tracker/images/${doctor.image}",
            fit: BoxFit.cover,
          )
        : const Placeholder(
            fallbackHeight: 50,
            fallbackWidth: 50,
          );
  }
}
