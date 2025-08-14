import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:patient_tracker/core/theme/app_theme.dart';
import 'package:patient_tracker/widgets/common/theme_switch.dart';
import 'package:patient_tracker/core/data/mock_data.dart';

class HealthOverviewController extends GetxController {
  final selectedPeriod = 'Month'.obs;
  final periods = ['Week', 'Month', '3 Months', '6 Months', 'Year'];

  void setPeriod(String period) {
    selectedPeriod.value = period;
  }
}

class HealthOverviewPage extends StatelessWidget {
  const HealthOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HealthOverviewController());
    final userData = MockUser.userData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Overview'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: ThemeSwitchIcon(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with user info
            _buildHeaderCard(context, userData),

            // Time period selector
            _buildPeriodSelector(context, controller),

            // Health metrics cards
            _buildHealthMetrics(context),

            // Recent activity
            _buildRecentActivity(context),

            // Health insights
            _buildHealthInsights(context),

            // Emergency contacts
            _buildEmergencyContacts(context, userData),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, Map<String, dynamic> userData) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: Icon(
                  Icons.person,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${userData['firstName']} ${userData['lastName']}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Blood Type: ${userData['bloodType']}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.success,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Healthy',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector(
      BuildContext context, HealthOverviewController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Health Data Period',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Obx(() => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.periods.map((period) {
                    final isSelected =
                        controller.selectedPeriod.value == period;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(period),
                        selected: isSelected,
                        onSelected: (_) => controller.setPeriod(period),
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildHealthMetrics(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Health Metrics',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
            children: [
              _buildMetricCard(
                context,
                icon: Icons.favorite,
                title: 'Heart Rate',
                value: '72',
                unit: 'bpm',
                trend: 'stable',
                color: Colors.red,
              ),
              _buildMetricCard(
                context,
                icon: Icons.speed,
                title: 'Blood Pressure',
                value: '120/80',
                unit: 'mmHg',
                trend: 'good',
                color: Colors.blue,
              ),
              _buildMetricCard(
                context,
                icon: Icons.monitor_weight,
                title: 'Weight',
                value: '70.5',
                unit: 'kg',
                trend: 'down',
                color: Colors.green,
              ),
              _buildMetricCard(
                context,
                icon: Icons.thermostat,
                title: 'Temperature',
                value: '36.8',
                unit: '°C',
                trend: 'stable',
                color: Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required String unit,
    required String trend,
    required Color color,
  }) {
    IconData trendIcon;
    Color trendColor;

    switch (trend) {
      case 'up':
        trendIcon = Icons.trending_up;
        trendColor = Colors.red;
        break;
      case 'down':
        trendIcon = Icons.trending_down;
        trendColor = Colors.green;
        break;
      case 'good':
        trendIcon = Icons.check_circle;
        trendColor = Colors.green;
        break;
      default:
        trendIcon = Icons.trending_flat;
        trendColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Icon(trendIcon, color: trendColor, size: 16),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    final recentActivities = [
      {
        'type': 'Appointment',
        'description': 'Check-up with Dr. Aisha Mwangi',
        'date': '2025-01-10',
        'icon': Icons.event,
        'color': Colors.blue,
      },
      {
        'type': 'Medication',
        'description': 'Took Losartan 50mg',
        'date': '2025-01-09',
        'icon': Icons.medication,
        'color': Colors.green,
      },
      {
        'type': 'Test',
        'description': 'Blood pressure reading: 118/75',
        'date': '2025-01-08',
        'icon': Icons.favorite,
        'color': Colors.red,
      },
      {
        'type': 'Exercise',
        'description': '30 minutes walking',
        'date': '2025-01-07',
        'icon': Icons.fitness_center,
        'color': Colors.orange,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton(
                onPressed: () {
                  Get.snackbar(
                    'Activity History',
                    'Full activity history coming soon',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: recentActivities.map((activity) {
                final isLast = activity == recentActivities.last;
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            (activity['color'] as Color).withOpacity(0.1),
                        child: Icon(
                          activity['icon'] as IconData,
                          color: activity['color'] as Color,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        activity['description'] as String,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      subtitle: Text(DateFormat.yMMMd()
                          .format(DateTime.parse(activity['date'] as String))),
                      trailing: Chip(
                        label: Text(
                          activity['type'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: activity['color'] as Color,
                          ),
                        ),
                        backgroundColor:
                            (activity['color'] as Color).withOpacity(0.1),
                      ),
                    ),
                    if (!isLast) const Divider(height: 1),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthInsights(BuildContext context) {
    final insights = [
      {
        'title': 'Blood Pressure Trend',
        'description':
            'Your blood pressure has been stable over the past month. Keep up the good work!',
        'icon': Icons.trending_flat,
        'color': Colors.green,
      },
      {
        'title': 'Medication Adherence',
        'description':
            'You\'ve taken 95% of your prescribed medications on time this week.',
        'icon': Icons.medication,
        'color': Colors.blue,
      },
      {
        'title': 'Upcoming Reminder',
        'description':
            'Don\'t forget your appointment with Dr. Otieno on Feb 15, 2025.',
        'icon': Icons.notification_important,
        'color': Colors.orange,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Health Insights',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Column(
            children: insights.map((insight) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: insight['color'] as Color,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      insight['icon'] as IconData,
                      color: insight['color'] as Color,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            insight['title'] as String,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            insight['description'] as String,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContacts(
      BuildContext context, Map<String, dynamic> userData) {
    final emergencyContact =
        userData['emergencyContact'] as Map<String, dynamic>;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Emergency Contact',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.error.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.error.withOpacity(0.1),
                  child: const Icon(
                    Icons.emergency,
                    color: AppTheme.error,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        emergencyContact['name'],
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        emergencyContact['relationship'],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        emergencyContact['phone'],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.snackbar(
                      'Emergency Call',
                      'Calling emergency contact feature coming soon',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  icon: const Icon(Icons.call, color: AppTheme.error),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
