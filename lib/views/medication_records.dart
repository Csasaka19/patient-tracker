import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_tracker/core/theme/app_theme.dart';
import 'package:patient_tracker/widgets/common/theme_switch.dart';
import 'package:patient_tracker/core/data/mock_data.dart';

class MedicationRecordsPage extends StatefulWidget {
  const MedicationRecordsPage({super.key});

  @override
  _MedicationRecordsPageState createState() => _MedicationRecordsPageState();
}

class _MedicationRecordsPageState extends State<MedicationRecordsPage> {
  bool _isLoading = false;
  String _searchText = "";
  List<Map<String, dynamic>> _medicationRecords = [];

  @override
  void initState() {
    super.initState();
    _fetchMedicationRecords();
  }

  Future<void> _fetchMedicationRecords() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // For demo purposes, simulate a network delay
      await Future.delayed(const Duration(seconds: 1));

      // Create medication records from mock data
      final mockMedications = MockMedications.medications;
      final records = mockMedications
          .map((med) {
            // Generate multiple records for each medication
            return [
              {
                'id': '${med['id']}_1',
                'medication_name': med['name'],
                'dosage': med['dosage'],
                'date_taken': '2023-07-${(med['id'] as int) * 2}',
                'time_taken': '08:00 AM',
                'notes': 'Taken with breakfast',
              },
              {
                'id': '${med['id']}_2',
                'medication_name': med['name'],
                'dosage': med['dosage'],
                'date_taken': '2023-07-${(med['id'] as int) * 2 + 1}',
                'time_taken': '08:00 PM',
                'notes': 'Taken with dinner',
              }
            ];
          })
          .expand((records) => records)
          .toList();

      setState(() {
        _medicationRecords = records;
      });
    } catch (e) {
      print('Error fetching medication records: $e');
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
      'Failed to fetch medication records. Please try again later.',
      backgroundColor: AppTheme.error,
      colorText: AppTheme.white,
    );
  }

  List<Map<String, dynamic>> get filteredRecords {
    if (_searchText.isEmpty) {
      return _medicationRecords;
    }

    return _medicationRecords.where((record) {
      final medicationName = record['medication_name'].toString().toLowerCase();
      final notes = record['notes'].toString().toLowerCase();
      final query = _searchText.toLowerCase();

      return medicationName.contains(query) || notes.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medication Records'),
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
                      hintText: "Search your medication records...",
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
                Expanded(child: _buildMedicationRecordsListView()),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new medication record
          Get.snackbar(
            'Feature Coming Soon',
            'Adding new medication records will be available in a future update.',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        tooltip: 'Add New',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMedicationRecordsListView() {
    if (_medicationRecords.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.medication_liquid_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No medication records available',
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

    final displayedRecords = filteredRecords;

    if (displayedRecords.isEmpty) {
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
              'No matching medication records found',
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

    // Group records by date
    final Map<String, List<Map<String, dynamic>>> groupedRecords = {};
    for (var record in displayedRecords) {
      final date = record['date_taken'] as String;
      if (!groupedRecords.containsKey(date)) {
        groupedRecords[date] = [];
      }
      groupedRecords[date]!.add(record);
    }

    // Sort dates in descending order (most recent first)
    final sortedDates = groupedRecords.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: sortedDates.length,
      itemBuilder: (context, index) {
        final date = sortedDates[index];
        final records = groupedRecords[date]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _formatDate(date),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            ...records
                .map((record) => _buildMedicationRecordCard(record))
                .toList(),
          ],
        );
      },
    );
  }

  String _formatDate(String dateString) {
    // Convert YYYY-MM-DD to a nicely formatted date
    try {
      final date = DateTime.parse(dateString);
      return '${_getMonthName(date.month)} ${date.day}, ${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  Widget _buildMedicationRecordCard(Map<String, dynamic> record) {
    // Get matching medication data
    final mockMedications = MockMedications.medications;
    final matchingMed = mockMedications.firstWhere(
      (med) => med['name'] == record['medication_name'],
      orElse: () => {
        'name': record['medication_name'],
        'dosage': 'Unknown',
        'frequency': 'Unknown'
      },
    );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // View record details
          Get.snackbar(
            'Medication Record Details',
            'Detailed view coming soon',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.medication_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record['medication_name'] as String,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      '${record['dosage']} • ${record['time_taken']}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (record['notes'] != null &&
                        record['notes'].toString().isNotEmpty)
                      Text(
                        record['notes'] as String,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.7),
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              Chip(
                label: Text(
                  'Taken',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                backgroundColor: AppTheme.success,
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
