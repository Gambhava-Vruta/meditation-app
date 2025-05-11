// import 'package:flutter/material.dart';
// import 'databaseservice.dart';
// import 'user.dart';
//
// class AddUserPage extends StatefulWidget {
//   final User? user; // Nullable: Used for editing an existing user
//
//   const AddUserPage({super.key, this.user});
//
//   @override
//   State<AddUserPage> createState() => _AddUserPageState();
// }
//
// class _AddUserPageState extends State<AddUserPage> {
//   final DatabaseService _databaseService = DatabaseService.instance;
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//
//   final List<String> cities = ['Ahmedabad', 'Surat', 'Rajkot', 'Vadodara'];
//   String? selectedCity;
//   String? gender;
//   DateTime? selectedDate;
//   int? age;
//   bool isFavourite = false;
//
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.user != null) {
//       // Pre-fill form for editing
//       nameController.text = widget.user!.name;
//       emailController.text = widget.user!.email;
//       phoneController.text = widget.user!.phoneNumber;
//       selectedCity = widget.user!.city;
//       gender = widget.user!.gender;
//       selectedDate = DateTime.tryParse(widget.user!.dob);
//       age = widget.user!.age;
//       isFavourite = widget.user!.isFavourite;
//     }
//   }
//
//   int calculateAge(DateTime birthDate) {
//     DateTime currentDate = DateTime.now();
//     int age = currentDate.year - birthDate.year;
//     if (currentDate.month < birthDate.month ||
//         (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
//       age--;
//     }
//     return age;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.user == null ? 'Add User' : 'Edit User')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 _buildTextField(nameController, 'Full Name', TextInputType.name,
//                     r"^[a-zA-Z\s'-]{3,50}$", 'Enter a valid full name (3-50 characters)'),
//                 const SizedBox(height: 10),
//                 _buildTextField(emailController, 'Email', TextInputType.emailAddress,
//                     r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', 'Enter a valid email address'),
//                 const SizedBox(height: 10),
//                 _buildTextField(phoneController, 'Phone Number', TextInputType.phone,
//                     r'^[0-9]{10}$', 'Enter a valid 10-digit phone number'),
//                 const SizedBox(height: 10),
//                 _buildDatePicker(),
//                 const SizedBox(height: 10),
//                 _buildGenderSelection(),
//                 const SizedBox(height: 10),
//                 _buildCityDropdown(),
//                 const SizedBox(height: 10),
//                 _buildTextField(passwordController, 'Password', TextInputType.visiblePassword,
//                     r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$', 'Password must be at least 8 characters with letters and numbers',
//                     obscureText: true),
//                 const SizedBox(height: 10),
//                 _buildTextField(confirmPasswordController, 'Confirm Password', TextInputType.visiblePassword,
//                     null, 'Passwords do not match', obscureText: true),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.pink.shade200),
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       if (passwordController.text != confirmPasswordController.text) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("Passwords do not match")),
//                         );
//                         return;
//                       }
//
//                       final updatedUser = User(
//                         id: widget.user?.id, // Preserve existing ID if editing
//                         name: nameController.text.trim(),
//                         email: emailController.text.trim(),
//                         phoneNumber: phoneController.text.trim(),
//                         age: age ?? 0,
//                         gender: gender ?? "Male",
//                         dob: selectedDate != null
//                             ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
//                             : "",
//                         city: selectedCity ?? cities.first,
//                         password: passwordController.text.trim(),
//                         isFavourite: isFavourite,
//                       );
//
//                       if (widget.user == null) {
//                         await _databaseService.addUser(updatedUser);
//                       } else {
//                         await _databaseService.updateUser(updatedUser);
//                       }
//
//                       Navigator.pop(context, updatedUser);
//                     }
//                   },
//                   child: Text(
//                     widget.user == null ? 'Submit' : 'Update',
//                     style: const TextStyle(color: Colors.white, fontSize: 25),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(TextEditingController controller, String label, TextInputType type,
//       String? pattern, String errorMsg, {bool obscureText = false}) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       keyboardType: type,
//       validator: (value) {
//         if (value == null || value.trim().isEmpty) {
//           return "This field is required";
//         }
//         if (pattern != null && !RegExp(pattern).hasMatch(value)) {
//           return errorMsg;
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
//       ),
//     );
//   }
//
//   Widget _buildDatePicker() {
//     return TextFormField(
//       readOnly: true,
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: selectedDate ?? DateTime.now(),
//           firstDate: DateTime(1945),
//           lastDate: DateTime.now(),
//         );
//         if (pickedDate != null) {
//           setState(() {
//             selectedDate = pickedDate;
//             age = calculateAge(selectedDate!);
//           });
//         }
//       },
//       decoration: InputDecoration(
//         labelText: "Date of Birth",
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
//       ),
//       controller: TextEditingController(
//         text: selectedDate == null ? '' : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} - Age: $age",
//       ),
//     );
//   }
//
//   Widget _buildGenderSelection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Gender", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         Row(
//           children: [
//             Expanded(
//               child: RadioListTile<String>(
//                 title: const Text("Male"),
//                 value: "Male",
//                 groupValue: gender,
//                 onChanged: (value) => setState(() => gender = value),
//               ),
//             ),
//             Expanded(
//               child: RadioListTile<String>(
//                 title: const Text("Female"),
//                 value: "Female",
//                 groupValue: gender,
//                 onChanged: (value) => setState(() => gender = value),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCityDropdown() {
//     return DropdownButtonFormField<String>(
//       value: selectedCity,
//       decoration: InputDecoration(
//         labelText: "City",
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
//       ),
//       items: cities.map((city) => DropdownMenuItem(value: city, child: Text(city))).toList(),
//       onChanged: (value) => setState(() => selectedCity = value),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'databaseservice.dart';
// import 'user.dart';
//
// class AddUserPage extends StatefulWidget {
//   final User? user;
//
//   const AddUserPage({super.key, this.user});
//
//   @override
//   State<AddUserPage> createState() => _AddUserPageState();
// }
//
// class _AddUserPageState extends State<AddUserPage> {
//   final DatabaseService _databaseService = DatabaseService.instance;
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//
//   final List<String> cities = ['Ahmedabad', 'Surat', 'Rajkot', 'Vadodara'];
//   String? selectedCity;
//   String? gender;
//   DateTime? selectedDate;
//   int? age;
//   bool isFavourite = false;
//   String? addUpadte;
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   @override
//   void initState() {
//     super.initState();
//     if (widget.user != null) {
//       nameController.text = widget.user!.name;
//       emailController.text = widget.user!.email;
//       phoneController.text = widget.user!.phoneNumber;
//       selectedCity = widget.user!.city;
//       gender = widget.user!.gender;
//       isFavourite = widget.user!.isFavourite;
//       passwordController.text = widget.user!.password;
//       confirmPasswordController.text = widget.user!.password;
//       if (widget.user!.dob.isNotEmpty) {
//         List<String> dateParts = widget.user!.dob.split('/');
//         if (dateParts.length == 3) {
//           selectedDate = DateTime(
//             int.parse(dateParts[2]), // Year
//             int.parse(dateParts[1]), // Month
//             int.parse(dateParts[0]), // Day
//           );
//           age = calculateAge(selectedDate!);
//         }
//       }
//     }
//   }
//   String? validateName(String? value) {
//
//     final RegExp nameRegExp = RegExp(r"^[a-zA-Z\s'-]{3,50}$");
//
//     if (value == null || value.isEmpty) {
//       return "This field is required.";
//     } else if (!nameRegExp.hasMatch(value)) {
//       return "Enter a valid full name (3-50 characters, alphabets only).";
//     }
//     return null;
//   }
//
//   String? validateEmail(String? value) {
//
//     if (value == null || value.trim().isEmpty) {
//       return "This field is required.";
//     }
//
//     final String trimmedValue = value.trim(); // Trim spaces
//     final RegExp emailRegExp =
//     RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
//
//     if (!emailRegExp.hasMatch(trimmedValue)) {
//       return "Enter a valid email address.";
//     }
//
//     return null; // Email is valid
//   }
//
//
//   String? validatePhoneNumber(String? value) {
//     final RegExp phoneRegExp = RegExp(r"^\+?[0-9]{10,15}$");
//     if (value == null || value.isEmpty) {
//       return "This field is required.";
//     } else if (!phoneRegExp.hasMatch(value)) {
//       return "Enter a valid 10-digit mobile number.";
//     }
//     return null;
//   }
//
//   int calculateAge(DateTime birthDate) {
//     DateTime currentDate = DateTime.now();
//     int age = currentDate.year - birthDate.year;
//     if (currentDate.month < birthDate.month ||
//         (currentDate.month == birthDate.month &&
//             currentDate.day < birthDate.day)) {
//       age--;
//     }
//     return age;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Row(
//           children: [
//             Image.asset('assets/logo/logo.jpg', height: 40), // Updated Logo
//             const SizedBox(width: 10),
//             Text(
//               widget.user == null ? 'Add User' : 'Edit User',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ), // White Text
//             ),
//           ],
//         ),
//         centerTitle: true,
//         iconTheme:
//             const IconThemeData(color: Colors.white), // Matching Icon Color
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFFFFD3C4), // Soft Peach
//               Color(0xFFFF8B7B), // Light Pinkish Orange
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildTextField(nameController, 'Full Name', Icons.person,
//                       validator: validateName),
//                   const SizedBox(height: 15),
//                   _buildTextField(emailController, 'Email', Icons.email,
//                       validator: validateEmail),
//                   const SizedBox(height: 15),
//                   _buildTextField(phoneController, 'Phone Number', Icons.phone,
//                       validator: validatePhoneNumber),
//                   const SizedBox(height: 15),
//
//                   _buildDatePicker(),
//                   const SizedBox(height: 15),
//                   _buildGenderSelection(),
//                   const SizedBox(height: 15),
//                   _buildCityDropdown(),
//                   const SizedBox(height: 15),
//                   _buildTextField(passwordController, 'Password', Icons.lock,
//                       obscureText: true),
//                   const SizedBox(height: 15),
//                   _buildTextField(confirmPasswordController, 'Confirm Password',
//                       Icons.lock_outline,
//                       obscureText: true),
//                   const SizedBox(height: 25),
//                   Center(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepOrange,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 50, vertical: 15),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30)),
//                       ),
//                       onPressed: () async {
//                         if (_formKey.currentState!.validate()) {
//                           if (passwordController.text !=
//                               confirmPasswordController.text) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text("Passwords do not match")),
//                             );
//                             return;
//                           }
//
//                           final updatedUser = User(
//                             id: widget.user?.id,
//                             name: nameController.text.trim(),
//                             email: emailController.text.trim(),
//                             phoneNumber: phoneController.text.trim(),
//                             age: age ?? 0,
//                             gender: gender ?? "Male",
//                             dob: selectedDate != null
//                                 ? "${selectedDate!.day}/${selectedDate!.month}   age:${selectedDate!.year}"
//                                 : "",
//                             city: selectedCity ?? cities.first,
//                             password: passwordController.text.trim(),
//                             isFavourite: isFavourite,
//                           );
//
//                           if (widget.user == null) {
//                             await _databaseService.addUser(updatedUser);
//                           } else {
//                             await _databaseService.updateUser(updatedUser);
//                           }
//                           // if (widget.user == null) {
//                           //   const SnackBar(
//                           //       content: Text("User Added successfully!"));
//                           // } else {
//                           //   const SnackBar(
//                           //       content: Text("User Updated successfully!"));
//                           // }
//                           Navigator.pop(context, updatedUser);
//                         }
//                       },
//                       child: Text(
//                         widget.user == null ? 'Submit' : 'Update',
//                         style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(
//       TextEditingController controller, String hint, IconData icon,
//       {bool obscureText = false, String? Function(String?)? validator}) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: Colors.deepOrange),
//         hintText: hint,
//         hintStyle: TextStyle(color: Colors.black54),
//         filled: true,
//         fillColor: Colors.white,
//
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30),
//           borderSide: BorderSide.none,
//         ),
//       ),
//
//       validator: validator,
//     );
//   }
//
//
//   Widget _buildDatePicker() {
//     return TextFormField(
//       readOnly: true,
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: selectedDate ?? DateTime.now(),
//           firstDate: DateTime(1945),
//           lastDate: DateTime.now(),
//         );
//         if (pickedDate != null) {
//           setState(() {
//             selectedDate = pickedDate;
//             age = calculateAge(selectedDate!);
//           });
//         }
//       },
//       decoration: InputDecoration(
//         prefixIcon: Icon(Icons.calendar_today, color: Colors.deepOrange),
//         hintText: "Date of Birth",
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide.none),
//       ),
//       controller: TextEditingController(
//         text: selectedDate == null
//             ? ''
//             : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}/$age",
//       ),
//     );
//   }
//
//   Widget _buildGenderSelection() {
//     return FormField<String>(
//       validator: (value) {
//         if (gender == null) {
//           return "Please select your gender";
//         }
//         return null;
//       },
//       builder: (FormFieldState<String> state) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 20), // Moves "Gender" text to the right
//               child: Text(
//                 "Gender",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//
//             Row(
//               children: [
//                 Expanded(
//                   child: InkWell(
//                     onTap: () => setState(() {
//                       gender = "Male";
//                       state.didChange(gender);
//                     }),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: gender == "Male" ? Colors.deepOrange.shade100 : Colors.white,
//                         borderRadius: BorderRadius.circular(30),
//                         border: Border.all(color: Colors.pink.shade400, width: 1.5),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Radio<String>(
//                             value: "Male",
//                             groupValue: gender,
//                             activeColor: Colors.deepOrange,
//                             onChanged: (value) => setState(() {
//                               gender = value;
//                               state.didChange(value);
//                             }),
//                           ),
//                           const Text("Male", style: TextStyle(color: Colors.black)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10), // Spacing
//                 Expanded(
//                   child: InkWell(
//                     onTap: () => setState(() {
//                       gender = "Female";
//                       state.didChange(gender);
//                     }),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: gender == "Female" ? Colors.deepOrange.shade100 : Colors.white,
//                         borderRadius: BorderRadius.circular(30),
//                         border: Border.all(color: Colors.pink.shade400, width: 1.5),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Radio<String>(
//                             value: "Female",
//                             groupValue: gender,
//                             activeColor: Colors.deepOrange,
//                             onChanged: (value) => setState(() {
//                               gender = value;
//                               state.didChange(value);
//                             }),
//                           ),
//                           const Text("Female", style: TextStyle(color: Colors.black)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             if (state.hasError)
//               Padding(
//                 padding: const EdgeInsets.only(top: 5, left: 5),
//                 child: Text(
//                   state.errorText!,
//                   style: const TextStyle(color: Colors.red, fontSize: 12),
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }
//
//
//   Widget _buildCityDropdown() {
//     return DropdownButtonFormField(
//       decoration: InputDecoration(
//         hintText: "Select city",
//         prefixIcon: Icon(Icons.location_city, color: Colors.deepOrange),
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30),
//           borderSide: BorderSide.none,
//         ),
//       ),
//       dropdownColor: Colors.white,
//       value: selectedCity,
//       items: cities
//           .map((city) => DropdownMenuItem(
//                 value: city,
//                 child: Text(city, style: TextStyle(color: Colors.black)),
//               ))
//           .toList(),
//       onChanged: (value) => setState(() => selectedCity = value),
//       validator: (value) => value == null ? "Please select a city" : null,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'databaseservice.dart';
import 'user.dart';

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

  final List<String> cities = ['Ahmedabad', 'Surat', 'Rajkot', 'Vadodara'];
  String? selectedCity;
  String? gender;
  DateTime? selectedDate;
  int? age;
  bool isFavourite = false;
  String? addUpadte;
  final _formKey = GlobalKey<FormState>();

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
                        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s'-]")), // Allow only letters, spaces, ' and -
                        LengthLimitingTextInputFormatter(50),  // Restrict to 50 characters
                      ],
                      validator: validateName),

                  const SizedBox(height: 15),
                  _buildTextField(emailController, 'Email', Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'[A-Z]')) // Prevent uppercase letters
                      ],
                      validator: validateEmail),

                  const SizedBox(height: 15),
                  _buildTextField(phoneController, 'Phone Number', Icons.phone,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // Only allow numbers
                        LengthLimitingTextInputFormatter(10),  // Restrict to 10 digits
                      ],
                      validator: validatePhoneNumber),

                  const SizedBox(height: 15),

                  _buildDatePicker(),
                  const SizedBox(height: 15),
                  _buildGenderSelection(),
                  const SizedBox(height: 15),
                  _buildCityDropdown(),
                  const SizedBox(height: 15),
                  _buildTextField(passwordController, 'Password', Icons.lock,
                      obscureText: true),
                  const SizedBox(height: 15),
                  _buildTextField(confirmPasswordController, 'Confirm Password',
                      Icons.lock_outline,
                      obscureText: true),
                  const SizedBox(height: 25),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
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
                          );

                          if (widget.user == null) {
                            await _databaseService.addUser(updatedUser);
                          } else {
                            await _databaseService.updateUser(updatedUser);
                          }
                          // if (widget.user == null) {
                          //   const SnackBar(
                          //       content: Text("User Added successfully!"));
                          // } else {
                          //   const SnackBar(
                          //       content: Text("User Updated successfully!"));
                          // }
                          Navigator.pop(context, updatedUser);
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
            : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}/$age",
      ),
    );
  }

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
              padding: EdgeInsets.only(left: 20), // Moves "Gender" text to the right
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: gender == "Male" ? Colors.deepOrange.shade100 : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.pink.shade400, width: 1.5),
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
                          const Text("Male", style: TextStyle(color: Colors.black)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: gender == "Female" ? Colors.deepOrange.shade100 : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.pink.shade400, width: 1.5),
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
                          const Text("Female", style: TextStyle(color: Colors.black)),
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
}