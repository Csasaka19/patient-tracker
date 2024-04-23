class HospitalVisit {
  final String id;
  final String user_id;
  final String visit_date;
  final String description;

  HospitalVisit(
      {required this.id, required this.user_id ,required this.visit_date, required this.description});

  factory HospitalVisit.fromJson(Map<String, dynamic> json) {
    return HospitalVisit(
      id: json['id'].toString(),
      user_id: json['user_id'].toString(),
      visit_date: json['visit_date'].toString(),
      description: json['description'].toString(),
    );
  }
}
