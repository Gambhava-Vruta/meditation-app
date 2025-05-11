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
    print('inser$name');
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
  Future<List<Map<String, dynamic>>> getUsers() async {
    var db = await openDatabase('your_database.db');
    var result = await db.query('users');
    print(result);  // Add this to check if any records are fetched
    return result;
  }


}