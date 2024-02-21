import 'package:flutter/material.dart';
import 'package:patient_tracker/customs/box.dart';
import 'package:patient_tracker/customs/layout.dart';
import 'package:patient_tracker/customs/tile.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  final String username = "Clive Sasaka"; // Replace with actual username(currently hard coded for testing purposes)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // open drawer
            myDrawer,

            // first half of page
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  // Greeting
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
                          crossAxisCount: 4,
                        ),
                        itemBuilder: (context, index) {
                          String title;
                          String subtitle;
                          IconData icon;

                          // Assign some hard coded values to the boxes
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
                              icon = Icons.person;
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
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return const MyTile();
                      },
                    ),
                  ),
                ],
              ),
            ),
            // second half of page(side bar)
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 135, 134, 161),
                      ),
                    ),
                  ),
                  // list of stuff
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 72, 68, 116),
                        ),
                      ),
                    ),
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
