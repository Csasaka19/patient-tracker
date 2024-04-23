import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/customs/customtext.dart';
import 'package:patient_tracker/customs/dashboard-item.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String filter = '';
  List<DashboardItem> dashboardItems = [
    DashboardItem(
      title: 'Medications',
      icon: Icons.medical_services,
      imagepath: 'assets/images/medications.jpg',
      onTap: () {
        // Navigate to Medications page
      },
    ),
    DashboardItem(
      title: 'Doctors',
      icon: Icons.people_outline_sharp,
      imagepath: 'assets/doctors/doctor_1.png',
      onTap: () {
        // Navigate to Doctors page
      },
    ),
    DashboardItem(
      title: 'Hospitals',
      icon: Icons.local_hospital,
      imagepath: 'assets/images/hospital.jpg',
      onTap: () {
        // Navigate to Hospitals page
      },
    ),
    DashboardItem(
      title: 'Medical Records',
      icon: Icons.assignment_add,
      imagepath: 'assets/images/records.jpg',
      onTap: () {
        // Navigate to Medical Records page
      },
    ),
    DashboardItem(
      title: 'Hospital Visits',
      icon: Icons.calendar_today_outlined,
      imagepath: 'assets/doctors/doctor_3.png',
      onTap: () {
        // Navigate to Hospital Visits page
      },
    ),
    DashboardItem(
      title: 'Your Recommendations',
      icon: Icons.calendar_today,
      imagepath: 'assets/doctors/doctor_2.png',
      onTap: () {
        // Navigate to Your Recommendations page
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
            label: 'Patient Tracker Dashboard',
            fontSize: 24,
            labelColor: appbartextColor),
        backgroundColor: blackColor,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/doctors/doctor_5.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.7),
                    Colors.black.withOpacity(.2),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const CustomText(
                      label: 'Welcome Back! ',
                      fontSize: 24,
                      labelColor: appbartextColor),
                  const SizedBox(height: 20),
                  const CustomText(
                      label: 'What would you like to do today? We hope you are feeling better!',
                      fontSize: 20,
                      labelColor: appbartextColor,
                      italic: true,),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        filter = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: 'Search for your records......',
                      prefixIcon:
                          const Icon(Icons.search, color: appbartextColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: appbartextColor.withOpacity(0.3),
                        suffixIcon: Icon(Icons.filter_list),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CustomText(label: "Every record you need is here, discard the tedious documented papers! For your health right?", fontSize: 16, labelColor: appbartextColor, italic: true,),
                  const SizedBox(height: 30),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: dashboardItems
                          .where((item) => item.title.contains(filter))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () {
                  // Show help message
                },
                tooltip: 'Need help?',
                child: const Icon(Icons.help_outline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
