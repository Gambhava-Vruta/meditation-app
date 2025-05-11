import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'DatabaseHelper.dart'; // Ensure this file contains the database operations

import 'StringConst.dart';

class UserEntryFormPage extends StatefulWidget {
  final int? userId; // Changed index to userId for better clarity

  UserEntryFormPage({super.key, this.userId});

  @override
  State<UserEntryFormPage> createState() => _UserEntryFormPageState();
}

class _UserEntryFormPageState extends State<UserEntryFormPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passworconformdController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  List<String> cities = ['Ahmedabad', 'Surat', 'Rajkot', 'Vadodara'];
  String? selectedCity;
  String? gender;
  DateTime? selectedDate;
  int? age;

  @override
  void initState() {
    super.initState();
    if (widget.userId != null) {
      _loadUser(widget.userId!);
    } else {
      selectedCity = cities[0]; // Default city for new users
    }
  }

  Future<void> _loadUser(int userId) async {
    Map<String, dynamic>? userData = await DatabaseHelper.getUserById(userId);
    if (userData != null) {
      setState(() {
        nameController.text = userData['name'] ?? '';
        emailController.text = userData['email'] ?? '';
        phoneController.text = userData['phoneNumber'] ?? '';
        passwordController.text = userData['password'] ?? '';
        passworconformdController.text = userData['password'] ?? '';
        selectedCity = userData['city'] ?? cities[0];
        gender = userData['gender'];
        selectedDate = DateTime.tryParse(userData['dob'] ?? '');
        age = selectedDate != null ? calculateAge(selectedDate!) : null;
      });
    }
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  bool validateAge(DateTime? birthDate) {
    if (birthDate == null) return false;
    int age = calculateAge(birthDate);
    return age >= 18 && age <= 80;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: Text(
          widget.userId == null ? 'Register User' : 'Edit User',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                _buildTextField(nameController, 'Full Name', TextInputType.name, r"^[a-zA-Z\s'-]{3,50}\$",
                    'Enter a valid full name (3-50 characters, alphabets only)'),
                SizedBox(height: 10),
                _buildTextField(emailController, 'Email', TextInputType.emailAddress,
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$', 'Enter a valid email address'),
                SizedBox(height: 10),
                _buildTextField(phoneController, 'Phone Number', TextInputType.phone,
                    r'^[0-9]{10}\$', 'Enter a valid 10-digit phone number'),
                SizedBox(height: 10),
                _buildDatePicker(),
                SizedBox(height: 10),
                _buildGenderSelection(),
                SizedBox(height: 10),
                _buildCityDropdown(),
                SizedBox(height: 10),
                _buildTextField(passwordController, 'Password', TextInputType.visiblePassword, null, 'Enter password', obscureText: true),
                SizedBox(height: 10),
                _buildTextField(passworconformdController, 'Confirm Password', TextInputType.visiblePassword, null, 'Confirm password', obscureText: true),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink.shade200),
                  onPressed: () {
                  //  if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> map = {
                        'name': nameController.text,
                        'email': emailController.text,
                        'phoneNumber': phoneController.text,
                        'city': selectedCity,
                        'gender': gender,
                        'age': age,
                        'dob': selectedDate?.toIso8601String(),
                        'password': passwordController.text,
                      };
                      Navigator.pop(context, map);
                    // }
                  },
                  child: Text(widget.userId == null ? 'Submit' : 'Edit',
                      style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, TextInputType type, String? pattern, String errorMsg, {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: type,
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  Widget _buildDatePicker() {
    return TextFormField(
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1945),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate;
            age = calculateAge(selectedDate!);
          });
        }
      },
      decoration: InputDecoration(
        labelText: "Date of Birth",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      controller: TextEditingController(
        text: selectedDate == null ? '' : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} - Age: $age",
      ),
    );
  }
  Widget _buildCityDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedCity,
      decoration: InputDecoration(
        labelText: "City",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      items: cities.map((city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(city),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCity = value;
        });
      },
      validator: (value) => value == null ? "Please select a city" : null,
    );
  }
  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Gender", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: Text("Male"),
                value: "Male",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text("Female"),
                value: "Female",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

}
