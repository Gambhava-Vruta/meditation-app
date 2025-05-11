import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // Import intl package for DateFormat
import 'StringConst.dart';

class UserDetailPage extends StatelessWidget {
  final Map<String, dynamic> userDetails;

  UserDetailPage({required this.userDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: Text(
          'User Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailCard(
                'Name',
                userDetails[NAME] ?? 'Not available',
                Icons.account_circle,
              ),
              SizedBox(height: 16),
              _buildDetailCard(
                'Email',
                userDetails[EMAIL] ?? 'Not available',
                Icons.email,
              ),
              SizedBox(height: 16),
              _buildDetailCard(
                'Phone',
                userDetails[PHONENUMBER] ?? 'Not available',
                Icons.phone,
              ),
              SizedBox(height: 16),
              _buildDetailCard(
                'City',
                userDetails[CITY] ?? 'Not available',
                Icons.location_city,
              ),
              SizedBox(height: 16),
              _buildDetailCard(
                'Age',
                (userDetails[AGE]?.toString()) ?? 'Not available',
                Icons.cake,
              ),
              SizedBox(height: 16),
              _buildDetailCard(
                'Gender',
                userDetails[GENDER] ?? 'Not available',
                Icons.transgender,
              ),
              SizedBox(height: 16),
              _buildDetailCard(
                'Date of Birth',
                _formatDate(userDetails[DOB]), // Format the DateTime field
                Icons.calendar_today,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to format DateTime to string
  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Not available'; // Handle null case
    }
    return DateFormat('yyyy-MM-dd').format(date); // You can change the format
  }

  Widget _buildDetailCard(String label, String value, IconData icon) {
    return Card(
      color: Colors.pink.shade50,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.blue.shade300),
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
}
