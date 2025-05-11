
class User {
  final int? id; // Nullable for new users
  final String name;
  final String email;
  final String phoneNumber;
  final int age;
  final String gender;
  final String dob;
  final String city;
  final String password;
  bool isFavourite;

  User({
    this.id, // Nullable for new users
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.age,
    required this.gender,
    required this.dob,
    required this.city,
    required this.password,
    required this.isFavourite,
  });
}