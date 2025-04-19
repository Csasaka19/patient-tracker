import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_tracker/core/theme/app_theme.dart';
import 'package:patient_tracker/widgets/common/theme_switch.dart';
import 'package:patient_tracker/controllers/recommendations_controller.dart';
import 'package:patient_tracker/models/recommendations-model.dart';
import 'package:patient_tracker/core/data/mock_data.dart';

RecommendationController recommendationController =
    Get.put(RecommendationController());

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  bool _isLoading = false;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _fetchRecommendations();
  }

  Future<void> _fetchRecommendations() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // For demo purposes, let's use mock data instead of the actual API call
      // This simulates a network delay
      await Future.delayed(const Duration(seconds: 1));

      // Create recommendations from mock data
      final mockDoctors = MockDoctors.doctors;
      final mockMeds = MockMedications.medications;

      // Generate doctor recommendations
      final doctorRecommendations = mockDoctors
          .map((doctor) => Recommendation(
                id: 'D${doctor['id']}',
                user_id: '1',
                recommendation_date: '2023-06-${doctor['id']}',
                description:
                    'Schedule a follow-up appointment with ${doctor['name']} for your ${doctor['specialty'].toString().toLowerCase()} check-up.',
                type: 'doctor',
              ))
          .toList();

      // Generate medication recommendations
      final medicationRecommendations = mockMeds
          .map((med) => Recommendation(
                id: 'M${med['id']}',
                user_id: '1',
                recommendation_date: '2023-06-${med['id']}',
                description:
                    'Remember to take your ${med['name']} ${med['dosage']} ${med['frequency'].toString().toLowerCase()}.',
                type: 'medication',
              ))
          .toList();

      // Add general health recommendations
      final generalRecommendations = [
        Recommendation(
          id: 'G1',
          user_id: '1',
          recommendation_date: '2023-06-20',
          description:
              'Drink at least 8 glasses of water daily for proper hydration.',
          type: 'general',
        ),
        Recommendation(
          id: 'G2',
          user_id: '1',
          recommendation_date: '2023-06-21',
          description:
              'Include 30 minutes of moderate exercise in your daily routine.',
          type: 'general',
        ),
        Recommendation(
          id: 'G3',
          user_id: '1',
          recommendation_date: '2023-06-22',
          description:
              'Ensure you get 7-8 hours of sleep each night for better health.',
          type: 'general',
        ),
      ];

      // Combine all recommendations
      final allRecommendations = [
        ...doctorRecommendations,
        ...medicationRecommendations,
        ...generalRecommendations,
      ];

      recommendationController.updateRecommendations(allRecommendations);

      /* Commented out the actual API call
      final response = await http.get(Uri.parse(
          "http://acs314flutter.xyz/Patient-tracker/get_recommendation.php?user_id=1"));

      if (response.statusCode == 200) {
        var serverResponse = json.decode(response.body);
        var recommendationsData = serverResponse['recommendations'];
        var recommendationList = recommendationsData
            .map<Recommendation>(
                (recommendation) => Recommendation.fromJson(recommendation))
            .toList();
        recommendationController.updateRecommendations(recommendationList);
      } else {
        throw Exception('Failed to load recommendations from API');
      }
      */
    } catch (e) {
      print('Error fetching recommendations: $e');
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
      'Failed to fetch recommendations. Please try again later.',
      backgroundColor: AppTheme.error,
      colorText: AppTheme.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Recommendations'),
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
                      hintText: "Search for health recommendations...",
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
                _buildRecommendationTypeFilter(),
                Expanded(child: _buildRecommendationListView()),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Feature for sharing recommendations
          Get.snackbar(
            'Feature Coming Soon',
            'Sharing health recommendations will be available in a future update.',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        tooltip: 'Share',
        child: const Icon(Icons.share),
      ),
    );
  }

  // Selected recommendation types for filtering
  final RxSet<String> _selectedTypes =
      <String>{'all', 'doctor', 'medication', 'general'}.obs;

  Widget _buildRecommendationTypeFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip('All', 'all'),
            const SizedBox(width: 8),
            _buildFilterChip('Doctor Visits', 'doctor'),
            const SizedBox(width: 8),
            _buildFilterChip('Medications', 'medication'),
            const SizedBox(width: 8),
            _buildFilterChip('General Health', 'general'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String type) {
    return Obx(() {
      final isSelected = _selectedTypes.contains(type);

      return FilterChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        checkmarkColor: Theme.of(context).colorScheme.primary,
        onSelected: (selected) {
          if (type == 'all') {
            if (selected) {
              _selectedTypes.addAll(['all', 'doctor', 'medication', 'general']);
            } else {
              _selectedTypes.clear();
            }
          } else {
            if (selected) {
              _selectedTypes.add(type);
              if (_selectedTypes
                  .containsAll(['doctor', 'medication', 'general'])) {
                _selectedTypes.add('all');
              }
            } else {
              _selectedTypes.remove(type);
              _selectedTypes.remove('all');
            }
          }
        },
      );
    });
  }

  Widget _buildRecommendationListView() {
    return Obx(() {
      if (recommendationController.recommendations.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.recommend_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No recommendations available',
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
        // Filter by type
        var filteredRecommendations = recommendationController.recommendations;
        List<Recommendation> filtered =
            filteredRecommendations.toList().cast<Recommendation>();

        if (!_selectedTypes.contains('all')) {
          filtered = filtered
              .where((rec) => _selectedTypes.contains(rec.type))
              .toList();
        }

        // Filter by search text
        if (_searchText.isNotEmpty) {
          filtered = filtered
              .where((rec) => rec.description
                  .toLowerCase()
                  .contains(_searchText.toLowerCase()))
              .toList();
        }

        if (filtered.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _searchText.isEmpty
                      ? Icons.filter_alt_off
                      : Icons.search_off_rounded,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  _searchText.isEmpty
                      ? 'No recommendations match the selected filters'
                      : 'No matching recommendations found',
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

        // Sort by date (most recent first)
        filtered.sort(
            (a, b) => b.recommendation_date.compareTo(a.recommendation_date));

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            return _buildRecommendationCard(index, filtered);
          },
        );
      }
    });
  }

  Widget _buildRecommendationCard(
      int index, List<Recommendation> recommendations) {
    final recommendation = recommendations[index];

    IconData getIconForType(String type) {
      switch (type) {
        case 'doctor':
          return Icons.medical_services_rounded;
        case 'medication':
          return Icons.medication_rounded;
        case 'general':
          return Icons.favorite_rounded;
        default:
          return Icons.info_outline_rounded;
      }
    }

    Color getColorForType(String type) {
      switch (type) {
        case 'doctor':
          return AppTheme.primaryBlue;
        case 'medication':
          return AppTheme.accentGreen;
        case 'general':
          return AppTheme.secondaryGreen;
        default:
          return Theme.of(context).colorScheme.primary;
      }
    }

    String getTypeLabel(String type) {
      switch (type) {
        case 'doctor':
          return 'Doctor Visit';
        case 'medication':
          return 'Medication';
        case 'general':
          return 'General Health';
        default:
          return 'Recommendation';
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // View recommendation details
          Get.snackbar(
            'Recommendation Details',
            'Detailed view coming soon',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          getColorForType(recommendation.type).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      getIconForType(recommendation.type),
                      color: getColorForType(recommendation.type),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTypeLabel(recommendation.type),
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        _formatDate(recommendation.recommendation_date),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.bookmark_border_rounded),
                    onPressed: () {
                      Get.snackbar(
                        'Bookmark Recommendation',
                        'This feature will be available soon',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                recommendation.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Get.snackbar(
                        'Set Reminder',
                        'Reminder feature will be available soon',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    icon:
                        const Icon(Icons.notifications_none_rounded, size: 16),
                    label: const Text('Remind me'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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

  String _formatDate(String dateString) {
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
}
