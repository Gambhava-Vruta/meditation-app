import 'package:flutter/material.dart';
import 'package:flutter_project/app2/addUser.dart';
import 'package:flutter_project/app2/databaseservice.dart';
import 'package:flutter_project/app2/Userlist.dart';
import 'package:flutter_project/app2/User.dart'; // Import User model

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink.shade200,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBoxWithIconAndText(
                context,
                'Add User',
                Icons.person_add,
                Colors.blue.shade200,
                Colors.white,
                    () async {
                  final User? newUser = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserEntryFormPage()),
                  );
                  if (newUser != null) {
                    await _databaseService.addUser(newUser);
                    setState(() {}); // Refresh UI after adding user
                  }
                },
              ),
              const SizedBox(width: 20),
              _buildBoxWithIconAndText(
                context,
                'View Users',
                Icons.list,
                Colors.blue.shade200,
                Colors.white,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserListPage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Method to build the box with both text and an icon
  Widget _buildBoxWithIconAndText(BuildContext context, String label,
      IconData icon, Color boxColor, Color textColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: textColor,
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
