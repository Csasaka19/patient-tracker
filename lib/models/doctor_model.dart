class Doctor {
  final String name;
  final String specialization;
  final String image;

  Doctor(
      {required this.name, required this.specialization, required this.image});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'],
      specialization: json['specialization'],
      image: json['image'],
    );
  }
}
