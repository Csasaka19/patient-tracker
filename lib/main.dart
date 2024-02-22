import 'package:flutter/material.dart';
import 'package:patient_tracker/views/dashboard.dart';
import 'package:patient_tracker/views/login.dart';
import 'package:patient_tracker/views/registration.dart';


void main() {
  runApp(  const MaterialApp(
    home: Login(),
    debugShowCheckedModeBanner: false,
  ));
}
