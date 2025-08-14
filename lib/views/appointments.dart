import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:patient_tracker/core/data/mock_data.dart';
import 'package:patient_tracker/core/theme/app_theme.dart';
import 'package:patient_tracker/widgets/common/theme_switch.dart';

class AppointmentsController extends GetxController {
  final searchText = ''.obs;
  final selectedFilter = 'All'.obs;

  final List<Map<String, dynamic>> appointments = MockHospitalVisits.visits;

  List<String> get filterOptions =>
      ['All', 'Confirmed', 'Pending', 'Completed', 'Cancelled'];

  List<Map<String, dynamic>> get filteredAppointments {
    var filtered = appointments.where((appointment) {
      final matchesSearch = searchText.value.isEmpty ||
          appointment['doctor']
              .toString()
              .toLowerCase()
              .contains(searchText.value.toLowerCase()) ||
          appointment['specialty']
              .toString()
              .toLowerCase()
              .contains(searchText.value.toLowerCase()) ||
          appointment['hospital']
              .toString()
              .toLowerCase()
              .contains(searchText.value.toLowerCase());

      final matchesFilter = selectedFilter.value == 'All' ||
          appointment['status'] == selectedFilter.value;

      return matchesSearch && matchesFilter;
    }).toList();

    // Sort by date (upcoming first)
    filtered.sort((a, b) =>
        DateTime.parse(a['date']).compareTo(DateTime.parse(b['date'])));
    return filtered;
  }

  void search(String text) {
    searchText.value = text;
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }
}

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Appointments'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: ThemeSwitchIcon(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  onChanged: controller.search,
                  decoration: InputDecoration(
                    hintText: 'Search appointments...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
                const SizedBox(height: 16),

                // Filter Chips
                Obx(() => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: controller.filterOptions.map((filter) {
                          final isSelected =
                              controller.selectedFilter.value == filter;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: FilterChip(
                              label: Text(filter),
                              selected: isSelected,
                              onSelected: (_) => controller.setFilter(filter),
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              selectedColor:
                                  Theme.of(context).colorScheme.primary,
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSurface,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )),
              ],
            ),
          ),

          // Appointments List
          Expanded(
            child: Obx(() {
              final appointments = controller.filteredAppointments;

              if (appointments.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No appointments found',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.grey.shade500,
                            ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  return _buildAppointmentCard(context, appointment);
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.snackbar(
            'Book Appointment',
            'Booking new appointments will be available soon.',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAppointmentCard(
      BuildContext context, Map<String, dynamic> appointment) {
    final date = DateTime.parse(appointment['date']);
    final isUpcoming = date.isAfter(DateTime.now());

    Color statusColor;
    String status = appointment['status'] ?? 'Pending';
    switch (status) {
      case 'Confirmed':
        statusColor = AppTheme.success;
        break;
      case 'Pending':
        statusColor = Colors.orange;
        break;
      case 'Completed':
        statusColor = Colors.blue;
        break;
      case 'Cancelled':
        statusColor = AppTheme.error;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          _showAppointmentDetails(context, appointment);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      appointment['doctor'],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Specialty and Hospital
              Text(
                '${appointment['reason']} • ${appointment['hospital']}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 12),

              // Date and Time
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat.yMMMd().add_jm().format(date),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Type and Notes
              Row(
                children: [
                  Icon(
                    Icons.medical_services,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      appointment['notes'],
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              if (isUpcoming) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.snackbar(
                          'Reschedule',
                          'Rescheduling feature coming soon',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      child: const Text('Reschedule'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        Get.snackbar(
                          'Cancel',
                          'Cancellation feature coming soon',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showAppointmentDetails(
      BuildContext context, Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Appointment Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Doctor', appointment['doctor']),
            _buildDetailRow('Reason', appointment['reason']),
            _buildDetailRow('Hospital', appointment['hospital']),
            _buildDetailRow('Date',
                DateFormat.yMMMd().format(DateTime.parse(appointment['date']))),
            _buildDetailRow('Time',
                DateFormat.jm().format(DateTime.parse(appointment['date']))),
            _buildDetailRow('Status', appointment['status'] ?? 'Pending'),
            _buildDetailRow('Notes', appointment['notes']),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
