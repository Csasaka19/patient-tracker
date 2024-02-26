import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/customs/box.dart';
import 'package:patient_tracker/customs/layout.dart';
import 'package:patient_tracker/customs/tile.dart';

List<String> texts = [
  "Check blood pressure and record readings for today.",
  "Administer medication dosage at 10 AM and 6 PM.",
  "Monitor glucose levels after meals and before bedtime.",
  "Schedule follow-up appointment with Dr. Smith for next week.",
  "Track daily water intake - aim for 8 glasses.",
  "Log symptoms experienced throughout the day.",
  "Complete physical therapy exercises for knee rehabilitation.",
  "Take a brisk walk for 30 minutes to maintain activity levels.",
  "Record weight and note any fluctuations.",
  "Monitor sleep patterns and quality - aim for 7-8 hours.",
  "Update food diary with meals and snacks consumed.",
  "Measure temperature twice daily and note any fever spikes.",
  "Check heart rate before and after exercise sessions.",
  "Practice relaxation techniques to manage stress levels.",
  "Review and update medical history for accuracy.",
  "Track medication side effects and report to healthcare provider.",
  "Follow dietary guidelines for managing cholesterol levels.",
  "Set reminders for upcoming lab tests or screenings.",
  "Document any changes in mood or emotional well-being.",
  "Review and adjust exercise plan based on progress and goals.",
];


class TabletScaffold extends StatefulWidget {
  const TabletScaffold({Key? key}) : super(key: key);

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  final String username = "Clive Sasaka";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      appBar: myAppBar,
      drawer: myDrawer,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Welcome, $username!",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // first 4 boxes in grid
            AspectRatio(
              aspectRatio: 4,
              child: SizedBox(
                width: double.infinity,
                child: GridView.builder(
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                     String title;
                    String subtitle;
                    IconData icon;

                    // Some hard coded values to the boxes
                    switch (index) {
                      case 0:
                        title = 'Medications';
                        subtitle = '3 medications';
                        icon = Icons.medication;
                        break;
                      case 1:
                        title = 'Hospitals';
                        subtitle = '5 hospitals';
                        icon = Icons.local_hospital;
                        break;
                      case 2:
                        title = 'Doctors';
                        subtitle = '2 doctors';
                        icon = Icons.person_2_sharp;
                        break;
                      case 3:
                        title = 'Treatments';
                        subtitle = '4 treatments';
                        icon = Icons.healing;
                        break;
                      default:
                        title = '';
                        subtitle = '';
                        icon = Icons.error;
                    }

                    return MyBox(
                      title: title,
                      subtitle: subtitle,
                      icon: icon,
                    );
                  },
                ),
              ),
            ),

            // list of previous days
             Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return MyTile(
                    randomText: texts[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
