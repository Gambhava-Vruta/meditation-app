// import 'package:flutter/material.dart';
// import 'package:flutter_project/app4/User.dart';
// import 'package:flutter_project/app4/DatabaseService.dart';
//
// class FavoriteUsersPage extends StatefulWidget {
//   const FavoriteUsersPage({super.key});
//
//   @override
//   State<FavoriteUsersPage> createState() => _FavoriteUsersPageState();
// }
//
// class _FavoriteUsersPageState extends State<FavoriteUsersPage> {
//   final DatabaseService _databaseService = DatabaseService.instance;
//   List<User> _favoriteUsers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchFavoriteUsers();
//   }
//
//   Future<void> _fetchFavoriteUsers() async {
//     List<User> users = await _databaseService.getFavoriteUsers(); // Use a dedicated method
//     setState(() {
//       _favoriteUsers = users;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFD3C4), // Soft Peach Background
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Row(
//           children: [
//             Image.asset('assets/logo/logo.jpg', height: 40),
//             const SizedBox(width: 10),
//             const Expanded(
//               child: Text(
//                 "Favourite Members",
//                 style: TextStyle(
//                   color: Colors.black87,
//                   fontWeight: FontWeight.bold,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         elevation: 0,
//       ),
//       body:
//
//       Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFFFFD3C4), // Soft Peach
//               Color(0xFFFF8B7B), // Light Pinkish Orange
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: _favoriteUsers.isEmpty
//             ? const Center(child: Text("No favorite users found"))
//             : ListView.builder(
//           padding: const EdgeInsets.all(10),
//           itemCount: _favoriteUsers.length,
//           itemBuilder: (context, index) {
//             final user = _favoriteUsers[index];
//             return Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 5,
//               margin: const EdgeInsets.symmetric(vertical: 8),
//               child: ListTile(
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 leading: CircleAvatar(
//                   radius: 25,
//                   backgroundColor: Colors.pink.shade100,
//                   backgroundImage: AssetImage(_getAvatar(user.gender)),
//                 ),
//                 title: Text(
//                   user.name,
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 subtitle: Text(user.email, style: TextStyle(color: Colors.grey[700])),
//                 trailing: IconButton(
//                   icon: Icon(
//                     user.isFavourite ? Icons.favorite : Icons.favorite_border, // ✅ Corrected condition
//                     color: user.isFavourite ? Colors.deepOrange : Colors.grey, // ✅ Corrected condition
//                   ),
//                   onPressed: () async {
//                     setState(() {
//                       user.isFavourite = !user.isFavourite;
//                     });
//                     await _databaseService.updateUser(user);
//                     _fetchFavoriteUsers(); // Refresh the list
//                   },
//                 ),
//
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   String _getAvatar(String gender) {
//     return gender.toLowerCase() == "male"
//         ? "assets/logo/male.webp"
//         : "assets/logo/femail.webp";
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_project/app5api/User.dart';
import 'package:flutter_project/app5api/DatabaseService.dart';
import 'package:flutter_project/app5api/userdetailfile.dart';

class FavoriteUsersPage extends StatefulWidget {
  const FavoriteUsersPage({super.key});

  @override
  State<FavoriteUsersPage> createState() => _FavoriteUsersPageState();
}

class _FavoriteUsersPageState extends State<FavoriteUsersPage> {
  final DatabaseService _databaseService = DatabaseService()
  ;
  List<User> _favoriteUsers = [];
  List<User> _filteredUsers = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchFavoriteUsers();
    _searchController.addListener(_filterUsers);
  }

  Future<void> _fetchFavoriteUsers() async {
    List<User> users = await _databaseService.getFavoriteUsers();
    setState(() {
      _favoriteUsers = users;
      _filteredUsers = users; // Initially, show all users
    });
    print(_favoriteUsers); // Debug: Check if favorite users are fetched
  }

  void _filterUsers() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _favoriteUsers
          .where((user) =>
      user.name.toLowerCase().contains(query) ||
          user.email.toLowerCase().contains(query) ||
          user.city.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD3C4), // Soft Peach Background
      appBar: AppBar(
        backgroundColor: Colors.white, // Keep existing AppBar style
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/logo/logo.jpg', height: 40),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                "Favourite Members",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFD3C4), Color(0xFFFF8B7B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            _buildSearchBar(), // Search bar below AppBar
            Expanded(
              child: _filteredUsers.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: _filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = _filteredUsers[index];
                  return _buildUserTile(user);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search favorite users...",
          hintStyle: const TextStyle(color: Colors.black54),
          prefixIcon: const Icon(Icons.search, color: Colors.black87),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.black87),
      ),
    );
  }

  Widget _buildUserTile(User user) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.pink.shade100,
          backgroundImage: AssetImage(_getAvatar(user.gender)),
        ),
        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(user.city, style: TextStyle(color: Colors.grey[700])),
        trailing: IconButton(
          icon: Icon(
            user.isFavourite ? Icons.favorite : Icons.favorite_border,
            color: user.isFavourite ? Colors.deepOrange : Colors.grey,
          ),
          onPressed: () async {
            setState(() {
              user.isFavourite = !user.isFavourite;
            });
            await _databaseService.updateUser(user);
            _fetchFavoriteUsers();
          },
        ),
        onTap: () => _navigateToUserDetail(user), // Navigate to user detail
      ),
    );
  }

  void _navigateToUserDetail(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserDetailPage(user: user)),
    );
  }

  // 🖼 Avatar Image Based on Gender
  String _getAvatar(String gender) {
    return gender.toLowerCase() == "male"
        ? "assets/logo/male.webp"
        : "assets/logo/femail.webp";
  }
}
