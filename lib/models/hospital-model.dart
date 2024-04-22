class Hospital {
  final String name;
  final String address;
  final String image;

  Hospital(
      {required this.name, required this.address, required this.image});

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      name: json['name'],
      address: json['address'],
      image: json['image'],
    );
  }
}
