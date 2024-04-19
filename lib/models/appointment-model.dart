class Appointment {
  final String date;
  final String time;
  final String location;

  Appointment({required this.date, required this.time, required this.location});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      date: json['date'],
      time: json['time'],
      location: json['location'],
    );
  }
}
