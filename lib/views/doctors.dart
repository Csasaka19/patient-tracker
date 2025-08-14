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

              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600 ? 3 : 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: controller.filteredDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = controller.filteredDoctors[index];
                  return DoctorTile(doctor: doctor);
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

class DoctorTile extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorTile({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 3,
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Doctor image
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  image: DecorationImage(
                    image: AssetImage(doctor['image'] as String),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Doctor name
              Text(
                doctor['name'] as String,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),

              // Specialty
              Text(
                doctor['specialty'] as String,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDarkMode
                          ? AppTheme.accentGreen
                          : AppTheme.secondaryGreen,
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),

              // Hospital
              Text(
                doctor['hospital'] as String,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),

              // Rating and action button row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Rating
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.amber.shade700,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        doctor['rating'].toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),

                  // Call button
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? AppTheme.accentGreen.withOpacity(0.2)
                          : AppTheme.secondaryGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.snackbar(
                          'Contact',
                          'Calling functionality coming soon',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      child: Icon(
                        Icons.call,
                        size: 18,
                        color: isDarkMode
                            ? AppTheme.accentGreen
                            : AppTheme.secondaryGreen,
                      ),
                    ),
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
