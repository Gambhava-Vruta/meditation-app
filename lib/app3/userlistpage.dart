import 'package:flutter/material.dart';
import 'Userdetailpage.dart';
import 'databaseservice.dart';
import 'user.dart';

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

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _searchController.addListener(_filterUsers);
  }

  Future<void> _fetchUsers() async {
    List<User> users = await _databaseService.getUsers();
    setState(() {
      _allUsers = users;
      _filteredUsers = users;
    });
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset('assets/logo/logo.jpg', height: 40), // Replace with your logo asset

            const SizedBox(width: 10),
            const Expanded( // Prevents overflow by allowing text to adjust
              child: Text(
                "Member List",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis, // Prevents text from spilling out
                ),
              ),
            ),
          ],
        ),
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
                Text(user.email, style: TextStyle(color: Colors.grey[700])),
                Text("City: ${user.city}", style: TextStyle(color: Colors.grey[700])),
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                user.isFavourite ? Icons.favorite : Icons.favorite_border,
                color: user.isFavourite ? Colors.deepOrange : Colors.grey,
              ),
              onPressed: () async {
                user.isFavourite = !user.isFavourite;
                await _databaseService.updateUser(user);
                setState(() {});
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserDetailPage(user: user)),
              ).then((updatedUser) {
                if (updatedUser != null) {
                  _fetchUsers();
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
}
