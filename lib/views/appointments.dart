import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/models/appointment-model.dart';

class AppointmentsPage extends StatefulWidget {
  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  Future<List<Appointment>> fetchAppointments() async {
    final response = await http.get(Uri.parse("https://api.patienttrackerapp.com/appointments"));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Appointment.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load appointments from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: const Text('Appointments'),
        backgroundColor: appbartextColor,
      ),
      body: FutureBuilder<List<Appointment>>(
        future: fetchAppointments(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].date, style: const TextStyle(color: appbartextColor)),
                  subtitle: Text('Time: ${snapshot.data![index].time}\nLocation: ${snapshot.data![index].location}', style: const TextStyle(color: appbartextColor)),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}",
                style: const TextStyle(color: appbartextColor));
          }
          return const CircularProgressIndicator(color: appbartextColor,);
        },
      ),
    );
  }
}