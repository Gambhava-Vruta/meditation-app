import 'package:flutter/material.dart';
import 'package:flutter_project/app4/User.dart';
import 'package:flutter_project/app4/userdetailfile.dart';
import 'package:flutter_project/app4/DatabaseService.dart';
import 'package:flutter_project/todolist/databasehelper.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final DatabaseService _databaseService = DatabaseService.instance;
  List<User> _allUsers = [];
  List<User> _filteredUsers = [];
  TextEditingController _searchController = TextEditingController();
  String _sortOption = 'name_asc';

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _searchController.addListener(_filterUsers);
  }

  Future<void> _fetchUsers() async {
    try {
      List<User> users = await DatabaseService.instance.getUsers(); // Fetch users from the database
      setState(() {
        _allUsers = users;
        _filteredUsers = users;
      });
    } catch (e) {
      print('Error fetching users: $e'); // Handle errors
      // Optionally, show a message to the user (e.g., using a SnackBar)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch users: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _filterUsers() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _allUsers.where((user) {
        return user.name.toLowerCase().contains(query) ||
            user.email.toLowerCase().contains(query) ||
            user.city.toLowerCase().contains(query);
      }).toList();
    });
    _sortUsers(); // Apply sorting after filtering
  }

  void _sortUsers() {
    if (_sortOption == 'name_asc') {
      _filteredUsers.sort((a, b) => a.name.compareTo(b.name)); // A-Z
    } else if (_sortOption == 'name_desc') {
      _filteredUsers.sort((a, b) => b.name.compareTo(a.name)); // Z-A
    } else if (_sortOption == 'age_asc') {
      _filteredUsers.sort((a, b) => a.age.compareTo(b.age)); // Youngest to Oldest
    } else if (_sortOption == 'age_desc') {
      _filteredUsers.sort((a, b) => b.age.compareTo(a.age)); // Oldest to Youngest
    }
  }

  void _sortBy(String option) {
    setState(() {
      _sortOption = option;
      _sortUsers(); // Apply sorting
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset('assets/logo/logo.jpg', height: 40),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                "Member List",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              _sortBy(value); // Update sorting option when user selects one
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'name_asc',
                  child: Text('Sort by Name (A-Z)'),
                ),
                const PopupMenuItem<String>(
                  value: 'name_desc',
                  child: Text('Sort by Name (Z-A)'),
                ),
                const PopupMenuItem<String>(
                  value: 'age_asc',
                  child: Text('Sort by Age (Youngest to Oldest)'),
                ),
                const PopupMenuItem<String>(
                  value: 'age_desc',
                  child: Text('Sort by Age (Oldest to Youngest)'),
                ),
              ];
            },
          ),
        ],
        elevation: 0,
      ),
      backgroundColor: Color(0xFFFFD3C4),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFD3C4),
              Color(0xFFFF8B7B),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search Users",
                  prefixIcon: Icon(Icons.search, color: Colors.pink.shade400),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(child: _userList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.filter_list, color: Colors.white),
        onPressed: () {
          _showFilterBottomSheet();
        },
      ),
    );
  }

  Widget _userList() {
    if (_filteredUsers.isEmpty) {
      return const Center(child: Text("No users found"));
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      itemCount: _filteredUsers.length,
      itemBuilder: (context, index) {
        final user = _filteredUsers[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(_getAvatar(user.gender)),
            ),
            title: Text(
              user.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Age:${user.email}", style: TextStyle(color: Colors.grey[700])),
                Text("City: ${user.city}", style: TextStyle(color: Colors.grey[700])),
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                user.isFavourite ? Icons.favorite : Icons.favorite_border,
                color: user.isFavourite ? Colors.deepOrange : Colors.grey,
              ),
              onPressed: () async {
                setState(() {
                  user.isFavourite = !user.isFavourite; // Toggle boolean value
                });
                await _databaseService.updateUser(user);
                _fetchUsers();
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserDetailPage(user: user)),
              ).then((deleted) {
                if (deleted == true) {
                  _fetchUsers(); // Refresh the user list after deletion
                }
              });
            },
          ),
        );
      },
    );
  }

  String _getAvatar(String gender) {
    return gender.toLowerCase() == "male"
        ? "assets/logo/male.webp"
        : "assets/logo/femail.webp";
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Filter by Gender", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                    onPressed: () => _filterByGender("Male"),
                    child: Text("Male", style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pink.shade100),
                    onPressed: () => _filterByGender("Female"),
                    child: Text("Female", style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent.shade100),
                    onPressed: () => _filterByGender("All"),
                    child: Text("All", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _filterByGender(String gender) {
    Navigator.pop(context); // Close BottomSheet
    setState(() {
      if (gender == "All") {
        _filteredUsers = _allUsers;
      } else {
        _filteredUsers = _allUsers.where((user) => user.gender.toLowerCase() == gender.toLowerCase()).toList();
      }
    });
    _sortUsers(); // Apply sorting after filtering by gender
  }
}
