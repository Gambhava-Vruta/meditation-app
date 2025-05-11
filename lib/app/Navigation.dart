import 'package:flutter/material.dart';
import 'Adduser.dart';
import 'Dasboard.dart';
import 'Favourite.dart';
import 'about_us.dart';
import 'view_user_list.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0; // Initially set to Dashboard

  final List<Widget> _screens = [
    Dashbord(), // Dashboard Screen
    UserEntryFormPage(), // Add User Screen
    UserListPage(), // User List Screen
    Favouritepage(), // Favorites Screen
    AboutUs(), // About Us Screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.person_add), label: "Add User"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "User List"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "About Us"),
        ],
      ),
    );
  }
}
