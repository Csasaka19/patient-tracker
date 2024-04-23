class Hospital {
  final String name;
  final String address;
  final String image;

  Hospital(
      {required this.name, required this.address, required this.image});

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      name: json['name'] ?? 'Default Name',
      address: json['address'] ?? 'Default Address',
      image: json['image'] ?? 'Default Image',
    );
  }
}
