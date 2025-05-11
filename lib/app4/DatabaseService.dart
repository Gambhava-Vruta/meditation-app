import 'package:flutter_project/app4/User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _tableName = 'users';

  final String _columnId = 'id';
  final String _columnFullName = 'full_name';
  final String _columnEmail = 'email';
  final String _columnPhone = 'phone';
  final String _columnPassword = 'password';
  final String _columnGender = 'gender';
  final String _columnDob = 'dob';
  final String _columnAge = 'age';
  final String _columnHeight = 'height';
  final String _columnWeight = 'weight';
  final String _columnMaritalStatus = 'marital_status';
  final String _columnReligion = 'religion';
  final String _columnCaste = 'caste';
  final String _columnMotherTongue = 'mother_tongue';
  final String _columnNationality = 'nationality';
  final String _columnCity = 'city';
  final String _columnState = 'state';
  final String _columnCountry = 'country';
  final String _columnEducation = 'education';
  final String _columnProfession = 'profession';
  final String _columnIncome = 'income';
  final String _columnDiet = 'diet';
  final String _columnHobbies = 'hobbies';
  final String _columnIsFavourite = 'isFavourite';

  DatabaseService._constructor(); // ✅ Singleton Constructor

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'matrimonial_db.db');

    return await openDatabase(
      path,
      version: 3, // Increment the version when modifying schema
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $_columnFullName TEXT NOT NULL,
            $_columnEmail TEXT UNIQUE NOT NULL,
            $_columnPhone TEXT UNIQUE NOT NULL,
            $_columnPassword TEXT NOT NULL,
            $_columnGender TEXT NOT NULL,
            $_columnDob TEXT NOT NULL,
            $_columnAge INTEGER NOT NULL,
            $_columnHeight TEXT,
            $_columnWeight INTEGER,
            $_columnMaritalStatus TEXT,
            $_columnReligion TEXT,
            $_columnCaste TEXT,
            $_columnMotherTongue TEXT,
            $_columnNationality TEXT,
            $_columnCity TEXT,
            $_columnState TEXT,
            $_columnCountry TEXT,
            $_columnEducation TEXT,
            $_columnProfession TEXT,
            $_columnIncome TEXT,
            $_columnDiet TEXT,
            $_columnHobbies TEXT,
            $_columnIsFavourite INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
    );
  }

  // ✅ Add User
  Future<int> addUser(User user) async {
    final db = await database;

    Map<String, dynamic> userData = {
      _columnFullName: user.name,
      _columnEmail: user.email,
      _columnPhone: user.phoneNumber,
      _columnPassword: user.password,
      _columnGender: user.gender,
      _columnDob: user.dob,
      _columnAge: user.age,
      _columnHeight: user.height,
      _columnWeight: user.weight,
      _columnMaritalStatus: user.maritalStatus,
      _columnReligion: user.religion,
      _columnCaste: user.caste,
      _columnMotherTongue: user.motherTongue,
      _columnNationality: user.nationality,
      _columnCity: user.city,
      _columnState: user.state,
      _columnCountry: user.country,
      _columnEducation: user.education,
      _columnProfession: user.profession,
      _columnIncome: user.income,
      _columnDiet: user.diet,
      _columnHobbies: user.hobbies,
      _columnIsFavourite: user.isFavourite ? 1 : 0,
    };

    return await db.insert(_tableName, userData);
  }



  // ✅ Update User
  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update(
      _tableName,
      {
        _columnFullName: user.name,
        _columnEmail: user.email,
        _columnPhone: user.phoneNumber,
        _columnPassword: user.password,
        _columnGender: user.gender,
        _columnDob: user.dob,
        _columnAge: user.age,
        _columnHeight: user.height,
        _columnWeight: user.weight,
        _columnMaritalStatus: user.maritalStatus,
        _columnReligion: user.religion,
        _columnCaste: user.caste,
        _columnMotherTongue: user.motherTongue,
        _columnNationality: user.nationality,
        _columnCity: user.city,
        _columnState: user.state,
        _columnCountry: user.country,
        _columnEducation: user.education,
        _columnProfession: user.profession,
        _columnIncome: user.income,
        _columnDiet: user.diet,
        _columnHobbies: user.hobbies,
        _columnIsFavourite: user.isFavourite ? 1 : 0,
      },
      where: '$_columnId = ?',
      whereArgs: [user.id],
    );
  }


  // ✅ Delete User
  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(_tableName, where: '$_columnId = ?', whereArgs: [id]);
  }

  // ✅ Get All Users
  Future<List<User>> getUsers() async {
    final db = await database;
    final data = await db.query(_tableName);

    if (data.isEmpty) {
      return [];
    }

    return data.map((e) => User(
      id: e[_columnId] as int,
      name: e[_columnFullName] as String? ?? '',
      email: e[_columnEmail] as String? ?? '',
      phoneNumber: e[_columnPhone] as String? ?? '',
      password: e[_columnPassword] as String? ?? '',
      gender: e[_columnGender] as String? ?? 'Unknown',
      dob: e[_columnDob] as String? ?? 'N/A',
      age: (e[_columnAge] as int?) ?? 0,
      height: e[_columnHeight] as String? ?? '',
      weight: (e[_columnWeight] as int?) ?? 0,
      maritalStatus: e[_columnMaritalStatus] as String? ?? '',
      religion: e[_columnReligion] as String? ?? '',
      caste: e[_columnCaste] as String? ?? '',
      motherTongue: e[_columnMotherTongue] as String? ?? '',
      nationality: e[_columnNationality] as String? ?? '',
      city: e[_columnCity] as String? ?? '',
      state: e[_columnState] as String? ?? '',
      country: e[_columnCountry] as String? ?? '',
      education: e[_columnEducation] as String? ?? '',
      profession: e[_columnProfession] as String? ?? '',
      income: e[_columnIncome] as String? ?? '',
      diet: e[_columnDiet] as String? ?? '',
      hobbies: e[_columnHobbies] as String? ?? '',
      isFavourite: (e[_columnIsFavourite] as int?) == 1,
    )).toList();
  }
  Future<List<User>> getFavoriteUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: '$_columnIsFavourite = ?',
      whereArgs: [1],
    );

    return maps.map((e) => User(
      id: e[_columnId] as int,
      name: e[_columnFullName] as String? ?? '',
      email: e[_columnEmail] as String? ?? '',
      phoneNumber: e[_columnPhone] as String? ?? '',
      password: e[_columnPassword] as String? ?? '',
      gender: e[_columnGender] as String? ?? 'Unknown',
      dob: e[_columnDob] as String? ?? 'N/A',
      age: (e[_columnAge] as int?) ?? 0,
      height: e[_columnHeight] as String? ?? '',
      weight: (e[_columnWeight] as int?) ?? 0,
      maritalStatus: e[_columnMaritalStatus] as String? ?? '',
      religion: e[_columnReligion] as String? ?? '',
      caste: e[_columnCaste] as String? ?? '',
      motherTongue: e[_columnMotherTongue] as String? ?? '',
      nationality: e[_columnNationality] as String? ?? '',
      city: e[_columnCity] as String? ?? '',
      state: e[_columnState] as String? ?? '',
      country: e[_columnCountry] as String? ?? '',
      education: e[_columnEducation] as String? ?? '',
      profession: e[_columnProfession] as String? ?? '',
      income: e[_columnIncome] as String? ?? '',
      diet: e[_columnDiet] as String? ?? '',
      hobbies: e[_columnHobbies] as String? ?? '',
      isFavourite: (e[_columnIsFavourite] as int?) == 1,
    )).toList();
  }


}
// import 'dart:convert';
// import 'package:flutter_project/app4/User.dart';
// import 'package:http/http.dart' as http;
//
// class DatabaseService {
//   String baseUrl = "https://your-mock-api-url.com";
//
//
//   Future<void> addUser(Map<String, dynamic> user) async {
//     var res = await http.post(
//       Uri.parse('$baseUrl/users'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(user),
//     );
//     if (res.statusCode != 201) {
//       throw Exception('Failed to add user');
//     }
//   }
//
//
//   // ✅ Update User
//   Future<void> updateUser(int id, Map<String, dynamic> user) async {
//     var res = await http.put(
//       Uri.parse('$baseUrl/users/$id'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(user),
//     );
//     if (res.statusCode != 200) {
//       throw Exception('Failed to update user');
//     }
//   }
//
//   // ✅ Delete User
//   Future<void> deleteUser(int id) async {
//     var res = await http.delete(Uri.parse('$baseUrl/users/$id'));
//     if (res.statusCode != 200) {
//       throw Exception('Failed to delete user');
//     }
//   }
//
//
//   // ✅ Get All Users
//   Future<List<dynamic>> getUsers() async {
//     var res = await http.get(Uri.parse('$baseUrl/users'));
//     if (res.statusCode == 200) {
//       List<dynamic> data = jsonDecode(res.body);
//       return data;
//     } else {
//       throw Exception('Failed to load users');
//     }
//   }
//   Future<List<dynamic>> getFavoriteUsers() async {
//     var res = await http.get(Uri.parse('$baseUrl/users?isFavourite=true'));
//     if (res.statusCode == 200) {
//       List<dynamic> data = jsonDecode(res.body);
//       return data;
//     } else {
//       throw Exception('Failed to load favorite users');
//     }
//   }
//
// }
// import 'dart:convert';
// import 'package:flutter_project/app4/User.dart';
// import 'package:http/http.dart' as http;
//
// class DatabaseService {
//   String baseUrl = "https://your-mock-api-url.com";
//
//   // ✅ Add User
//   Future<void> addUser(Map<String, dynamic> user) async {
//     var res = await http.post(
//       Uri.parse('$baseUrl/users'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(user),
//     );
//     if (res.statusCode != 201) {
//       throw Exception('Failed to add user');
//     }
//   }
//
//   // ✅ Update User
//   Future<void> updateUser(int id, Map<String, dynamic> user) async {
//     var res = await http.put(
//       Uri.parse('$baseUrl/users/$id'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(user),
//     );
//     if (res.statusCode != 200) {
//       throw Exception('Failed to update user');
//     }
//   }
//
//   // ✅ Delete User
//   Future<void> deleteUser(int id) async {
//     var res = await http.delete(Uri.parse('$baseUrl/users/$id'));
//     if (res.statusCode != 200) {
//       throw Exception('Failed to delete user');
//     }
//   }
//
//   // ✅ Get All Users
//   Future<List<User>> getUsers() async {
//     var res = await http.get(Uri.parse('$baseUrl/users'));
//     if (res.statusCode == 200) {
//       List<dynamic> data = jsonDecode(res.body);
//       return data.map((user) => User.fromJson(user)).toList(); // Map to User objects
//     } else {
//       throw Exception('Failed to load users');
//     }
//   }
//
//   // ✅ Get Favorite Users
//   Future<List<User>> getFavoriteUsers() async {
//     var res = await http.get(Uri.parse('$baseUrl/users?isFavourite=true'));
//     if (res.statusCode == 200) {
//       List<dynamic> data = jsonDecode(res.body);
//       return data.map((user) => User.fromJson(user)).toList(); // Map to User objects
//     } else {
//       throw Exception('Failed to load favorite users');
//     }
//   }
// }
