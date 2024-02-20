import 'package:flutter/material.dart';
import 'package:patient_tracker/customs/customtext.dart';

class PatientDashboard extends StatefulWidget {
  @override
  _PatientDashboardState createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  String patientName = 'John Doe';
  String nextAppointment = '15th June 2023';
  String medicalCondition = 'Healthy'; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Dashboard'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to the edit screen
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            color: Colors.blue[100],
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Patient Name'),
              subtitle: Text(patientName),
            ),
          ),
          Card(
            color: Colors.green[100],
            child: ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Next Appointment'),
              subtitle: Text(nextAppointment),
            ),
          ),
          Card(
            color: Colors.red[100],
            child: ListTile(
              leading: Icon(Icons.healing),
              title: Text('Medical Condition'),
              subtitle: Text(medicalCondition),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your scheduling appointment functionality here
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
