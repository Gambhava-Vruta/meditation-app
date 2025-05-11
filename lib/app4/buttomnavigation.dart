// import 'package:flutter/material.dart';
// import 'package:flutter_project/app4/adduserFile.dart';
// import 'package:flutter_project/app4/dashboard.dart';
// import 'package:flutter_project/app4/userlistfile.dart';
// import 'package:flutter_project/app1/about_us.dart';
// import 'package:flutter_project/app4/FavouriteUser.dart';
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0; // Track selected tab index
//
//   void _onTabChange(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> _pages = [
//       DashboardPage(onTabChange: _onTabChange), // Pass the function to Dashboard
//       AddUserPage(),
//       UserListPage(),
//       FavoriteUsersPage(),
//       AboutUs(),
//     ];
//
//     return Scaffold(
//       body: _pages[_selectedIndex], // Display selected page
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.deepOrange,
//         unselectedItemColor: Colors.grey,
//         onTap: _onTabChange, // Directly use _onTabChange
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.dashboard),
//             label: "Dashboard",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: "Add User",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list),
//             label: "Users",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: "Favorites",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.info),
//             label: "About Us",
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_project/app4/adduserFile.dart';
// import 'package:flutter_project/app4/dashboard.dart';
// import 'package:flutter_project/app4/userlistfile.dart';
// import 'package:flutter_project/app1/about_us.dart';
// import 'package:flutter_project/app4/FavouriteUser.dart';
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;
//   final PageController _pageController = PageController();
//
//   void _onTabChange(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     _pageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         children: [
//           DashboardPage(onTabChange: _onTabChange),
//           AddUserPage(),
//           UserListPage(),
//           FavoriteUsersPage(),
//           AboutUs(),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.deepOrange,
//         unselectedItemColor: Colors.grey,
//         onTap: _onTabChange,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
//           BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add User"),
//           BottomNavigationBarItem(icon: Icon(Icons.list), label: "Users"),
//           BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
//           BottomNavigationBarItem(icon: Icon(Icons.info), label: "About Us"),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_project/app4/dashboard.dart';
import 'package:flutter_project/app4/userlistfile.dart';
import 'package:flutter_project/app4/FavouriteUser.dart';
import 'package:flutter_project/app4/adduserFile.dart';
import 'package:flutter_project/app1/about_us.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          DashboardPage(),
          AddUserPage(),
          UserListPage(),
          FavoriteUsersPage(),
          AboutUs(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 10,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            showUnselectedLabels: false,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.grey,
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
                _pageController.jumpToPage(index); // Navigate to the selected page
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add User"),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "Users"),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
              BottomNavigationBarItem(icon: Icon(Icons.info), label: "About Us"),
            ],
          ),
        ),
      ),
    );
  }
}

