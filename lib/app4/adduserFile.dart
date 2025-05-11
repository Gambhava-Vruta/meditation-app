
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/app4/User.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project/app4/buttomnavigation.dart';

import 'DatabaseService.dart';

class AddUserPage extends StatefulWidget {
  final User? user;

  const AddUserPage({super.key, this.user});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController casteController = TextEditingController();
  final TextEditingController motherTongueController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();

  final List<String> hobbiesList = [
    'Reading',
    'Traveling',
    'Cooking',
    'Sports',
    'Music'
  ];

  final List<String> cities = ['Ahmedabad', 'Surat', 'Rajkot', 'Vadodara'];
  String? selectedCity;
  String? gender;
  DateTime? selectedDate;
  int? age;
  bool isFavourite = false;
 String? addUpadte;
  final _formKey = GlobalKey<FormState>();
  List<String> selectedHobbies = [];
  String diet = ""; // Declare diet as a string
  bool isVeg = false;
  bool isNonVeg = false;
  bool isVegan = false;
  bool _isPasswordVisible = false;
  @override
  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      nameController.text = widget.user!.name;
      emailController.text = widget.user!.email;
      phoneController.text = widget.user!.phoneNumber;
      selectedCity = widget.user!.city;
      gender = widget.user!.gender;
      isFavourite = widget.user!.isFavourite;
      passwordController.text = widget.user!.password;
      confirmPasswordController.text = widget.user!.password;

      // Parse Date of Birth
      if (widget.user!.dob.isNotEmpty) {
        List<String> dateParts = widget.user!.dob.split('/');
        if (dateParts.length == 3) {
          selectedDate = DateTime(
            int.parse(dateParts[2]), // Year
            int.parse(dateParts[1]), // Month
            int.parse(dateParts[0]), // Day
          );
          age = calculateAge(selectedDate!);
        }
      }

      // Convert stored string to list for hobbies
      selectedHobbies = widget.user!.hobbies.isNotEmpty
          ? widget.user!.hobbies.split(',')
          : [];

      heightController.text = widget.user!.height;
      weightController.text = widget.user!.weight.toString();
      maritalStatusController.text = widget.user!.maritalStatus;
      religionController.text = widget.user!.religion;
      casteController.text = widget.user!.caste;
      motherTongueController.text = widget.user!.motherTongue;
      nationalityController.text = widget.user!.nationality;
      stateController.text = widget.user!.state;
      countryController.text = widget.user!.country;
      educationController.text = widget.user!.education;
      professionController.text = widget.user!.profession;
      incomeController.text = widget.user!.income;

      // diet selection
      if (widget.user!.diet.isNotEmpty) {
        diet = widget.user!.diet; // Assign diet as a string value
        isVeg = diet.contains("Vegetarian");
        isNonVeg = diet.contains("Non-Vegetarian");
        isVegan = diet.contains("Vegan");
      }
    }
  }

  String? validateName(String? value) {
    final RegExp nameRegExp = RegExp(r"^[a-zA-Z\s'-]{3,50}$");

    if (value == null || value.isEmpty) {
      return "This field is required.";
    } else if (!nameRegExp.hasMatch(value)) {
      return "Enter a valid full name (3-50 characters, alphabets only).";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required.";
    }

    final String trimmedValue = value.trim(); // Trim spaces
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailRegExp.hasMatch(trimmedValue)) {
      return "Enter a valid email address.";
    }

    return null; // Email is valid
  }

  String? validatePhoneNumber(String? value) {
    final RegExp phoneRegExp = RegExp(r"^\+?[0-9]{10,15}$");
    if (value == null || value.isEmpty) {
      return "This field is required.";
    } else if (!phoneRegExp.hasMatch(value)) {
      return "Enter a valid 10-digit mobile number.";
    }
    return null;
  }
  String? validempty(String? value){
    if (value == null || value.isEmpty) {
      return "This field is required.";
    }
    return null;
  }


  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset('assets/logo/logo.jpg', height: 40), // Updated Logo
            const SizedBox(width: 10),
            Text(
              widget.user == null ? 'Add User' : 'Edit User',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ), // White Text
            ),
          ],
        ),
        centerTitle: true,
        iconTheme:
            const IconThemeData(color: Colors.white), // Matching Icon Color
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFD3C4), // Soft Peach
              Color(0xFFFF8B7B), // Light Pinkish Orange
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(nameController, 'Full Name', Icons.person,
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z\s'-]")),
                        // Allow only letters, spaces, ' and -
                        LengthLimitingTextInputFormatter(50),
                        // Restrict to 50 characters
                      ],
                      validator: validateName),
                  const SizedBox(height: 15),
                  _buildTextField(emailController, 'Email', Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'[A-Z]'))
                        // Prevent uppercase letters
                      ],
                      validator: validateEmail),
                  const SizedBox(height: 15),
                  _buildTextField(phoneController, 'Phone Number', Icons.phone,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        // Only allow numbers
                        LengthLimitingTextInputFormatter(10),
                        // Restrict to 10 digits
                      ],
                      validator: validatePhoneNumber),
                  const SizedBox(height: 15),
                  _buildDatePicker(),
                  const SizedBox(height: 15),
                  _buildGenderSelection(),
                  const SizedBox(height: 15),
                  _buildCityDropdown(),
                  const SizedBox(height: 15),
                  _buildTextField(
                      heightController, 'Height (cm)', Icons.height,validator: validempty),
                  const SizedBox(height: 15),
                  _buildTextField(
                      weightController, 'Weight (kg)', Icons.fitness_center,validator: validempty),
                  const SizedBox(height: 15),
                  _buildTextField(maritalStatusController, 'Marital Status',
                      Icons.favorite,validator: validempty),
                  const SizedBox(height: 15),
                  _buildTextField(
                      religionController, 'Religion', Icons.brightness_6,validator: validempty),
                  const SizedBox(height: 15),
                  _buildTextField(
                      casteController, 'Caste', Icons.account_balance,validator: validempty),
                  const SizedBox(height: 15),
                  _buildTextField(
                      motherTongueController, 'Mother Tongue', Icons.language,validator: validempty),
                  const SizedBox(height: 15),
                  _buildTextField(
                      nationalityController, 'Nationality', Icons.flag,validator: validempty),
                  const SizedBox(height: 15),
                  _buildTextField(stateController, 'State', Icons.map,validator: validempty),
                  const SizedBox(height: 15),
                  _buildTextField(countryController, 'Country', Icons.public,validator: validempty),
                  const SizedBox(height: 15),
                  _buildTextField(
                      educationController, 'Education', Icons.school,validator: validempty),
                  const SizedBox(height: 15),
                  _buildTextField(
                      professionController, 'Profession', Icons.work,validator: validempty),
                  const SizedBox(height: 15),
                  _buildTextField(
                      incomeController, 'Income', Icons.currency_rupee,validator: validempty),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // White background
                      borderRadius: BorderRadius.circular(30),
                      // Rounded corners
                      border: Border.all(
                          color: Colors.grey, width: 1), // Grey border
                    ),
                    padding: EdgeInsets.all(10), // Padding inside the container
                    child: Column(
                      children: [
                        const Text(
                          'Diet Preference',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        _buildDietCheckBoxes(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                          color: Colors.grey, width: 1),
                    ),
                    padding: EdgeInsets.all(10), // Padding inside the container
                    child: Column(
                      children: [
                        Text(
                          'Hobbie',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        _buildHobbiesCheckBoxes(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildPasswordTextField(
                    controller: passwordController,
                    hint: 'Password',
                    icon: Icons.lock,
                    obscureText: !_isPasswordVisible,
                    onEyeIconPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildPasswordTextField(
                    controller: confirmPasswordController,
                    hint: 'Confirm Password',
                    icon: Icons.lock_outline,
                    obscureText: !_isPasswordVisible,
                    onEyeIconPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
                      });
                    },
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          List<String> dietPreferences = [];
                          if (isVeg) dietPreferences.add("Vegetarian");
                          if (isNonVeg) dietPreferences.add("Non-Vegetarian");
                          if (isVegan) dietPreferences.add("Vegan");

                          if (passwordController.text !=
                              confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Passwords do not match")),
                            );
                            return;
                          }

                          final updatedUser = User(
                            id: widget.user?.id,
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            phoneNumber: phoneController.text.trim(),
                            age: age ?? 0,
                            gender: gender ?? "Male",
                            dob: selectedDate != null
                                ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                : "",
                            city: selectedCity ?? cities.first,
                            password: passwordController.text.trim(),
                            isFavourite: isFavourite,
                            hobbies: selectedHobbies.join(','),
                            maritalStatus: maritalStatusController.text.trim(),
                            state: stateController.text.trim(),
                            nationality: nationalityController.text.trim(),
                            motherTongue: motherTongueController.text.trim(),
                            caste: casteController.text.trim(),
                            religion: religionController.text.trim(),
                            height: heightController.text.trim(),
                            weight:
                                int.tryParse(weightController.text.trim()) ?? 0,
                            // Ensure weight is an int
                            education: educationController.text.trim(),
                            income: incomeController.text.trim(),
                            profession: professionController.text.trim(),
                            country: countryController.text.trim(),
                            diet: dietPreferences
                                .join(','), // Save diet as stringupdateUser
                          );

                          try {
                            if (widget.user == null) {
                              await _databaseService.addUser(updatedUser);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("User added successfully!")),
                              );
                            } else {
                              await _databaseService.updateUser(updatedUser);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("User updated successfully!")),
                              );
                            }

                            // Navigate to User List Page after success
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MainScreen(), // Navigate back to main screen after update
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: ${e.toString()}")),
                            );
                          }
                        }
                      },
                      child: Text(
                        widget.user == null ? 'Submit' : 'Update',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, IconData icon,
      {bool obscureText = false,
      String? Function(String?)? validator,
      TextInputType keyboardType = TextInputType.text,
      List<TextInputFormatter>? inputFormatters}) {
    return TextFormField(

      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textCapitalization: TextCapitalization.words

      ,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.deepOrange),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildDietCheckBoxes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          title: const Text('Vegetarian'),
          value: isVeg,
          onChanged: (value) {
            setState(() {
              isVeg = value!;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Non-Vegetarian'),
          value: isNonVeg,
          onChanged: (value) {
            setState(() {
              isNonVeg = value!;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Vegan'),
          value: isVegan,
          onChanged: (value) {
            setState(() {
              isVegan = value!;
            });
          },
        ),
      ],
    );
  }
  Widget _buildPasswordTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool obscureText,
    required VoidCallback onEyeIconPressed,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText, // Toggle password visibility
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.deepOrange),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility, // Toggle eye icon
            color: Colors.grey,
          ),
          onPressed: onEyeIconPressed, // Toggle visibility on icon press
        ),
      ),
      validator: validator,
    );
  }
  Widget _buildDatePicker() {
    return TextFormField(
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
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
        prefixIcon: Icon(Icons.calendar_today, color: Colors.deepOrange),
        hintText: "Date of Birth",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
      ),
      controller: TextEditingController(
        text: selectedDate == null
            ? ''
            : "${DateFormat('dd/MM/yyyy').format(selectedDate!)}  age:$age",

      ),
    );
  }
  // Widget _buildDatePicker() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       TextFormField(
  //         readOnly: true,
  //         onTap: () async {
  //           DateTime? pickedDate = await showDatePicker(
  //             context: context,
  //             initialDate: selectedDate ?? DateTime.now(),
  //             firstDate: DateTime.now().subtract(const Duration(days: 80 * 365)), // Max 80 years ago
  //             lastDate: DateTime.now().subtract(const Duration(days: 18 * 365)), // Min 18 years old
  //           );
  //
  //           if (pickedDate != null) {
  //             int calculatedAge = calculateAge(pickedDate);
  //             if (calculatedAge < 18 || calculatedAge > 80) {
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 const SnackBar(
  //                   content: Text("Age must be between 18 and 80"),
  //                   backgroundColor: Colors.red,
  //                 ),
  //               );
  //               return;
  //             }
  //             setState(() {
  //               selectedDate = pickedDate;
  //               age = calculatedAge;
  //             });
  //           }
  //         },
  //         decoration: InputDecoration(
  //           prefixIcon: const Icon(Icons.calendar_today, color: Colors.deepOrange),
  //           hintText: "Date of Birth",
  //           filled: true,
  //           fillColor: Colors.white,
  //           border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(30),
  //             borderSide: BorderSide.none,
  //           ),
  //         ),
  //         controller: TextEditingController(
  //           text: selectedDate == null
  //               ? ''
  //               : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}  Age: $age",
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildGenderSelection() {
    return FormField<String>(
      validator: (value) {
        if (gender == null) {
          return "Please select your gender";
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              // Moves "Gender" text to the right
              child: Text(
                "Gender",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() {
                      gender = "Male";
                      state.didChange(gender);
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: gender == "Male"
                            ? Colors.deepOrange.shade100
                            : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: Colors.pink.shade400, width: 1.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio<String>(
                            value: "Male",
                            groupValue: gender,
                            activeColor: Colors.deepOrange,
                            onChanged: (value) => setState(() {
                              gender = value;
                              state.didChange(value);
                            }),
                          ),
                          const Text("Male",
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Spacing
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() {
                      gender = "Female";
                      state.didChange(gender);
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: gender == "Female"
                            ? Colors.deepOrange.shade100
                            : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: Colors.pink.shade400, width: 1.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio<String>(
                            value: "Female",
                            groupValue: gender,
                            activeColor: Colors.deepOrange,
                            onChanged: (value) => setState(() {
                              gender = value;
                              state.didChange(value);
                            }),
                          ),
                          const Text("Female",
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 5),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildCityDropdown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        hintText: "Select city",
        prefixIcon: Icon(Icons.location_city, color: Colors.deepOrange),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      dropdownColor: Colors.white,
      value: selectedCity,
      items: cities
          .map((city) => DropdownMenuItem(
                value: city,
                child: Text(city, style: TextStyle(color: Colors.black)),
              ))
          .toList(),
      onChanged: (value) => setState(() => selectedCity = value),
      validator: (value) => value == null ? "Please select a city" : null,
    );
  }

  Widget _buildHobbiesCheckBoxes() {
    return Column(
      children: hobbiesList.map((hobby) {
        return CheckboxListTile(
          title: Text(hobby),
          value: selectedHobbies.contains(hobby),
          onChanged: (value) {
            setState(() {
              if (value!) {
                selectedHobbies.add(hobby);
              } else {
                selectedHobbies.remove(hobby);
              }
            });
          },
        );
      }).toList(),
    );
  }
}
