import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final Function(int) onTabChange; // Callback function to change tab

  const DashboardPage({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset('assets/logo/logo.jpg', height: 40), // Replace with your logo asset
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFD3C4), // Soft Peach
              Color(0xFFFF8B7B), // Coral Pink
            ],
          ),
        ),
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            padding: const EdgeInsets.all(20),
            children: [
              _buildDashboardCard(
                icon: Icons.person_add,
                text: "Add User",
                onTap: () {
                  onTabChange(1); // Switch to Add User tab
                },
              ),
              _buildDashboardCard(
                icon: Icons.list,
                text: "User List",
                onTap: () {
                  onTabChange(2); // Switch to User List tab
                },
              ),
              _buildDashboardCard(
                icon: Icons.favorite,
                text: "Favourite Users",
                onTap: () {
                  onTabChange(3); // Switch to Favorites tab
                },
              ),
              _buildDashboardCard(
                icon: Icons.info,
                text: "About Us",
                onTap: () {
                  onTabChange(4); // Switch to About Us tab
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard({required IconData icon, required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white.withOpacity(0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.deepOrange),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
