class Recommendation {
  final String id;
   final String user_id;
  final String recommendation_date;
  final String description;

  Recommendation(
      {required this.id, required this.user_id, required this.recommendation_date, required this.description});

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      id: json['id'].toString(),
      user_id: json['user_id'].toString(),
      recommendation_date: json['recommendation_date'].toString(),
      description: json['description'].toString(),
    );
  }
}
