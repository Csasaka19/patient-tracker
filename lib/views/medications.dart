import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_tracker/core/theme/app_theme.dart';
import 'package:patient_tracker/widgets/common/theme_switch.dart';
import 'package:patient_tracker/controllers/medications_controller.dart';
import 'package:patient_tracker/models/medications_model.dart';
import 'package:patient_tracker/core/data/mock_data.dart';

MedicationController medicationController = Get.put(MedicationController());

class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});

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
      // For demo purposes, let's use mock data instead of the actual API call
      // This simulates a network delay
      await Future.delayed(const Duration(seconds: 1));

      // Load mock data
      final mockMeds = MockMedications.medications;
      final medicationsList = mockMeds
          .map<Medication>((med) => Medication(
                name: med['name'].toString(),
                description: med['instructions'].toString(),
                image: '',
              ))
          .toList();
      medicationController.updateMedications(medicationsList);

      /* Commented out the actual API call
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
      */
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
      backgroundColor: AppTheme.error,
      colorText: AppTheme.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medications'),
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
                    scrollPhysics: const BouncingScrollPhysics(),
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search for medications",
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
                Expanded(child: _buildMedicationsListView()),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Feature to add new medication
          Get.snackbar(
            'Feature Coming Soon',
            'Adding new medications will be available in a future update.',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        tooltip: 'Add New',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMedicationsListView() {
    return Obx(() {
      if (medicationController.medications.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.medication_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No medications available',
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
        var displayedMedications = medicationController.medications
            .where((medication) => medication.name
                .toLowerCase()
                .contains(_searchText.toLowerCase()))
            .toList();

        if (displayedMedications.isEmpty) {
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
                  'No matching medications found',
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
          padding: const EdgeInsets.all(12),
          itemCount: displayedMedications.length,
          itemBuilder: (context, index) {
            return _buildMedicationCard(
                index, displayedMedications as List<Medication>);
          },
        );
      }
    });
  }

  Widget _buildMedicationCard(int index, List<Medication> medications) {
    final medication = medications[index];

    // Get additional mock data for a richer UI
    final mockMeds = MockMedications.medications;
    final matchingMockMed = mockMeds.firstWhere(
      (med) => med['name'].toString() == medication.name,
      orElse: () => {
        'dosage': 'Unknown',
        'frequency': 'Unknown',
        'start_date': 'Unknown',
        'end_date': 'Unknown',
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
          // View medication details
          Get.snackbar(
            'Medication Details',
            'Detailed view coming soon',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Medication icon/image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.medication_rounded,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),

              // Medication info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medication.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${matchingMockMed['dosage']} • ${matchingMockMed['frequency']}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      medication.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.7),
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Dates and status
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Chip(
                    label: Text(
                      'Active',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    backgroundColor: AppTheme.success,
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Until ${matchingMockMed['end_date']}',
                    style: Theme.of(context).textTheme.bodySmall,
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
