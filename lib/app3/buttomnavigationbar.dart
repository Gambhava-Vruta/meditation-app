import 'package:flutter/material.dart';
import 'dashboardpage.dart';
import 'adduserpage.dart';
import 'userlistpage.dart';
import 'favouriteuserpage.dart';
import '../app1/about_us.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Track selected tab index

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      DashboardPage(onTabChange: _onTabChange), // Pass the function to Dashboard
      AddUserPage(),
      UserListPage(),
      FavoriteUsersPage(),
      AboutUs(),
    ];

    return Scaffold(
      body: _pages[_selectedIndex], // Display selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        onTap: _onTabChange, // Directly use _onTabChange
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add User",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Users",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "About Us",
          ),
        ],
      ),
    );
  }
}
