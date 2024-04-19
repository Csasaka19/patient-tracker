import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/models/medications_model.dart';



class MedicationPage extends StatefulWidget {
  @override
  _MedicationPageState createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  Future<List<Medication>> fetchMedications() async {
    final response = await http.get(Uri.parse("https://api.patienttrackerapp.com/medications"));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Medication.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load medications from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: const Text('Medications'),
        backgroundColor: appbartextColor,
      ),
      body: FutureBuilder<List<Medication>>(
        future: fetchMedications(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name,
                      style: const TextStyle(color: appbartextColor)),
                  subtitle: Text(
                      'Dosage: ${snapshot.data![index].dosage}\nInstructions: ${snapshot.data![index].instructions}',
                      style: const TextStyle(color: appbartextColor)),
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
