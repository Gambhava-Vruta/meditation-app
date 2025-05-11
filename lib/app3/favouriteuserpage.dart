import 'package:flutter/material.dart';
import 'databaseservice.dart';
import 'user.dart';

class FavoriteUsersPage extends StatefulWidget {
  const FavoriteUsersPage({super.key});

  @override
  State<FavoriteUsersPage> createState() => _FavoriteUsersPageState();
}

class _FavoriteUsersPageState extends State<FavoriteUsersPage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD3C4), // Soft Peach Background
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset('assets/logo/logo.jpg', height: 40), // Replace with your logo asset

            const SizedBox(width: 10),
            const Expanded( // Prevents overflow by allowing text to adjust
              child: Text(
                "Favourite Member",
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
      body: FutureBuilder<List<User>>(
        future: _databaseService.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No favorite users found"));
          } else {
            final favoriteUsers = snapshot.data!.where((u) => u.isFavourite).toList();

            if (favoriteUsers.isEmpty) {
              return const Center(child: Text("No favorite users found"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: favoriteUsers.length,
              itemBuilder: (context, index) {
                final user = favoriteUsers[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.pink.shade100,
                      backgroundImage: AssetImage(_getAvatar(user.gender)), // Load avatar
                    ),
                    title: Text(
                      user.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(user.email, style: TextStyle(color: Colors.grey[700])),
                    trailing: IconButton(
                      icon: Icon(
                        user.isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: user.isFavourite ? Colors.deepOrange : Colors.grey,
                      ),
                      onPressed: () async {
                        user.isFavourite = !user.isFavourite; // Toggle favorite status
                        await _databaseService.updateUser(user); // Update in database
                        setState(() {}); // Refresh UI
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  // Function to get avatar based on gender (Same as UserListPage)
  String _getAvatar(String gender) {
    return gender.toLowerCase() == "male"
        ? "assets/logo/male.webp" // Path for male avatar
        : "assets/logo/femail.webp"; // Path for female avatar
  }
}
