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
        var hospitalList =
            hospitals.map<Hospital>((hospitals) => Hospital.fromJson(hospitals)).toList();
        hospitalController.updateHospital(hospitalList);
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
        title: const Text('Hospitals'),
        backgroundColor: appbartextColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          :  _buildHospitalsListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchHospitals,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
        backgroundColor: appbartextColor,
      ),
    );
  }

  Widget _buildHospitalsListView() {
    return Obx(() {
      if (hospitalController.hospitals.isEmpty) {
        return const Center(
          child: Text(
            'No hospitals found in the database. Please try again later.',
            style: TextStyle(color: appbartextColor),
          ),
        );
      } else {
        return ListView.builder(
          itemCount: hospitalController.hospitals.length,
          itemBuilder: (context, index) {
            return _buildHospitalListTile(index);
          },
        );
      }
    });
  }

  Widget _buildHospitalListTile(int index) {
    final hospital = hospitalController.hospitals[index];
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: ListTile(
        minVerticalPadding: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusColor: secondaryColor,
        leading: SizedBox(
          width: 60,
          height: 150,
          child: _buildMedicationImage(index),
        ),
        title: Text(
          'Institution Name: ${hospital.name}',
          style: const TextStyle(color: appbartextColor),
        ),
        subtitle: Text(
          'Proximate Location: ${hospital.address}',
          style: const TextStyle(color: appbartextColor),
        ),
      ),
    );
  }

  Widget _buildMedicationImage(int index) {
   final hospital = hospitalController.hospitals[index];
    return hospital.image.isNotEmpty
        ? Image.network(
            hospital.image,
            fit: BoxFit.cover,
          )
        : const Placeholder(
            fallbackHeight: 50,
            fallbackWidth: 50,
          );
  }
}
