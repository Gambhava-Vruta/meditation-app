import 'package:flutter/material.dart';
import 'package:flutter_project/app/User.dart';
import 'package:intl/intl.dart';  // Import intl package for DateFormat
import 'StringConst.dart';

class UserDetailPage extends StatefulWidget {
  final int i;

  UserDetailPage({required this.i});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late Map<String, dynamic> user; // This will hold the user data

  // Fetch user details by ID
  Future<void> _getUserDetails(int id) async {
    Map<String, dynamic>? fetchedUser = await DatabaseHelper.getUserById(id);
    if (fetchedUser != null) {
      setState(() {
        user = fetchedUser; // Update the user details
      });
    } else {
      setState(() {
        user = {}; // Empty map if no user is found
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserDetails(widget.i); // Fetch user details on screen load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: Text(
          'User Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 4,
      ),
      body: user.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show loading while data is being fetched
          : Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailCard('City', user['city'] ?? 'Not available', Icons.location_city),
                  _buildDetailCard('Phone', user['phoneNumber'] ?? 'Not available', Icons.phone),
                  _buildDetailCard('Email', user['email'] ?? 'Not available', Icons.email),
                  _buildDetailCard('Age', (user['age']?.toString()) ?? 'Not available', Icons.cake),
                  _buildDetailCard('Gender', user['gender'] ?? 'Not available', Icons.transgender),
                  _buildDetailCard('Date of Birth', _formatDate(user['dob']), Icons.calendar_today),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 60, color: Colors.pink.shade200),
          ),
          SizedBox(height: 10),
          Text(
            user['name'] ?? 'Not available', // Display name from fetched user data
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.pink),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(String label, String value, IconData icon) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.pink.shade400),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink.shade700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to format DateTime to string
  String _formatDate(dynamic date) {
    if (date == null) {
      return 'Not available'; // Handle null case
    }
    // If date is in string format, convert to DateTime first
    if (date is String) {
      try {
        date = DateTime.parse(date);
      } catch (_) {
        return 'Invalid date format'; // Handle invalid date format
      }
    }
    return DateFormat('yyyy-MM-dd').format(date); // You can change the format
  }
}
