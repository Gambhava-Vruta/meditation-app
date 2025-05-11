// import 'package:flutter/cupertino.dart';
//
// import 'StringConst.dart';
//
//
// class User {
//   static List<Map<String, dynamic>> userList = [];
//
//   void addUserInList(
//   {required name,required city, required phoneNumber,required age, required email,required Gender,required Dob,required Isfavourite,required Password}
//   ) {
//     Map<String, dynamic> map = {};
//     map[NAME] = name;
//     map[AGE] = age;
//     map[EMAIL] = email;
//     map[GENDER]=Gender;
//     map[PHONENUMBER]=phoneNumber;
//     map[DOB]=Dob;
//     map['Isfavourite'];
//     map[PASSWORD]=Password;
//     map[CITY]=city;
//     print(map);
//     userList.add(map);
//   }
//
//   List<Map<String, dynamic>> getUserList() {
//     return userList;
//   }
//
//   static void updateUser(
//       {required name,required city, required phoneNumber, required email, required id,required age,required Gender,required Dob,required Isfavourite,required Password}) {
//     Map<String, dynamic> map = {};
//     map[NAME] = name;
//     map[EMAIL] = email;
//     map[AGE] = age;
//     map[GENDER]=Gender;
//     map[PHONENUMBER]=phoneNumber;
//     map[DOB]=Dob;
//     map['Isfavourite'] = false;
//     map[PASSWORD]=Password;
//     map[CITY]=city;
//
//     userList[id] = map;
//
//   }
//
//   static void deleteUser(id) {
//     userList.removeAt(id);
//   }
//
//   void searchDeatil({required searchData}) {
//     for (var element in userList) {
//       if (element[NAME]
//           .toString()
//           .toLowerCase()
//           .contains(searchData.toString().toLowerCase()) ||
//           element[EMAIL]
//               .toString()
//               .toLowerCase()
//               .contains(searchData.toString().toLowerCase())) {
//         Text(
//             '${element[NAME]} . ${element[AGE]} . ${element[EMAIL]}');
//       }
//     }
//   }
// }
//
// import 'package:flutter_project/app/StringConst.dart';
// import 'package:sqflite/sqflite.dart';
//
// class User {
//   Future<Database> initDatabase() async {
//     var db = await openDatabase('matrimony.db', onCreate: (db, version) {
//       db.execute(
//           'CREATE TABLE TblUser(UserId INTEGER PRIMARY KEY AUTOINCREMENT, UserName TEXT)');
//     }, onUpgrade: (db, oldVersion, newVersion) {
//       // if(newVersion > oldVersion){
//       //   db.execute('ALTER TABLE TblUser()');
//       // }
//     }, version: 1);
//     return db;
//   }
//
//   Future<int> addUserInList(
//       {required name,
//       required city,
//       required phoneNumber,
//       required age,
//       required email,
//       required Gender,
//       required Dob,
//       required Isfavourite,
//       required Password}) async {
//     Database db = await initDatabase();
//     Map<String, dynamic> map = {};
//     map[NAME] = name;
//     map[AGE] = age;
//     map[EMAIL] = email;
//     map[GENDER]=Gender;
//     map[PHONENUMBER]=phoneNumber;
//     map[DOB]=Dob;
//     map['Isfavourite'];
//     map[PASSWORD]=Password;
//     map[CITY]=city;
//
//     Future<void> _addData(String title, String desc) async {
//       await _database.insert('myTable', {'title': title, 'desc': desc});
//       _fetchData(); // Fetch data after adding
//     }
//
//   Future<int> updateUser(
//       {required name,
//       required city,
//       required phoneNumber,
//       required age,
//       required email,
//       required Gender,
//       required Dob,
//       required Isfavourite,
//       required Password,
//         required int userId}) async {
//     Database db = await initDatabase();
//     Map<String, dynamic> value = {};
//     Map<String, dynamic> map = {};
//     map[NAME] = name;
//     map[AGE] = age;
//     map[EMAIL] = email;
//     map[GENDER]=Gender;
//     map[PHONENUMBER]=phoneNumber;
//     map[DOB]=Dob;
//     map['Isfavourite'];
//     map[PASSWORD]=Password;
//     map[CITY]=city;
//     print(map);
//     int userID = await db
//         .update('TblUser', value, where: 'UserId = ?', whereArgs: [userId]);
//     return userID;
//   }
//
//   Future<List<Map<String, dynamic>>> getUserList() async {
//     Database db = await initDatabase();
//     List<Map<String, dynamic>> userList = await db.query('TblUser');
//     return userList;
//   }
//
//   Future<int> deleteUser(int userID) async {
//     Database db = await initDatabase();
//     int userId =
//         await db.delete('TblUser', where: 'UserId = ?', whereArgs: [userID]);
//     return userId;
//   }
// }
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  // ✅ Initialize the database
  static Future<void> initDatabase() async {
    if (_database != null) return; // Prevent re-initialization

    _database = await openDatabase(
      join(await getDatabasesPath(), 'userDatabase.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            '''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            city TEXT NOT NULL,
            phoneNumber TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            age INTEGER,
            gender TEXT NOT NULL,
            dob TEXT NOT NULL,
            isFavourite INTEGER DEFAULT 0,
            password TEXT NOT NULL
          )
          '''
        );
      },
    );
  }

  // ✅ Method to Add a User
  static Future<int> addUser({
    required String name,
    required String city,
    required String phoneNumber,
    required String email,
    required String age,
    required String gender,
    required String dob,
    required int isFavourite,
    required String password,
  }) async {
    if (_database == null) await initDatabase();

    try {
      return await _database!.insert(
        'users', // Table name
        {
          'name': name,
          'city': city,
          'phoneNumber': phoneNumber,
          'email': email,
          'age': age,
          'gender': gender,
          'dob': dob,
          'isFavourite': isFavourite,
          'password': password,
        },
      );
    } catch (e) {
      print('⚠️ Error adding user: $e');
      return 0;
    }
  }

  // ✅ Method to Update a User
  static Future<int> updateUser({
    required int id,
    required String name,
    required String city,
    required String phoneNumber,
    required String email,
    required String age,
    required String gender,
    required String dob,
    required int isFavourite,
    required String password,
  }) async {
    if (_database == null) await initDatabase();

    try {
      return await _database!.update(
        'users',
        {
          'name': name,
          'city': city,
          'phoneNumber': phoneNumber,
          'email': email,
          'age': age,
          'gender': gender,
          'dob': dob,
          'isFavourite': isFavourite,
          'password': password,
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('⚠️ Error updating user: $e');
      return 0;
    }
  }

  // ✅ Method to Delete a User
  static Future<int> deleteUser(int id) async {
    if (_database == null) await initDatabase();

    try {
      return await _database!.delete(
        'users',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('⚠️ Error deleting user: $e');
      return 0;
    }
  }
  static Future<Map<String, dynamic>?> getUserById(int id) async {
    if (_database == null) await initDatabase();

    try {
      List<Map<String, dynamic>> results = await _database!.query(
        'users',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (results.isNotEmpty) {
        return results.first; // Return the first (and only) result
      } else {
        return null; // No user found
      }
    } catch (e) {
      print('⚠️ Error fetching user: $e');
      return null; // Return null on failure
    }
  }
  // In DatabaseHelper
  static Future<List<Map<String, dynamic>>> getUsers() async {
    if (_database == null) await initDatabase();

    try {
      // Query all users from the database
      List<Map<String, dynamic>> result = await _database!.query('users');
      return result;
    } catch (e) {
      print('⚠️ Error fetching users: $e');
      return [];
    }
  }

}

