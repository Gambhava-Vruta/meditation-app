import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteCrud extends StatefulWidget {
  const SqfliteCrud({super.key});

  @override
  State<SqfliteCrud> createState() => _SqfliteCrudState();
}

class _SqfliteCrudState extends State<SqfliteCrud> {
  late Database _database;
  List<Map<String, dynamic>> datalist = [];
  var nameController = TextEditingController();
  var  updateController=TextEditingController();

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'local_db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE todo(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)');
      },
      version: 1,
    );
  }

  Future<void> _fetchData() async {
    final List<Map<String, dynamic>> data = await _database.query('todo');
    setState(() {
      datalist = data;
    });
  }

  Future<void> update(int id, String name, BuildContext context) async {
    await _database.update('todo', {'name': name},
        where: 'id = ?',
        whereArgs: [id]);
    await _fetchData();
    Navigator.pop(context); // Close the dialog
  }

  Future<void> postData(String name, BuildContext context) async {
    await _database.insert('todo', {'name': name});
    await _fetchData(); // Refresh the data after insertion
    Navigator.pop(context); // Close the dialog
  }

  Future<void> delete(int id) async {
    await _database.delete('todo', where: 'id = ?', whereArgs: [id]);
    await _fetchData(); // Refresh the data after deletion
  }

  void showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Item'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty) {
                  await postData(nameController.text, context); // Pass the dialog context
                  nameController.clear(); // Clear the text field
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a name')),
                  );
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void showUpdateDialog(BuildContext context, int id, String currentName) {
    updateController.text = currentName; // Set the current name in the text field
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Item'),
          content: TextField(
            controller: updateController,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (updateController.text.isNotEmpty) {
                  await update(id, updateController.text, context); // Pass the dialog context
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a name')),
                  );
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _initDatabase().then((_) {
      _fetchData();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    updateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sqflite CRUD'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDialog(context);
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: datalist.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(child: Text(datalist[index]['id'].toString())),
              title: Text(datalist[index]['name']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      showUpdateDialog(context, datalist[index]['id'], datalist[index]['name']);
                    },
                    icon: Icon(Icons.edit),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () async {
                      await delete(datalist[index]['id']);
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
