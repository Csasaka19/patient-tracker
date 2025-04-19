import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_tracker/core/theme/app_theme.dart';
import 'package:patient_tracker/widgets/common/theme_switch.dart';
import 'package:patient_tracker/controllers/doctor_records_controller.dart';
import 'package:patient_tracker/models/doctor_records-model.dart';
import 'package:patient_tracker/core/data/mock_data.dart';

DoctorRecordsController doctorRecordsController =
    Get.put(DoctorRecordsController());

class DoctorRecordsPage extends StatefulWidget {
  const DoctorRecordsPage({super.key});

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
      // For demo purposes, let's use mock data instead of the actual API call
      // This simulates a network delay
      await Future.delayed(const Duration(seconds: 1));

      // Create doctor records from mock doctors data
      final mockDoctors = MockDoctors.doctors;
      final doctorRecordsList = mockDoctors
          .map<DoctorRecords>((doctor) => DoctorRecords(
                id: doctor['id'].toString(),
                user_id: "1",
                record_date: "2023-06-${doctor['id']}",
                description:
                    "Consultation with ${doctor['name']} for ${doctor['specialty']} examination.",
              ))
          .toList();
      doctorRecordsController.updateDoctorRecords(doctorRecordsList);

      /* Commented out the actual API call
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
      */
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
      backgroundColor: AppTheme.error,
      colorText: AppTheme.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Doctor Records'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: ThemeSwitchIcon(),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search for your doctor records...",
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: const Icon(Icons.filter_list),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                    ),
                  ),
                ),
                Expanded(child: _buildDoctorRecordsListView()),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new doctor record
          Get.snackbar(
            'Feature Coming Soon',
            'Adding new doctor records will be available in a future update.',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        tooltip: 'Add New',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDoctorRecordsListView() {
    return Obx(() {
      if (doctorRecordsController.doctor_records.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.medical_services_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No doctor records available',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7),
                    ),
              ),
            ],
          ),
        );
      } else {
        var displayedDoctorRecords = doctorRecordsController.doctor_records
            .where((record) => record.description
                .toLowerCase()
                .contains(_searchText.toLowerCase()))
            .toList();

        if (displayedDoctorRecords.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'No matching doctor records found',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.7),
                      ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
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

    // Get matching doctor from mock data for additional information
    final mockDoctors = MockDoctors.doctors;
    final matchingDoctor = mockDoctors.firstWhere(
      (doctor) => doctor['id'].toString() == doctorRecord.id,
      orElse: () => {
        'name': 'Unknown Doctor',
        'specialty': 'General Medicine',
        'hospital': 'Unknown Hospital',
        'image': 'assets/doctors/doctor_1.png',
      },
    );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // View doctor record details
          Get.snackbar(
            'Doctor Record Details',
            'Detailed view coming soon',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  matchingDoctor['image'] as String,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),

              // Doctor record info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      matchingDoctor['name'] as String,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      matchingDoctor['specialty'] as String,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      matchingDoctor['hospital'] as String,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      doctorRecord.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),

              // Date chip
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Chip(
                    label: Text(
                      doctorRecord.record_date,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 8),
                  IconButton(
                    icon: const Icon(Icons.event_note_rounded, size: 20),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      Get.snackbar(
                        'View Notes',
                        'Detailed notes will be available in a future update.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
