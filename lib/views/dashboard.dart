import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:patient_tracker/core/theme/app_theme.dart';
import 'package:patient_tracker/widgets/common/app_logo.dart';
import 'package:patient_tracker/widgets/common/theme_switch.dart';
import 'package:patient_tracker/core/data/mock_data.dart';

class DashboardItem {
  final String title;
  final IconData icon;
  final String route;
  final Color color;

  DashboardItem({
    required this.title,
    required this.icon,
    required this.route,
    required this.color,
  });
}

class DashboardController extends GetxController {
  final List<DashboardItem> dashboardItems = [
    DashboardItem(
      title: 'Medical Records',
      icon: Icons.assignment_outlined,
      route: '/medical_records',
      color: AppTheme.primaryBlue,
    ),
    DashboardItem(
      title: 'Medications',
      icon: Icons.medication_outlined,
      route: '/medication',
      color: AppTheme.secondaryGreen,
    ),
    DashboardItem(
      title: 'Doctors',
      icon: Icons.people_outline,
      route: '/doctors',
      color: Colors.purple,
    ),
    DashboardItem(
      title: 'Hospitals',
      icon: Icons.local_hospital_outlined,
      route: '/hospitals',
      color: Colors.orange,
    ),
    DashboardItem(
      title: 'Hospital Visits',
      icon: Icons.calendar_today_outlined,
      route: '/hospital_visits',
      color: Colors.teal,
    ),
    DashboardItem(
      title: 'Recommendations',
      icon: Icons.recommend_outlined,
      route: '/recommendations',
      color: Colors.red,
    ),
  ];

  final searchText = ''.obs;

  List<DashboardItem> get filteredItems {
    if (searchText.value.isEmpty) {
      return dashboardItems;
    }
    return dashboardItems
        .where((item) =>
            item.title.toLowerCase().contains(searchText.value.toLowerCase()))
        .toList();
  }

  void search(String text) {
    searchText.value = text;
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final userData = MockUser.userData;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with logo
          SliverAppBar(
            expandedHeight: 180.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isDarkMode
                        ? [AppTheme.darkBlue, const Color(0xFF1E1E1E)]
                        : [AppTheme.primaryBlue, AppTheme.accentBlue],
                  ),
                ),
                child: const Center(
                  child: AppLogo(
                    size: 80,
                    darkMode: true,
                  ),
                ),
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: ThemeSwitchIcon(),
              ),
            ],
          ),

          // Greeting and search
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome, ${userData['firstName']}',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Your health companion',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed('/profile'),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Text(
                            '${userData['firstName'][0]}${userData['lastName'][0]}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Search bar
                  TextField(
                    onChanged: controller.search,
                    decoration: InputDecoration(
                      hintText: 'Search health records...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Health stats
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Health Overview',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildHealthStats(context),
                ],
              ),
            ),
          ),

          // Upcoming visits
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upcoming Appointments',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildUpcomingVisits(context),
                ],
              ),
            ),
          ),

          // Main dashboard heading
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Quick Access',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),

          // Dashboard grid
          Obx(() => SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = controller.filteredItems[index];
                      return _buildDashboardItem(context, item, isDarkMode);
                    },
                    childCount: controller.filteredItems.length,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildDashboardItem(
      BuildContext context, DashboardItem item, bool isDarkMode) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => Get.toNamed(item.route),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? item.color.withOpacity(0.2)
                      : item.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  size: 36,
                  color: item.color,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHealthStats(BuildContext context) {
    final userData = MockUser.userData;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.favorite_outline,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: const Text('Blood Type'),
            subtitle: Text(userData['bloodType'] as String),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Get.toNamed('/health_overview'),
          ),
          const Divider(height: 1),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.warning_amber_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: const Text('Allergies'),
            subtitle: Text((userData['allergies'] as List).join(', ')),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Get.toNamed('/health_overview'),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingVisits(BuildContext context) {
    // Get a couple of future visits from mock data
    final allVisits = MockHospitalVisits.visits;
    allVisits.sort((a, b) =>
        DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));
    final upcomingVisits = allVisits
        .where((visit) => DateTime.parse(visit['date']).isAfter(DateTime.now()))
        .take(2)
        .toList();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          if (upcomingVisits.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No upcoming appointments'),
            )
          else
            ...upcomingVisits.map((visit) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        child: Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(visit['doctor']!),
                      subtitle: Text(
                          '${visit['reason']} • ${DateFormat.yMMMd().format(DateTime.parse(visit['date']))}'),
                      trailing: ElevatedButton(
                        onPressed: () => Get.toNamed('/appointments'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          minimumSize: const Size(80, 36),
                        ),
                        child: const Text('View'),
                      ),
                    ),
                    if (visit != upcomingVisits.last) const Divider(height: 1),
                  ],
                )),
          InkWell(
            onTap: () => Get.toNamed('/appointments'),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Text(
                'View All Appointments',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
