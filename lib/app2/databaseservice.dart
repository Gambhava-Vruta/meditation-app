// import 'package:flutter_project/app2/User.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// class DatabaseService {
//   static Database? _db;
//   static final DatabaseService instance = DatabaseService._constructor();
//
//   final String _tablename = 'users';
//   final String _columnid = 'id';
//   final String _columnname = 'name';
//   final String _columnemail = 'email';
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
//     final path = join(dbPath, 'master_db.db');
//
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE $_tablename (
//             $_columnid INTEGER PRIMARY KEY AUTOINCREMENT,
//             $_columnname TEXT NOT NULL,
//             $_columnemail TEXT NOT NULL
//           )
//         ''');
//       },
//     );
//   }
//
//   Future<int> addUser(String name, String email) async {
//     final db = await database;
//     return await db.insert(_tablename, {
//       _columnname: name,
//       _columnemail: email,
//     });
//   }
//
//   Future<List<User>> getUser() async {
//     final db = await database;
//     final data = await db.query(_tablename);
//     return data
//         .map((e) =>
//         User(
//           id: e['id'] as int,
//           name: e['name'] as String,
//           email: e['email'] as String,
//         ))
//         .toList();
//   }
//
//   Future<void> updateUser(int id, String name, String email) async {
//     final db = await database;
//     await db.update(
//       _tablename,
//       {
//         'name': name, // Correct: Using 'name' as the column key
//         'email': email, // Correct: Using 'email' as the column key
//       },
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
//
//   Future<void> deleteUser(int id) async {
//     final db = await database;
//     await db.delete(
//       _tablename,
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
//
// }
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'User.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _tablename = 'users';
  final String _columnid = 'id';
  final String _columnname = 'name';
  final String _columnemail = 'email';
  final String _columnphone = 'phoneNumber';
  final String _columnage = 'age';
  final String _columngender = 'gender';
  final String _columndob = 'dob';
  final String _columncity = 'city';
  final String _columnpassword = 'password';
  final String _columnisFavourite = 'isFavourite';

  DatabaseService._constructor(); // ✅ Singleton Constructor

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'master_db.db');

    return await openDatabase(
      path,
      version: 2, // Change version number to apply schema changes
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tablename (
            $_columnid INTEGER PRIMARY KEY AUTOINCREMENT,
            $_columnname TEXT NOT NULL,
            $_columnemail TEXT NOT NULL,
            $_columnphone TEXT NOT NULL,
            $_columnage INTEGER NOT NULL,
            $_columngender TEXT NOT NULL,
            $_columndob TEXT NOT NULL,
            $_columncity TEXT NOT NULL,
            $_columnpassword TEXT NOT NULL,
            $_columnisFavourite INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE $_tablename ADD COLUMN $_columnphone TEXT');
          await db.execute('ALTER TABLE $_tablename ADD COLUMN $_columnage INTEGER');
          await db.execute('ALTER TABLE $_tablename ADD COLUMN $_columngender TEXT');
          await db.execute('ALTER TABLE $_tablename ADD COLUMN $_columndob TEXT');
          await db.execute('ALTER TABLE $_tablename ADD COLUMN $_columncity TEXT');
          await db.execute('ALTER TABLE $_tablename ADD COLUMN $_columnpassword TEXT');
          await db.execute('ALTER TABLE $_tablename ADD COLUMN $_columnisFavourite INTEGER DEFAULT 0');
        }
      },
    );
  }

  Future<int> addUser(User user) async {
    final db = await database;
    return await db.insert(_tablename, {
      _columnname: user.name,
      _columnemail: user.email,
      _columnphone: user.phoneNumber,
      _columnage: user.age,
      _columngender: user.gender,
      _columndob: user.dob,
      _columncity: user.city,
      _columnpassword: user.password,
      _columnisFavourite: user.isFavourite ? 1 : 0,
    });
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final data = await db.query(_tablename);

    return data.map((e) => User(
      id: e['id'] as int,
      name: e['name'] as String,
      email: e['email'] as String,
      phoneNumber: e['phoneNumber'] as String,
      age: e['age'] as int,
      gender: e['gender'] as String,
      dob: e['dob'] as String,
      city: e['city'] as String,
      password: e['password'] as String,
      isFavourite: (e['isFavourite'] as int) == 1, // Convert int to bool
    )).toList();
  }


  Future<void> updateUser(User user) async {
    final db = await database;
    await db.update(
      _tablename,
      {
        _columnname: user.name,
        _columnemail: user.email,
        _columnphone: user.phoneNumber,
        _columnage: user.age,
        _columngender: user.gender,
        _columndob: user.dob,
        _columncity: user.city,
        _columnpassword: user.password,
        _columnisFavourite: user.isFavourite ? 1 : 0,
      },
      where: '$_columnid = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete(
      _tablename,
      where: '$_columnid = ?',
      whereArgs: [id],
    );
  }
}
