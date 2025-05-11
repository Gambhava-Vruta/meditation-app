import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Task.dart';  // Import Task class

class databasehelper {
  static Database? _db;
  static final databasehelper instance = databasehelper._constructor();
  final String _tableName = 'todolist';
  final String _columnId = 'id';
  final String _columnTitle = 'titel';  // Mapping with Task class
  final String _columnDesc = 'desc';
  final String _columnPriority = 'priority';

  databasehelper._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tasks.db');  // Database name change

    return await openDatabase(
      path,
      version: 1,  // Keeping version 1
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $_columnTitle TEXT NOT NULL,
            $_columnDesc TEXT NOT NULL,
            $_columnPriority INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  // Insert a new task into the database
  Future<int> addTask(Task task) async {
    final db = await database;

    // Map to store the task's data
    Map<String, dynamic> taskData = {
      _columnTitle: task.titel,
      _columnDesc: task.desc,
      _columnPriority: task.priority,
    };

    print("Inserting Task Data: $taskData"); // Debugging log

    try {
      return await db.insert(_tableName, taskData);  // Insert task data into the table
    } catch (e) {
      print("Database Insert Error: $e"); // Print detailed error if any
      throw e;  // Re-throw the error after logging
    }
  }


  // Get all tasks from the database
  Future<List<Task>> getTasks() async {
    final db = await database;
    final data = await db.query(_tableName);  // Query all tasks from the table

    // If no data is found, return an empty list
    if (data.isEmpty) {
      return [];
    }

    // If data is found, map the results into a list of Task objects
    return data.map((e) => Task(
      id: e[_columnId] as int?,
      titel: e[_columnTitle] as String? ?? '',
      desc: e[_columnDesc] as String? ?? '',
      priority: e[_columnPriority] as int? ?? 0,  // Assuming priority is an integer
    )).toList();
  }


  // Update an existing task
  Future<int> updateTask(Task task) async {
    final db = await database;
    return await db.update(
      _tableName,
      {
        _columnTitle: task.titel,  // Mapping Task properties to columns
        _columnDesc: task.desc,
        _columnPriority: task.priority,
      },
      where: '$_columnId = ?',  // Update the task where the ID matches
      whereArgs: [task.id],  // The task's ID
    );
  }

  // Delete a task by ID
  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(
      _tableName,  // Table to delete from
      where: '$_columnId = ?',  // Filtering by ID
      whereArgs: [id],  // Passing the task ID to delete
    );
  }
}
