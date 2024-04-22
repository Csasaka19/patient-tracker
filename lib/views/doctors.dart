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
        var doctorList = doctors
            .map<Doctor>((doctors) => Doctor.fromJson(doctors))
            .toList();
        doctorController.updateMedications(doctorList);
      } else {
        throw Exception('Failed to load medications from API');
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
        title: const Text('Doctors'),
        backgroundColor: appbartextColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildDoctorsListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchDoctors,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
        backgroundColor: appbartextColor,
      ),
    );
  }

  Widget _buildDoctorsListView() {
    return Obx(() {
      if (doctorController.doctors.isEmpty) {
        return const Center(
          child: Text(
            'No doctors available in your area',
            style: TextStyle(color: appbartextColor),
          ),
        );
      } else {
        return ListView.builder(
          itemCount: doctorController.doctors.length,
          itemBuilder: (context, index) {
            return _buildDoctorListTile(index);
          },
        );
      }
    });
  }

  Widget _buildDoctorListTile(int index) {
    final doctor = doctorController.doctors[index];
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
          'Medic Name: ${doctor.name}',
          style: const TextStyle(color: appbartextColor),
        ),
        subtitle: Text(
          'Specialty: ${doctor.specialization}',
          style: const TextStyle(color: appbartextColor),
        ),
      ),
    );
  }

  Widget _buildMedicationImage(int index) {
    final doctor = doctorController.doctors[index];
    return doctor.image.isNotEmpty
        ? Image.network(
            doctor.image,
            fit: BoxFit.cover,
          )
        : const Placeholder(
            fallbackHeight: 50,
            fallbackWidth: 50,
          );
  }
}
