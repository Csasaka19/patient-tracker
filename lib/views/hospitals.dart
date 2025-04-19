import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_tracker/core/theme/app_theme.dart';
import 'package:patient_tracker/widgets/common/theme_switch.dart';
import 'package:patient_tracker/controllers/hospital_controller.dart';
import 'package:patient_tracker/models/hospital-model.dart';
import 'package:patient_tracker/core/data/mock_data.dart';

HospitalController hospitalController = Get.put(HospitalController());

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

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
      // For demo purposes, let's use mock data instead of the actual API call
      // This simulates a network delay
      await Future.delayed(const Duration(seconds: 1));

      // Load mock data
      final mockHospitals = MockHospitals.hospitals;
      final hospitalsList = mockHospitals
          .map<Hospital>((hosp) => Hospital(
                name: hosp['name'].toString(),
                address: hosp['address'].toString(),
                image: '',
              ))
          .toList();
      hospitalController.updateHospital(hospitalsList);

      /* Commented out the actual API call
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
      */
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
      backgroundColor: AppTheme.error,
      colorText: AppTheme.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospitals'),
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
                      hintText: "Search for hospitals near you...",
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
                Expanded(child: _buildHospitalsListView()),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open map view
          Get.snackbar(
            'Feature Coming Soon',
            'Hospital map view will be available in a future update.',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        tooltip: 'Map View',
        child: const Icon(Icons.map),
      ),
    );
  }

  Widget _buildHospitalsListView() {
    return Obx(() {
      if (hospitalController.hospitals.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.local_hospital_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No hospitals available',
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
        var displayedHospitals = hospitalController.hospitals
            .where((hospital) =>
                hospital.name.toLowerCase().contains(_searchText.toLowerCase()))
            .toList();

        if (displayedHospitals.isEmpty) {
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
                  'No matching hospitals found',
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
          itemCount: displayedHospitals.length,
          itemBuilder: (context, index) {
            return _buildHospitalCard(
                index, displayedHospitals as List<Hospital>);
          },
        );
      }
    });
  }

  Widget _buildHospitalCard(int index, List<Hospital> hospitals) {
    final hospital = hospitals[index];

    // Get additional mock data for a richer UI
    final mockHospitals = MockHospitals.hospitals;
    final matchingMockHospital = mockHospitals.firstWhere(
      (hosp) => hosp['name'].toString() == hospital.name,
      orElse: () => {
        'phone': 'Unknown',
        'email': 'Unknown',
        'rating': 0.0,
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
          // View hospital details
          Get.snackbar(
            'Hospital Details',
            'Detailed view coming soon',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            // Hospital image
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/images/hospital.jpg'),
                  fit: BoxFit.cover,
                ),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              ),
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Chip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        matchingMockHospital['rating'].toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  backgroundColor: Theme.of(context).cardColor.withOpacity(0.9),
                ),
              ),
            ),

            // Hospital info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          hospital.name,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.directions),
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          Get.snackbar(
                            'Get Directions',
                            'Navigation will be available in a future update.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          hospital.address,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        matchingMockHospital['phone'].toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
