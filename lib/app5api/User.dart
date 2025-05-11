class User {
  Map<String, dynamic> toJson() {
    return {
      'full_name': name,
      'email': email,
      'phone': phoneNumber,
      'password': password,
      'gender': gender,
      'dob': dob,
      'age': age,
      'height': height,
      'weight': weight,
      'marital_status': maritalStatus,
      'religion': religion,
      'caste': caste,
      'mother_tongue': motherTongue,
      'nationality': nationality,
      'city': city,
      'state': state,
      'country': country,
      'education': education,
      'profession': profession,
      'income': income,
      'diet': diet,
      'hobbies': hobbies,
      'isFavourite': isFavourite,
    };
  }
  int? id; // <-- Expects an int?
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




