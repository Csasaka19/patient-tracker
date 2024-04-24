import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';

class UserGuidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: const Text('User Guide', ),
        shadowColor: blackColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/back_1.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Text(
                  'Patient Tracker User Guide',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: appbartextColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Medical info cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  10,
                  (index) => MedicalInfoCard(index),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  filled: true,
                ),
                onChanged: (value) {
                  // Implement search functionality here
                },
              ),
            ),
            const SizedBox(height: 20),
            // Confidentiality information
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confidentiality Information:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: appbartextColor
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'An easy to use application. '
                    'For your own convenience, you can keep track of your medical information. '
                    'Up to date information on medical convenience, '
                    'Your medical information is safe with us. ',
                    style: TextStyle(fontSize: 16, color: appbartextColor),
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

class MedicalInfoCard extends StatelessWidget {
  final int index;

  const MedicalInfoCard(this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Medical Info $index',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'A nice app to keep track of your medical info.',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
