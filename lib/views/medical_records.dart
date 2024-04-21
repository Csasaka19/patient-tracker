import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/models/medical_records-model.dart';

class MedicalRecordsPage extends StatefulWidget {
  @override
  _MedicalRecordsPageState createState() => _MedicalRecordsPageState();
}

class _MedicalRecordsPageState extends State<MedicalRecordsPage> {
  Future<List<MedicalRecord>> fetchMedicalRecords() async {
    final response = await http
        .get(Uri.parse("https://api.patienttrackerapp.com/medications"));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => MedicalRecord.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load medical records from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: const Text('Medical Records'),
        backgroundColor: appbartextColor,
      ),
      body: FutureBuilder<List<MedicalRecord>>(
        future: fetchMedicalRecords(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('User ID: ${snapshot.data![index].user_id}',
                      style: const TextStyle(color: appbartextColor)),
                  subtitle: Text(
                      'Record Date: ${snapshot.data![index].record_date}\nDescription: ${snapshot.data![index].description}',
                      style: const TextStyle(color: appbartextColor)),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
