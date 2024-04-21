class Medication {
  final String name;
  final String description;
  final String image;

  Medication(
      {required this.name, required this.description, required this.image});

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}
