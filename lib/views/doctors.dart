import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_tracker/core/data/mock_data.dart';
import 'package:patient_tracker/core/theme/app_theme.dart';
import 'package:patient_tracker/widgets/common/theme_switch.dart';

class DoctorController extends GetxController {
  final doctors = MockDoctors.doctors.obs;
  final isLoading = false.obs;
  final searchText = ''.obs;

  List<Map<String, dynamic>> get filteredDoctors {
    if (searchText.value.isEmpty) {
      return doctors;
    }

    return doctors.where((doctor) {
      final name = doctor['name'].toString().toLowerCase();
      final specialty = doctor['specialty'].toString().toLowerCase();
      final hospital = doctor['hospital'].toString().toLowerCase();
      final query = searchText.value.toLowerCase();

      return name.contains(query) ||
          specialty.contains(query) ||
          hospital.contains(query);
    }).toList();
  }

  void search(String text) {
    searchText.value = text;
  }
}

class DoctorPage extends StatelessWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: ThemeSwitchIcon(),
          ),
        ],
      ),
      body: Column(
              children: [
          // Search Bar
                Padding(
            padding: const EdgeInsets.all(16.0),
                  child: TextField(
              onChanged: controller.search,
                    decoration: InputDecoration(
                hintText: 'Search doctors...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          // Doctors List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.filteredDoctors.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No doctors found',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.grey.shade500,
                            ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: controller.filteredDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = controller.filteredDoctors[index];
                  return DoctorCard(doctor: doctor);
                },
              );
            }),
          ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Feature to add new doctor would go here
          Get.snackbar(
            'Feature Coming Soon',
            'Adding new doctors will be available in a future update.',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorCard({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // View doctor details
          Get.snackbar(
            'Doctor Details',
            'Detailed view coming soon',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Doctor image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(doctor['image'] as String),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Doctor info
              Expanded(
      child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                    Text(
                      doctor['name'] as String,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor['specialty'] as String,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
          Text(
                      doctor['hospital'] as String,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),

                    // Rating
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.amber.shade700,
                        ),
                        const SizedBox(width: 4),
          Text(
                          doctor['rating'].toString(),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // View button
              IconButton(
                onPressed: () {
                  // Call doctor
                  Get.snackbar(
                    'Contact',
                    'Calling functionality coming soon',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                icon: Icon(
                  Icons.call,
                  color: isDarkMode
                      ? AppTheme.accentGreen
                      : AppTheme.secondaryGreen,
                ),
              ),
            ],
          ),
        ),
      ),
          );
  }
}
