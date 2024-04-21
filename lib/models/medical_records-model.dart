import 'dart:ffi';

class MedicalRecord {
  final Int user_id;
  final String record_date;
  final String description;

  MedicalRecord(
      {required this.user_id,
      required this.record_date,
      required this.description
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      user_id: json['user_id'],
      record_date: json['record_date'],
      description: json['description'],
    );
  }
}
