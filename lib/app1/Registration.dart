import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'StringConst.dart';

class UserEntryFormPage extends StatefulWidget {
  Map<String, dynamic>? userDetail;

  UserEntryFormPage({super.key, Map<String, dynamic>? userDetail}) {
    this.userDetail = userDetail;
  }

  @override
  State<UserEntryFormPage> createState() => _UserEntryFormPageState();
}

class _UserEntryFormPageState extends State<UserEntryFormPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passworconformdController = TextEditingController();

  GlobalKey<FormState> _fromKey = GlobalKey();

  List<String> cities = ['Ahmedabad', 'Surat', 'Rajkot', 'Vadodara'];
  String? selectedCity;
  String? gender;
  DateTime? selectedDate;
  int? Age;

  int findIndex(List<String> cities, selectedCity) {
    for (int i = 0; i < cities.length; i++) {
      if (selectedCity.toString().toLowerCase() == cities[i].toString().toLowerCase()) {
        return i;
      }
    }
    return 0;
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
  void initState() {
    super.initState();

    // Safely initialize controllers and variables
    if (widget.userDetail != null) {
      nameController.text = widget.userDetail![NAME]?.toString() ?? '';
      emailController.text = widget.userDetail![EMAIL]?.toString() ?? '';
      phoneController.text = widget.userDetail![PHONENUMBER]?.toString() ?? '';
      passwordController.text = widget.userDetail![PASSWORD]?.toString() ?? '';
      passworconformdController.text = widget.userDetail![PASSWORD]?.toString() ?? '';

      selectedCity = widget.userDetail![CITY]?.toString(); // Ensure city is populated
      gender = widget.userDetail![GENDER]?.toString();
      if (widget.userDetail![DOB] != null && widget.userDetail![DOB] is DateTime) {
        selectedDate = widget.userDetail![DOB] as DateTime?;
      } else if (widget.userDetail![DOB] != null) {
        // Parse date string if needed
        selectedDate = DateTime.tryParse(widget.userDetail![DOB].toString());
      }
      if (selectedDate != null) {
        Age = calculateAge(selectedDate!); // Calculate age from the date of birth
      }
    } else {
      selectedCity = cities[0]; // Default city for new users
    }
  }



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: Text(
          widget.userDetail == null ? 'Register User' : 'Edit User',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SizedBox.expand(
        child: Container(
          color: Colors.pink.shade50,
          child: SingleChildScrollView(
            child: Form(
              key: _fromKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    // Full Name Field
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Valid Full Name';
                        }
                        if (!RegExp(r"^[a-zA-Z\s'-]{3,50}$").hasMatch(value)) {
                          return 'Enter a valid full name (3-50 characters, alphabets only)';
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your full name',
                        hintStyle: TextStyle(color: Colors.blue),
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: Colors.blue),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Icon(Icons.close, size: 16),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'[0-9]'))
                      ],
                    ),
                    SizedBox(height: 10),
        
                    // Email Field
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email Address';
                        }
                        if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                          return 'Enter Valid Email address';
                        }
        
                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.blue),
                        hintText: 'Enter your Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'[A-Z]'))
                      ],
                    ),
                    SizedBox(height: 10),
        
                    // Phone Field
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Phone Number';
                        }
                        if (value.length != 10 && !RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
                          return 'Enter Valid 10-digit Phone Number';
                        }
        
                        return null;
                      },
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        labelStyle: TextStyle(color: Colors.blue),
                        hintStyle: TextStyle(color: Colors.blue),
                        hintText: 'Enter your Phone',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9\+]'))
                      ],
                    ),
                    SizedBox(height: 10),
        
                    // Date of Birth Field
                    // Date of Birth Field
                    TextFormField(
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
                            Age = calculateAge(selectedDate!);
                          });
                        }
                      },
                      validator: (value) {
                        if (selectedDate == null) {
                          return 'Please select your date of birth';
                        }
                        if (!validateAge(selectedDate)) {
                          return 'You must be at least 18 years old to register';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: selectedDate == null ? "Select Date of Birth" : "Date of Birth",
                        hintStyle: TextStyle(color: Colors.blue),
                        labelText: "Date of Birth",
                        labelStyle: TextStyle(color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      controller: TextEditingController(
                        text: selectedDate == null
                            ? '' // No date selected, show empty
                            : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} - Age: $Age", // Show age after date selection
                      ),
                    ),

                    SizedBox(height: 10),
        
                    // Gender Field
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Gender :",
                            style: TextStyle(color: Colors.blue, fontSize: 17),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("Male"),
                        Radio(value: 'Male', groupValue: gender, onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        }),
                        SizedBox(width: 10),
                        Text("Female"),
                        Radio(value: 'Female', groupValue: gender, onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        }),
                      ],
                    ),
                    if (gender == null)
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Select your gender',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    SizedBox(height: 10),
        
                    // City Dropdown
                    // City Dropdown
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Select City :",
                            style: TextStyle(color: Colors.blue, fontSize: 17),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            value: selectedCity,
                            items: cities.map((city) {
                              return DropdownMenuItem<String>(value: city, child: Text(city));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCity = value; // Update selected city
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
        
                    // Password Fields
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.blue),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: passworconformdController,
                      decoration: InputDecoration(
                        hintText: 'Confirm your password',
                        hintStyle: TextStyle(color: Colors.blue),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Confirm Password';
                        }
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
        
                    // Submit Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pink.shade200),
                      onPressed: () {
                        if (_fromKey.currentState!.validate()) {
                          Map<String, dynamic> map = {};
                          map[NAME] = nameController.text.toString();
                          map[EMAIL] = emailController.text.toString();
                          map[PHONENUMBER] = phoneController.text.toString();
                          map[CITY] = selectedCity.toString();
                          map[GENDER] = gender;
                          map[AGE] = Age;
                          map[DOB] = selectedDate;
                          map[PASSWORD]=passwordController.text.toString();
                          Navigator.pop(context, map);
                        }
                      },
                      child: Text(
                        widget.userDetail == null ? 'Submit' : 'Edit',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
