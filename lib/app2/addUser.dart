import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'databaseservice.dart';
import 'User.dart';

class UserEntryFormPage extends StatefulWidget {
  final User? user;

  const UserEntryFormPage({super.key, this.user});

  @override
  State<UserEntryFormPage> createState() => _UserEntryFormPageState();
}

class _UserEntryFormPageState extends State<UserEntryFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String? _selectedCity;
  String? _selectedGender;
  DateTime? _selectedDate;
  bool _isFavourite = false;

  final DatabaseService _databaseService = DatabaseService.instance;
  final List<String> _cities = ['Ahmedabad', 'Surat', 'Rajkot', 'Vadodara'];

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nameController.text = widget.user!.name;
      _emailController.text = widget.user!.email;
      _phoneController.text = widget.user!.phoneNumber;
      _passwordController.text = widget.user!.password;
      _confirmPasswordController.text = widget.user!.password;
      _selectedCity = widget.user!.city;
      _selectedGender = widget.user!.gender;
      _dobController.text = widget.user!.dob;
      _isFavourite = widget.user!.isFavourite;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1945),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      final existingUser = widget.user;
      final newUser = User(
        id: existingUser?.id,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        age: 0, // Age calculation logic can be added if required
        gender: _selectedGender ?? "Male",
        dob: _dobController.text.trim(),
        city: _selectedCity ?? _cities.first,
        password: _passwordController.text.trim(),
        isFavourite: _isFavourite,
      );
      if (existingUser == null) {
        await _databaseService.addUser(newUser);
      } else {
        await _databaseService.updateUser(newUser);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: Text(
          widget.user == null ? 'Register User' : 'Edit User',
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
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Full Name'),
                  validator: (value) => value!.isEmpty ? 'Enter Name' : null,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,

                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value!.length != 10
                      ? 'Enter 10-digit phone number'
                      : null,
                ),
                TextFormField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? 'Select Date of Birth' : null,
                ),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: InputDecoration(labelText: 'Gender'),
                  items: ['Male', 'Female', 'Other'].map((String gender) {
                    return DropdownMenuItem(value: gender, child: Text(gender));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedGender = value!),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedCity,
                  decoration: InputDecoration(labelText: 'City'),
                  items: _cities.map((city) {
                    return DropdownMenuItem(value: city, child: Text(city));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedCity = value!),
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value) => value!.length < 6 ? 'Min 6 characters' : null,
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  validator: (value) => value != _passwordController.text
                      ? 'Passwords do not match'
                      : null,
                ),
                SwitchListTile(
                  title: Text('Favorite User'),
                  value: _isFavourite,
                  onChanged: (value) => setState(() => _isFavourite = value),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink.shade200),
                  onPressed: _saveUser,
                  child: Text(
                    widget.user == null ? 'Submit' : 'Edit',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
