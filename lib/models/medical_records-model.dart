class MedicalRecord {
  final String appointment;
  final String diagnosis;
  final String treatmentPlan;
  final String record;

  MedicalRecord(
      {required this.appointment,
      required this.diagnosis,
      required this.treatmentPlan,
      required this.record});

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      appointment: json['appointment'],
      diagnosis: json['diagnosis'],
      treatmentPlan: json['treatmentPlan'],
      record: json['record'],
    );
  }
}
