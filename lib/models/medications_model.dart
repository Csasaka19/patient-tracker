class Medication {
  final String name;
  final String dosage;
  final String instructions;

  Medication(
      {required this.name, required this.dosage, required this.instructions});

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json['name'],
      dosage: json['dosage'],
      instructions: json['instructions'],
    );
  }
}
