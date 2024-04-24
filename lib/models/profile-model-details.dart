class UserModel {
  final String username;
  final String email;
  final String firstName;
  final String lastName;

  UserModel({required this.username, required this.email, required this.firstName, required this.lastName});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? "",
      email: json['email'] ?? "",
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
    );
  }
}
