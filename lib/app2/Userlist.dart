import 'package:flutter/material.dart';
import 'User.dart';
import 'DatabaseService.dart';
import 'addUser.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final DatabaseService _databaseService = DatabaseService.instance;
  List<User> userList = [];
  List<User> filteredList = [];
  bool isGrid = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    List<User> users = await _databaseService.getUsers();
    await Future.delayed(Duration(milliseconds: 500)); // Small delay
    setState(() {
      userList = users;
      filteredList = users;
    });
  }


  void _filterUsers(String query) {
    setState(() {
      filteredList = userList
          .where((user) =>
      user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.city.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
    print("Filtered Users: $filteredList"); // Debugging
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: const Text("User List", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () => setState(() => isGrid = false),
            icon: const Icon(Icons.list, color: Colors.white),
          ),
          IconButton(
            onPressed: () => setState(() => isGrid = true),
            icon: const Icon(Icons.grid_3x3, color: Colors.white),
          ),
          IconButton(
            onPressed: () async {
              final User? newUser = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserEntryFormPage()),
              );
              if (newUser != null) {
                await _databaseService.addUser(newUser);
                _loadUsers();
              }
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade50, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: _filterUsers,
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue.shade300),
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.pink),
                ),
              ),
            ),
            Expanded(
              child: filteredList.isEmpty
                  ? const Center(
                child: Text(
                  'No Users Found',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              )
                  : (isGrid
                  ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: filteredList.length,
                itemBuilder: (context, index) => _buildUserCard(filteredList[index]),
              )
                  : ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) => _buildUserCard(filteredList[index]),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(User user) {
    return GestureDetector(

      child: Card(
        color: Colors.pink.shade50,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(Icons.account_circle, size: 40, color: Colors.blue.shade300),
          title: Text(user.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pink.shade700)),
          subtitle: Text('${user.city} | ${user.age} years', style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  user.isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: user.isFavourite ? Colors.pink : Colors.grey.shade400,
                ),
                onPressed: () async {
                  setState(() {
                    user.isFavourite = !user.isFavourite;
                  });
                  await _databaseService.updateUser(user);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  bool confirmDelete = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Delete User"),
                      content: const Text("Are you sure you want to delete this user?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text("Delete", style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  ) ??
                      false;
                  if (confirmDelete) {
                    await _databaseService.deleteUser(user.id!);
                    _loadUsers();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
