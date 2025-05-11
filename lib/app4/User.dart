class User {
  int? id;
  String name;
  String email;
  String phoneNumber;
  String password;

  String gender;
  String dob;
  int age;
  String height;
  int weight;
  String maritalStatus;
  String religion;
  String caste;
  String motherTongue;
  String nationality;
  String city;
  String state;
  String country;
  String education;
  String profession;
  String income;
  String diet;
  String hobbies;
  bool isFavourite;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.gender,
    required this.dob,
    required this.age,
    required this.height,
    required this.weight,
    required this.maritalStatus,
    required this.religion,
    required this.caste,
    required this.motherTongue,
    required this.nationality,
    required this.city,
    required this.state,
    required this.country,
    required this.education,
    required this.profession,
    required this.income,
    required this.diet,
    required this.hobbies,
    this.isFavourite = false,
  });


  }


