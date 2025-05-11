import 'package:flutter_project/app5api/User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// class DatabaseService {
//   static Database? _db;
//   static final DatabaseService instance = DatabaseService._constructor();
//
//   final String _tableName = 'users';
//
//   final String _columnId = 'id';
//   final String _columnFullName = 'full_name';
//   final String _columnEmail = 'email';
//   final String _columnPhone = 'phone';
//   final String _columnPassword = 'password';
//   final String _columnGender = 'gender';
//   final String _columnDob = 'dob';
//   final String _columnAge = 'age';
//   final String _columnHeight = 'height';
//   final String _columnWeight = 'weight';
//   final String _columnMaritalStatus = 'marital_status';
//   final String _columnReligion = 'religion';
//   final String _columnCaste = 'caste';
//   final String _columnMotherTongue = 'mother_tongue';
//   final String _columnNationality = 'nationality';
//   final String _columnCity = 'city';
//   final String _columnState = 'state';
//   final String _columnCountry = 'country';
//   final String _columnEducation = 'education';
//   final String _columnProfession = 'profession';
//   final String _columnIncome = 'income';
//   final String _columnDiet = 'diet';
//   final String _columnHobbies = 'hobbies';
//   final String _columnIsFavourite = 'isFavourite';
//
//   DatabaseService._constructor(); // ✅ Singleton Constructor
//
//   Future<Database> get database async {
//     if (_db != null) return _db!;
//     _db = await _initDatabase();
//     return _db!;
//   }
//
//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'matrimonial_db.db');
//
//     return await openDatabase(
//       path,
//       version: 3, // Increment the version when modifying schema
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE $_tableName (
//             $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
//             $_columnFullName TEXT NOT NULL,
//             $_columnEmail TEXT UNIQUE NOT NULL,
//             $_columnPhone TEXT UNIQUE NOT NULL,
//             $_columnPassword TEXT NOT NULL,
//             $_columnGender TEXT NOT NULL,
//             $_columnDob TEXT NOT NULL,
//             $_columnAge INTEGER NOT NULL,
//             $_columnHeight TEXT,
//             $_columnWeight INTEGER,
//             $_columnMaritalStatus TEXT,
//             $_columnReligion TEXT,
//             $_columnCaste TEXT,
//             $_columnMotherTongue TEXT,
//             $_columnNationality TEXT,
//             $_columnCity TEXT,
//             $_columnState TEXT,
//             $_columnCountry TEXT,
//             $_columnEducation TEXT,
//             $_columnProfession TEXT,
//             $_columnIncome TEXT,
//             $_columnDiet TEXT,
//             $_columnHobbies TEXT,
//             $_columnIsFavourite INTEGER NOT NULL DEFAULT 0
//           )
//         ''');
//       },
//     );
//   }
//
//   // ✅ Add User
//   Future<int> addUser(User user) async {
//     final db = await database;
//
//     Map<String, dynamic> userData = {
//       _columnFullName: user.name,
//       _columnEmail: user.email,
//       _columnPhone: user.phoneNumber,
//       _columnPassword: user.password,
//       _columnGender: user.gender,
//       _columnDob: user.dob,
//       _columnAge: user.age,
//       _columnHeight: user.height,
//       _columnWeight: user.weight,
//       _columnMaritalStatus: user.maritalStatus,
//       _columnReligion: user.religion,
//       _columnCaste: user.caste,
//       _columnMotherTongue: user.motherTongue,
//       _columnNationality: user.nationality,
//       _columnCity: user.city,
//       _columnState: user.state,
//       _columnCountry: user.country,
//       _columnEducation: user.education,
//       _columnProfession: user.profession,
//       _columnIncome: user.income,
//       _columnDiet: user.diet,
//       _columnHobbies: user.hobbies,
//       _columnIsFavourite: user.isFavourite ? 1 : 0,
//     };
//
//     return await db.insert(_tableName, userData);
//   }
//
//
//
//   // ✅ Update User
//   Future<int> updateUser(User user) async {
//     final db = await database;
//     return await db.update(
//       _tableName,
//       {
//         _columnFullName: user.name,
//         _columnEmail: user.email,
//         _columnPhone: user.phoneNumber,
//         _columnPassword: user.password,
//         _columnGender: user.gender,
//         _columnDob: user.dob,
//         _columnAge: user.age,
//         _columnHeight: user.height,
//         _columnWeight: user.weight,
//         _columnMaritalStatus: user.maritalStatus,
//         _columnReligion: user.religion,
//         _columnCaste: user.caste,
//         _columnMotherTongue: user.motherTongue,
//         _columnNationality: user.nationality,
//         _columnCity: user.city,
//         _columnState: user.state,
//         _columnCountry: user.country,
//         _columnEducation: user.education,
//         _columnProfession: user.profession,
//         _columnIncome: user.income,
//         _columnDiet: user.diet,
//         _columnHobbies: user.hobbies,
//         _columnIsFavourite: user.isFavourite ? 1 : 0,
//       },
//       where: '$_columnId = ?',
//       whereArgs: [user.id],
//     );
//   }
//
//
//   // ✅ Delete User
//   Future<int> deleteUser(int id) async {
//     final db = await database;
//     return await db.delete(_tableName, where: '$_columnId = ?', whereArgs: [id]);
//   }
//
//   // ✅ Get All Users
//   Future<List<User>> getUsers() async {
//     final db = await database;
//     final data = await db.query(_tableName);
//
//     if (data.isEmpty) {
//       return [];
//     }
//
//     return data.map((e) => User(
//       id: e[_columnId] as int,
//       name: e[_columnFullName] as String? ?? '',
//       email: e[_columnEmail] as String? ?? '',
//       phoneNumber: e[_columnPhone] as String? ?? '',
//       password: e[_columnPassword] as String? ?? '',
//       gender: e[_columnGender] as String? ?? 'Unknown',
//       dob: e[_columnDob] as String? ?? 'N/A',
//       age: (e[_columnAge] as int?) ?? 0,
//       height: e[_columnHeight] as String? ?? '',
//       weight: (e[_columnWeight] as int?) ?? 0,
//       maritalStatus: e[_columnMaritalStatus] as String? ?? '',
//       religion: e[_columnReligion] as String? ?? '',
//       caste: e[_columnCaste] as String? ?? '',
//       motherTongue: e[_columnMotherTongue] as String? ?? '',
//       nationality: e[_columnNationality] as String? ?? '',
//       city: e[_columnCity] as String? ?? '',
//       state: e[_columnState] as String? ?? '',
//       country: e[_columnCountry] as String? ?? '',
//       education: e[_columnEducation] as String? ?? '',
//       profession: e[_columnProfession] as String? ?? '',
//       income: e[_columnIncome] as String? ?? '',
//       diet: e[_columnDiet] as String? ?? '',
//       hobbies: e[_columnHobbies] as String? ?? '',
//       isFavourite: (e[_columnIsFavourite] as int?) == 1,
//     )).toList();
//   }
//   Future<List<User>> getFavoriteUsers() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(
//       _tableName,
//       where: '$_columnIsFavourite = ?',
//       whereArgs: [1],
//     );
//
//     return maps.map((e) => User(
//       id: e[_columnId] as int,
//       name: e[_columnFullName] as String? ?? '',
//       email: e[_columnEmail] as String? ?? '',
//       phoneNumber: e[_columnPhone] as String? ?? '',
//       password: e[_columnPassword] as String? ?? '',
//       gender: e[_columnGender] as String? ?? 'Unknown',
//       dob: e[_columnDob] as String? ?? 'N/A',
//       age: (e[_columnAge] as int?) ?? 0,
//       height: e[_columnHeight] as String? ?? '',
//       weight: (e[_columnWeight] as int?) ?? 0,
//       maritalStatus: e[_columnMaritalStatus] as String? ?? '',
//       religion: e[_columnReligion] as String? ?? '',
//       caste: e[_columnCaste] as String? ?? '',
//       motherTongue: e[_columnMotherTongue] as String? ?? '',
//       nationality: e[_columnNationality] as String? ?? '',
//       city: e[_columnCity] as String? ?? '',
//       state: e[_columnState] as String? ?? '',
//       country: e[_columnCountry] as String? ?? '',
//       education: e[_columnEducation] as String? ?? '',
//       profession: e[_columnProfession] as String? ?? '',
//       income: e[_columnIncome] as String? ?? '',
//       diet: e[_columnDiet] as String? ?? '',
//       hobbies: e[_columnHobbies] as String? ?? '',
//       isFavourite: (e[_columnIsFavourite] as int?) == 1,
//     )).toList();
//   }
//
//
// }
import 'dart:convert';
import 'package:http/http.dart' as http;

class DatabaseService {
  static const String _baseUrl = 'https://66ed09c0380821644cdb1124.mockapi.io';
  static const String _usersEndpoint = '$_baseUrl/studentdata';

  Future<int> addUser(User user) async {
    print('Sending POST request to: $_usersEndpoint'); // Debug
    print('Request Body: ${jsonEncode(user.toJson())}'); // Debug

    final response = await http.post(
      Uri.parse(_usersEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    print('Response Status Code: ${response.statusCode}'); // Debug
    print('Response Body: ${response.body}'); // Debug

    if (response.statusCode == 201) {
      var responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('id')) {
        return responseBody['id']; // Return the user ID
      } else {
        throw Exception('User ID not found in the response');
      }
    } else {
      throw Exception('user added');
    }
  }


  Future<bool> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$_usersEndpoint/${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<bool> deleteUser(int id) async {
    print('Attempting to delete user with ID: $id');
    final response = await http.delete(
      Uri.parse('$_usersEndpoint/$id'),
    );

    print('DELETE Response Status Code: ${response.statusCode}'); // Debug
    print('DELETE Response Body: ${response.body}'); // Debug

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to delete user. Status code: ${response.statusCode}');
    }
  }

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(_usersEndpoint));

    // Debug: Print the API response status code and body
    print('API Response Status Code: ${response.statusCode}');
    print('API Response Body: ${response.body}');

    if (response.statusCode == 200) {
      // Parse the response as a List<dynamic>
      List<dynamic> data = jsonDecode(response.body);

      // Debug: Print the parsed JSON data
      print('Parsed JSON Data: $data');

      // Convert each JSON object in the list to a User object
      return data.map((e) => _parseUserFromJson(e)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  // ✅ Get Favorite Users
  Future<List<User>> getFavoriteUsers() async {
    final response = await http.get(Uri.parse('$_usersEndpoint?isFavourite=1'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => _parseUserFromJson(e)).toList();
    } else {
      throw Exception('Failed to load favorite users');
    }
  }

  // Helper method to parse JSON into a User object
  User _parseUserFromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse(json['id'] ?? '0'), // Provide a default value if null
      name: json['full_name'] ?? 'Unknown', // Provide a default value if null
      email: json['email'] ?? '',
      phoneNumber: json['phone'] ?? '',
      password: json['password'] ?? '',
      gender: json['gender'] ?? 'Unknown',
      dob: json['dob'] ?? 'N/A',
      age: json['age'] ?? 0,
      height: json['height'] ?? '',
      weight: json['weight'] ?? 0,
      maritalStatus: json['marital_status'] ?? '',
      religion: json['religion'] ?? '',
      caste: json['caste'] ?? '',
      motherTongue: json['mother_tongue'] ?? '',
      nationality: json['nationality'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      education: json['education'] ?? '',
      profession: json['profession'] ?? '',
      income: json['income'] ?? '',
      diet: json['diet'] ?? '',
      hobbies: json['hobbies'] ?? '',
      isFavourite: json['isFavourite'] == 1,
    );
  }

}